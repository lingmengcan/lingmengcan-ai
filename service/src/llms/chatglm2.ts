import axios from 'axios';
import { BaseChatModel, BaseChatModelParams } from '@langchain/core/language_models/chat_models';
import { AIMessage, AIMessageChunk, BaseMessage } from '@langchain/core/messages';
import { ChatGeneration, ChatGenerationChunk, ChatResult } from '@langchain/core/outputs';
import { CallbackManagerForLLMRun } from '@langchain/core/callbacks/manager';

export interface ChatGlmLLMInput extends BaseChatModelParams {
  /** Model name to use.
   * @default "chatglm"
   */
  modelName?: string;

  /** API URL */
  apiUrl?: string;

  /** Whether to stream the results or not. Defaults to false. */
  streaming?: boolean;

  /** Amount of randomness injected into the response. Ranges
   * from 0 to 1. Use temp closer to 0 for analytical /
   * multiple choice, and temp closer to 1 for creative
   * and generative tasks.
   */
  temperature?: number;

  /** A maximum number of tokens to generate before stopping. */
  maxTokens?: number;

  /** Only sample from the top K options for each subsequent
   * token. Used to remove "long tail" low probability
   * responses. Defaults to -1, which disables it.
   */
  topK?: number;

  /** Does nucleus sampling, in which we compute the
   * cumulative distribution over all the options for each
   * subsequent token in decreasing probability order and
   * cut it off once it reaches a particular probability
   * specified by top_p. Defaults to -1, which disables it.
   * Note that you should either alter temperature or top_p,
   * but not both.
   */
  topP?: number;

  /** A list of strings upon which to stop generating.
   * You probably want `["\n\nHuman:"]`, as that's the cue for
   * the next turn in the dialog agent.
   */
  stopSequences?: string[];

  invocationKwargs?: Record<string, any>;

  history?: [][];
}

export class ChatGlm6BLLM2 extends BaseChatModel {
  modelName = 'chatglm';

  apiUrl?: string;

  streaming = false;

  temperature = 0.5;

  maxTokens = 2048;

  topK = 0.7;

  topP = 0.7;

  stopSequences?: string[];

  invocationKwargs?: Record<string, any>;

  history: [][] = [];

  constructor(fields: ChatGlmLLMInput = {}) {
    super(fields);

    this.modelName = fields?.modelName ?? this.modelName;
    this.apiUrl = fields?.apiUrl;
    this.streaming = fields?.streaming ?? this.streaming;
    this.temperature = fields?.temperature ?? this.temperature;
    this.maxTokens = fields?.maxTokens ?? this.maxTokens;
    this.topK = fields?.topK ?? this.topK;
    this.topP = fields?.topP ?? this.topP;
    this.history = fields?.history ?? this.history;

    this.stopSequences = fields?.stopSequences ?? this.stopSequences;
    this.invocationKwargs = fields?.invocationKwargs ?? {};
  }

  /**
   * Get the parameters used to invoke the model
   */
  invocationParams(options?: this['ParsedCallOptions']) {
    // 使用解构赋值从options中提取所需属性
    const { stop } = options ?? {};

    // 如果提供了stop选项，则在其后添加默认停止序列
    const stopSequences = stop
      ? stop.concat('User aborted the request.')
      : (this.stopSequences ?? ['User aborted the request.']);

    return {
      model: this.modelName,
      stream: this.streaming,
      temperature: this.temperature,
      max_tokens: this.maxTokens,
      top_k: this.topK,
      top_p: this.topP,
      history: this.history,
      stop_sequences: stopSequences,
      ...this.invocationKwargs,
    };
  }

  /**
   * Get the identifying parameters for the model
   */
  identifyingParams() {
    return {
      model_name: this.modelName,
      ...this.invocationParams(),
    };
  }

