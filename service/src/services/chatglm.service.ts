import { ChatGlm6BLLM2 } from '@/llms/chatglm';
import { LLMChain } from 'langchain/chains';
import { GlobalService } from './global';
import {
  ChatPromptTemplate,
  HumanMessagePromptTemplate,
  SystemMessagePromptTemplate,
} from '@langchain/core/prompts';

export class ChatglmService {
  //文档问答
  async chatfile(body) {
    const { apiUrl, message, history } = body;
    console.log('step1', message, history);

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
  async chat(apiUrl: string, message: string, history: any, temperature: number) {
    const llm = new ChatGlm6BLLM2({
      apiUrl,
      streaming: true,
      temperature: temperature,
      history: history,
    });

    const prompt = ChatPromptTemplate.fromMessages([
      HumanMessagePromptTemplate.fromTemplate('{input}'),
    ]);

    // const outputParser = new StringOutputParser();
    // const chain = prompt.pipe(llm).pipe(outputParser);
    // const stream = await chain.stream({
    //   input: message,
    // });
    // for await (const item of stream) {
    //   console.log('stream item:', item);
    // }

    // const response = new Response(stream, {
    //   headers: { 'content-type': 'text/plain; charset=utf-8' },
    // });

    const chain = new LLMChain({
      prompt,
      llm,
    });

    // Call the chain with the inputs and a callback for the streamed tokens
    const response = await chain.call(
      {
        input: message,
      },
      [
        {
          handleLLMNewToken(token: string) {
            // process.stdout.write(token);
            console.log({ token });
          },
        },
      ],
    );

    // console.log({ res });

    // const response = await chain.invoke({
    //   input: message,
    // });

    console.log(response);

    return response;
  }
}
