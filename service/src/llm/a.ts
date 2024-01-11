import axios from 'axios';
import { BaseChatModel } from 'langchain/chat_models/base';
import { AIMessage, BaseMessage, ChatResult } from 'langchain/schema';

export class ChatGlm6BLLM2 extends BaseChatModel {
  modelName = 'chatglm';
  baseUrl;
  temperature;
  max_length;
  top_p;
  streaming;
  history;

  constructor(fields = {}) {
    super(fields);

    const {
      baseUrl = '',
      temperature = 0.7,
      max_length = 2048,
      top_p = 0.7,
      streaming = false,
      history = [],
    } = fields;

    this.baseUrl = baseUrl;
    this.temperature = temperature;
    this.max_length = max_length;
    this.top_p = top_p;
    this.streaming = streaming;
    this.history = history;
  }

  invocationParams() {
    return {
      model: this.modelName,
      baseUrl: this.baseUrl,
      temperature: this.temperature,
      top_p: this.top_p,
      max_length: this.max_length,
      streaming: this.streaming,
      history: this.history,
    };
  }

  identifyingParams() {
    return {
      model_name: this.modelName,
      ...this.invocationParams(),
    };
  }

  formatMessagesAsPrompt(messages) {
    return (
      messages
        .map((message) => {
          const messagePrompt = getAnthropicPromptFromMessage(message._getType());
          return `${messagePrompt} ${message.text}`;
        })
        .join('') + '\n\nAssistant:'
    );
  }

  async _generate(messages: BaseMessage[]): Promise<ChatResult> {
    const params = this.invocationParams();
    const res: any = await this.completionWithRetry({
      ...params,
      prompt: this.formatMessagesAsPrompt(messages),
    });

    const generations: any = [
      {
        text: res.response,
        message: new AIMessage(res.response),
      },
    ];
    return {
      generations,
    };
  }

  async completionWithRetry(request) {
    const makeCompletionRequest = async () => {
      try {
        const res: any = await axios.post(this.baseUrl, request, {
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

  _combineLLMOutput(...llmOutputs) {
    return llmOutputs.reduce(
      (acc, llmOutput) => {
        if (llmOutput && llmOutput.tokenUsage) {
          acc.tokenUsage.completionTokens += llmOutput.tokenUsage.completionTokens ?? 0;
          acc.tokenUsage.promptTokens += llmOutput.tokenUsage.promptTokens ?? 0;
          acc.tokenUsage.totalTokens += llmOutput.tokenUsage.totalTokens ?? 0;
        }
        return acc;
      },
      {
        tokenUsage: {
          completionTokens: 0,
          promptTokens: 0,
          totalTokens: 0,
        },
      },
    );
  }
}

function getAnthropicPromptFromMessage(type) {
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
