import { ChatGlm6BLLM2 } from '@/llms/chatglm2';

import { ChatPromptTemplate, HumanMessagePromptTemplate, MessagesPlaceholder } from '@langchain/core/prompts';
import { StringOutputParser } from '@langchain/core/output_parsers';
import { ChatMessageHistory } from '@langchain/community/stores/message/in_memory';

export class Chatglm2Service {
  //自由对话
  async chat(apiUrl: string, message: string, messageHistory: ChatMessageHistory, temperature: number) {
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
