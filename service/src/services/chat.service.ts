import { Injectable } from '@nestjs/common';
import { ChatDto } from '@/dtos/chat.dto';
import { MessageService } from './message.service';
import { Message } from '@/entities/message.entity';
import { ConversationService } from './conversation.service';
import { ConfigService } from '@nestjs/config';
import {
  ChatPromptTemplate,
  HumanMessagePromptTemplate,
  MessagesPlaceholder,
  SystemMessagePromptTemplate,
} from '@langchain/core/prompts';
import { StringOutputParser } from '@langchain/core/output_parsers';
import { ChatOpenAI, OpenAIEmbeddings } from '@langchain/openai';
import { ChatMessageHistory } from '@langchain/community/stores/message/in_memory';
import { AIMessage, HumanMessage } from '@langchain/core/messages';
import { VectorStore } from '@langchain/core/vectorstores';
import { Chroma } from '@langchain/community/vectorstores/chroma';
import { LlmService } from './llm.service';
import { HttpsProxyAgent } from 'https-proxy-agent';

@Injectable()
export class ChatService {
  constructor(
    private readonly llmService: LlmService,
    private readonly messageService: MessageService,
    private readonly conversationService: ConversationService,
    private readonly configService: ConfigService,
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

  // 调用大模型对话
  async chatLlm(message: Message, temperature: number, llm: string) {
    const conversation = await this.conversationService.findByConversationId(
      message.conversationId,
    );

    // 变更大模型后更新
    if (temperature !== conversation.temperature || llm !== conversation.llm) {
      conversation.temperature = temperature;
      conversation.llm = llm;
      this.conversationService.updateConversation(conversation);
    }

    // 获取模型信息
    const model = await this.llmService.findByModelName(llm);

    // This is where you will store your chat history.
    const messageHistory = new ChatMessageHistory();

    conversation.messages.forEach((item) => {
      // 获取历史消息，如果消息时间小于当前消息，并且文件id相同，则认为是历史消息，当时文件回答时，只获取当前文件的消息
      if (item.createdAt < new Date(message.createdAt) && message.fileId === item.fileId) {
        if (item.sender === 'Human') {
          messageHistory.addMessage(new HumanMessage(item.messageText));
        } else if (item.sender === 'Assistant') {
          messageHistory.addMessage(new AIMessage(item.messageText));
        }
      }
    });

    if (message.fileId) {
      const vectorStore = await Chroma.fromExistingCollection(
        new OpenAIEmbeddings(
          { openAIApiKey: model.apiKey, modelName: model.defaultEmbeddingModel },
          { basePath: model.baseUrl },
        ),
        {
          collectionName: message.fileId,
          url: this.configService.get<string>('chromadb.db'),
        },
      );

      return this.chatfileOpenAi(
        message.messageText,
        temperature,
        messageHistory,
        model.baseUrl,
        model.apiKey,
        vectorStore,
      );
    } else {
      return this.chatOpenAi(
        message.messageText,
        temperature,
        messageHistory,
        model.baseUrl,
        model.apiKey,
      );
    }
  }

  //自由对话
  async chatOpenAi(
    message: string,
    temperature: number,
    messageHistory: ChatMessageHistory,
    basePath: string,
    openAIApiKey: string,
  ) {
    // const proxyAgent = new HttpsProxyAgent('http://127.0.0.1:8899');

    //根据内容回答问题
    // Instantiate your model and prompt.
    const llm = new ChatOpenAI({ openAIApiKey, temperature, streaming: true }, { basePath });

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

  //文档问答
  async chatfileOpenAi(
    message: string,
    temperature: number,
    messageHistory: ChatMessageHistory,
    basePath: string,
    openAIApiKey: string,
    vectorStore: VectorStore,
  ) {
    const result = await vectorStore.similaritySearch(message, 1);

    //根据内容回答问题
    // Instantiate your model and prompt.
    const llm = new ChatOpenAI({ openAIApiKey, temperature, streaming: true }, { basePath });
    const prompt = ChatPromptTemplate.fromMessages([
      SystemMessagePromptTemplate.fromTemplate(
        `基于已知内容, 回答用户问题。如果无法从中得到答案，请说'没有足够的相关信息'已知内容:${result[0].pageContent}`,
      ),
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
