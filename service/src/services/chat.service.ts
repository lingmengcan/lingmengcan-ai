import { Injectable } from '@nestjs/common';
import { ChatglmService } from './chatglm.service';
import { ChatDto } from '@/dtos/chat.dto';
import { MessageService } from './message.service';
import { Message } from '@/entities/message.entity';
import { ConversationService } from './conversation.service';
import { ConfigService } from '@nestjs/config';
import {
  ChatPromptTemplate,
  HumanMessagePromptTemplate,
  MessagesPlaceholder,
} from '@langchain/core/prompts';
import { StringOutputParser } from '@langchain/core/output_parsers';
import { ChatOpenAI } from '@langchain/openai';

@Injectable()
export class ChatService {
  constructor(
    private readonly messageService: MessageService,
    private readonly conversationService: ConversationService,
    private configService: ConfigService,
  ) {}

  //自由对话
  async chat(dto: ChatDto) {
    const { message, temperature, llm } = dto;
    return this.chatLlm(message, temperature, llm);
  }

  //重新回答
  async regenerate(dto: ChatDto) {
    const { temperature, llm } = dto;

    // 获取问题
    const message = await this.messageService.findByMessageId(dto.message.previousId);
    return this.chatLlm(message, temperature, llm);
  }

  //文档问答
  async chatfile(body) {
    const res = new ChatglmService();
    return res.chatfile(body);
  }

  // 调用大模型对话
  async chatLlm(message: Message, temperature: number, llm: string) {
    // const conversation = await this.conversationService.findByConversationId(
    //   message.conversationId,
    // );

    // if (temperature !== conversation.temperature || llm !== conversation.llm) {
    //   conversation.temperature = temperature;
    //   conversation.llm = llm;
    //   this.conversationService.updateConversation(conversation);
    // }

    // // 带入历史对话
    const history = [];
    // conversation.messages.forEach((humanMessage) => {
    //   if (humanMessage.sender === 'Human' && humanMessage.createdAt < message.createdAt) {
    //     const aiMessage = conversation.messages.find(
    //       (msg) => msg.previousId === humanMessage.messageId && msg.sender === 'Assistant',
    //     );

    //     history.push([`Human:${humanMessage.messageText}`, `Assistant:${aiMessage?.messageText}`]);
    //   }
    // });

    switch (llm) {
      case 'ChatGLM3':
        const apiUrl = this.configService.get<string>('llms.chatglm_6b_server_url');
        const res = new ChatglmService();
        return res.chat(apiUrl, message.messageText, history, temperature);
      case 'GPT-3.5':
        return this.chatOpenAi(message.messageText, temperature, history);
    }
  }

  //自由对话
  async chatOpenAi(message: string, temperature: number, history: any) {
    //根据内容回答问题
    const openAIApiKey = this.configService.get<string>('llms.openai_api_key');

    console.log(1, openAIApiKey);

    // Instantiate your model and prompt.
    const llm = new ChatOpenAI(
      { openAIApiKey, temperature, streaming: true },
      { basePath: 'https://oai.hconeai.com/v1' },
    );

    const prompt = ChatPromptTemplate.fromMessages([
      new MessagesPlaceholder('history'),
      HumanMessagePromptTemplate.fromTemplate('{input}'),
    ]);

    const outputParser = new StringOutputParser();

    const chain = prompt.pipe(llm).pipe(outputParser);

    const stream = await chain.stream({
      history,
      input: message,
    });

    return stream;
  }
}