  async *_streamResponseChunks(
    messages: BaseMessage[],
    options: this['ParsedCallOptions'],
    runManager?: CallbackManagerForLLMRun,
  ): AsyncGenerator<ChatGenerationChunk> {
    const params = this.invocationParams(options);

    const stream = await this.createStreamWithRetry({
      ...params,
      prompt: this.formatMessagesAsPrompt(messages),
    });

    while (true) {
      const { value, done } = await stream.read();
      if (done) {
        break;
      }

      // 将 Uint8Array 转换为字符串
      const chunk = new TextDecoder().decode(value);
      console.log(chunk + '   1   ');
      // 这里假设每个数据块都是一个完整的 JSON 字符串
      // 如果实际数据不是这样，您可能需要进行更复杂的处理，比如累积数据直到可以解析为 JSON
      try {
        // const parsedData = JSON.parse(chunkStr);

        // 从解析的数据中提取所需信息
        // const responseText = parsedData.response;

        // 创建并 yield 一个新的 ChatGenerationChunk 实例
        yield new ChatGenerationChunk({
          message: new AIMessageChunk({
            content: chunk,
          }),
          text: chunk,
        });

        // 如果有回调管理器，处理新令牌
        await runManager?.handleLLMNewToken(chunk);
      } catch (error) {
        console.error('Error parsing JSON from chunk', error);
      }
    }
  }

  /**
   * Formats messages as a prompt for the model.
   * @param messages The base messages to format as a prompt.
   * @returns The formatted prompt.
   */
  formatMessagesAsPrompt(messages: BaseMessage[]) {
    return (
      messages
        .map((message) => {
          const messagePrompt = getPromptFromMessage(message);
          return `${messagePrompt} ${message.content}`;
        })
        .join('') + '\n\nAssistant:'
    );
  }

  async _generate(
    messages: BaseMessage[],
    options: this['ParsedCallOptions'],
    runManager?: CallbackManagerForLLMRun,
  ): Promise<ChatResult> {
    const params = this.invocationParams(options);

    let res;
    if (params.stream) {
      const stream = this._streamResponseChunks(messages, options, runManager);
      for await (const chunk of stream) {
        res = chunk;
      }
    } else {
      res = await this.completionWithRetry({
        ...params,
        prompt: this.formatMessagesAsPrompt(messages),
      });
    }

    const generations: ChatGeneration[] = (res.response ?? '').split('\n\nAssistant:').map((message) => ({
      text: message,
      message: new AIMessage(message),
    }));

    return {
      generations,
    };
  }

  /**
   * Creates a streaming request with retry.
   * @param request The parameters for creating a completion.
   * @returns A streaming request.
   */
  protected async createStreamWithRetry(request) {
    const makeCompletionRequest = async () => {
      try {
        const res = await fetch(this.apiUrl, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(request),
        });

        if (!res.ok) throw new Error(`HTTP error! status: ${res.status}`);

        const reader = res.body?.getReader();

        return reader;
      } catch (error) {
        console.error('Error in completion request:', error);
        throw error;
      }
    };
    return this.caller.call(makeCompletionRequest);
  }

  /** @ignore */
  async completionWithRetry(request) {
    const makeCompletionRequest = async () => {
      try {
        const res = await axios.post(this.apiUrl, request, {
          headers: {
            'Content-Type': 'application/json',
          },
        });

        return res;
      } catch (error) {
        console.error('Error in completion request:', error);
        throw error;
      }
    };
    return this.caller.call(makeCompletionRequest).then((res) => {
      return res.data;
    });
  }

  _llmType() {
    return 'chatglm';
  }

  /** @ignore */
  _combineLLMOutput() {
    return [];
  }
}

/**
 * Gets the chatglm prompt from a base message.
 * @param message The base message from which to get the chatglm prompt.
 * @returns The chatglm prompt from the base message.
 */
function getPromptFromMessage(message: BaseMessage) {
  const type = message._getType();
  switch (type) {
    case 'ai':
      return '\n\nAssistant:';
    case 'human':
      return '\n\nHuman:';
    case 'system':
      return '';
    default:
      throw new Error(`Unknown message type: ${type}`);
  }
}
