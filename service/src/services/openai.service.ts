import { LLMChain } from 'langchain/chains';
import { ChatOpenAI } from 'langchain/chat_models/openai';

import { HumanMessagePromptTemplate, ChatPromptTemplate } from 'langchain/prompts';

export class OpenaiService {
  //自由对话
  async chatOpenAI(body) {
    //根据内容回答问题
    //const app = await NestFactory.create(AppModule);
    const { message, api_key, basePath } = body;
    console.log('step1', message);

    const chat = new ChatOpenAI(
      { temperature: 0.01, openAIApiKey: api_key },
      { basePath: basePath.replace(/\/+$/, '') },
    );
    const translationPrompt = ChatPromptTemplate.fromMessages([
      /*   SystemMessagePromptTemplate.fromTemplate(
          ), */
      /* new MessagesPlaceholder("history"), */
      HumanMessagePromptTemplate.fromTemplate('{text}'),
    ]);
    /* const memory = new BufferMemory({ returnMessages: true, memoryKey: "history" });
        console.log(1111111,memory); */

    /* const chain = new ConversationChain({  prompt: translationPrompt,llm: chat, memory: new BufferMemory({ returnMessages: true, memoryKey: "history" }), }); */
    const chain = new LLMChain({
      prompt: translationPrompt,
      llm: chat,
    });
    const response = await chain.call({
      text: message,
    });
    //response.push({link: '/static' +fileSourceStr.split("\\")[fileSourceStr.split("\\").length-1]})

    return response;
  }
}
