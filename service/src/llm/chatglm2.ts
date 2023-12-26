import axios from 'axios';
import { BaseChatModel } from 'langchain/chat_models/base';
import { AIMessage, BaseMessage, ChatResult } from 'langchain/schema';

export class ChatGlm6BLLM2 extends BaseChatModel {
  modelName: 'chatglm';
  temperature: number;
  max_length: number;
  top_p: number;
  streaming: boolean;
  history: [][];

  constructor(fields?) {
    super(fields ?? {});

    this.modelName = 'chatglm';
    this.temperature = fields?.temperature ?? 0.7;
    this.max_length = fields?.max_length ?? 2048;
    this.top_p = fields?.top_p ?? 0.7;
    this.streaming = fields?.streaming ?? false;
    this.history = fields?.history ?? [];
  }

  invocationParams() {
    return {
      model: this.modelName,
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
        const res: any = await axios.post(
          process.env.CHATGLM_6B_SERVER_URL ?? 'http://localhost',
          request,
          {
            headers: {
              'Content-Type': 'application/json',
            },
            // responseType: this.streaming ? 'stream' : 'json',
          },
        );

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
