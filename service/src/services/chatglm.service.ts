import { ChatGlm6BLLM2 } from '@/llms/chatglm';
import { LLMChain } from 'langchain/chains';
import { GlobalService } from './global';
import {
  ChatPromptTemplate,
  HumanMessagePromptTemplate,
  MessagesPlaceholder,
  SystemMessagePromptTemplate,
} from '@langchain/core/prompts';
import { StringOutputParser } from '@langchain/core/output_parsers';
import { ChatMessageHistory } from '@langchain/community/stores/message/in_memory';

export class ChatglmService {
  //文档问答
  async chatfile(body) {
    const { apiUrl, message, history } = body;

    const vectorStore = GlobalService.globalVar;
    const result = await vectorStore.similaritySearch(message, 1);

    const fileSourceStr = result[0].metadata.source;
    const chat = new ChatGlm6BLLM2({
      apiUrl,
      temperature: 0.01,
      history,
    });
    const translationPrompt = ChatPromptTemplate.fromMessages([
      SystemMessagePromptTemplate.fromTemplate(
        `基于已知内容, 回答用户问题。如果无法从中得到答案，请说'没有足够的相关信息'。已知内容:${result[0].pageContent}`,
      ),
      /* new MessagesPlaceholder("history"), */
      HumanMessagePromptTemplate.fromTemplate('{text}'),
    ]);

    const chain = new LLMChain({
      prompt: translationPrompt,
      llm: chat,
    });
    const response = await chain.call({
      text: message,
    });
    return {
      response: response,
      url: '/static/' + fileSourceStr.split('\\')[fileSourceStr.split('\\').length - 1],
    };
  }

  //自由对话
  async chat(
    apiUrl: string,
    message: string,
    messageHistory: ChatMessageHistory,
    temperature: number,
  ) {
    const llm = new ChatGlm6BLLM2({
      apiUrl,
      temperature: temperature,
      streaming: true,
    });

    const prompt = ChatPromptTemplate.fromMessages([
      new MessagesPlaceholder('history'),
      HumanMessagePromptTemplate.fromTemplate('{input}'),
    ]);

    const outputParser = new StringOutputParser();

    const chain = prompt.pipe(llm).pipe(outputParser);

    const stream = await chain.stream({
      history: await messageHistory.getMessages(),
      input: message,
    });

    return stream;
  }
}
