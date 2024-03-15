import { TextLoader } from 'langchain/document_loaders/fs/text';
import { DocxLoader } from 'langchain/document_loaders/fs/docx';
import { PDFLoader } from 'langchain/document_loaders/fs/pdf';
import { RecursiveCharacterTextSplitter } from 'langchain/text_splitter';
import { Chroma } from '@langchain/community/vectorstores/chroma';
import { OpenAIEmbeddings } from '@langchain/openai';

import { MemoryVectorStore } from 'langchain/vectorstores/memory';
import { v4 as uuidv4 } from 'uuid';
import { File } from '@/entities/file.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { DocumentLoader } from 'langchain/dist/document_loaders/base';
import { ConfigService } from '@nestjs/config';
import { Message } from '@/entities/message.entity';
import { MessageService } from './message.service';
import { extname } from 'path';
import { ChatService } from './chat.service';
import { FileDto } from '@/dtos/file.dto';

export class FileService {
  constructor(
    @InjectRepository(File)
    private repository: Repository<File>,
    private dataSource: DataSource,
    private configService: ConfigService,
    private readonly messageService: MessageService,
    private readonly chatService: ChatService,
  ) {}

  //上传文件向量化
  async refactorVectorStore(
    fileType: string,
    filePath: string,
    basePath: string,
    openAIApiKey: string,
  ) {
    let loader: DocumentLoader;

    switch (fileType) {
      case '.pdf':
        loader = new PDFLoader(filePath);
        break;
      case '.txt':
        loader = new TextLoader(filePath);
        break;
      case '.docx':
        loader = new DocxLoader(filePath);
        break;
      default:
        throw new Error(`Unknown file type: ${fileType}`);
    }
    // Split the docs into chunks
    // 文本切割,将文档拆分为块
    const textsplitter = new RecursiveCharacterTextSplitter({
      separators: ['\n\n', '\n', '。', '！', '？'],
      chunkSize: 400,
      chunkOverlap: 100,
    });

    const docs = await loader.loadAndSplit(textsplitter);

    console.log(docs);

    // Load the docs into the vector store
    // 加载向量存储库
    const vectorStore = await Chroma.fromDocuments(
      docs,
      new OpenAIEmbeddings({ openAIApiKey }, { basePath }),
      {
        collectionName: 'a-test-collection',
        url: 'http://localhost:9000',
      },
    );

    // const vectorStore = await MemoryVectorStore.fromDocuments(
    //   docs,
    //   new AlibabaTongyiEmbeddings({}),
    // );

    return vectorStore;
  }

  // 读取文档
  async chatfile(userName: string, dto: FileDto, file: Express.Multer.File) {
    let basePath = '';
    let openAIApiKey = 'EMPTY';
    const llm: string = 'ChatGLM3';
    switch (llm) {
      case 'ChatGLM2':
        // const apiUrl = this.configService.get<string>('llms.chatglm_6b_server_url');
        // const res = new ChatglmService();
        // return res.chat(apiUrl, message.messageText, messageHistory, temperature);
        break;
      case 'ChatGLM3':
        basePath = this.configService.get<string>('llms.chatglm3_6b_server_url');
        break;
      case 'gpt-3.5-turbo':
        basePath = this.configService.get<string>('llms.openai_proxy_url');
        openAIApiKey = this.configService.get<string>('llms.openai_api_key');
        break;
    }

    const fileType = extname(file.filename);
    // 上传文件
    await this.addFile(
      dto.conversationId,
      file.originalname,
      file.size,
      fileType,
      file.path,
      userName,
    );

    console.log(1);

    const vectorStore = await this.refactorVectorStore(fileType, file.path, basePath, openAIApiKey);
    console.log(2);
    return this.chatService.chatfileOpenAi('格式', 0.5, basePath, openAIApiKey, vectorStore);
  }

  // //文档问答
  // async chatfileOpenAi(
  //   message: string,
  //   temperature: number,
  //   basePath: string,
  //   openAIApiKey: string,
  //   vectorStore: VectorStore,
  // ) {
  //   console.log('3');
  //   const result = await vectorStore.similaritySearch(message, 1);
  //   console.log('4', result);

  //   // const fileSourceStr = result[0].metadata.source;

  //   //根据内容回答问题
  //   // Instantiate your model and prompt.
  //   const llm = new ChatOpenAI({ openAIApiKey, temperature, streaming: true }, { basePath });
  //   const prompt = ChatPromptTemplate.fromMessages([
  //     SystemMessagePromptTemplate.fromTemplate(
  //       `基于已知内容, 回答用户问题。如果无法从中得到答案，请说'没有足够的相关信息'已知内容:${result[0].pageContent}`,
  //     ),
  //     HumanMessagePromptTemplate.fromTemplate('{input}'),
  //   ]);

  //   // const chain2 = new LLMChain({
  //   //   prompt,
  //   //   llm,
  //   // });
  //   // const response = await chain2.call({
  //   //   text: message,
  //   // });

  //   // console.log(response);
  //   const outputParser = new StringOutputParser();

  //   const chain = prompt.pipe(llm).pipe(outputParser);

  //   const stream = await chain.stream({
  //     // history: await messageHistory.getMessages(),
  //     input: message,
  //   });

  //   return stream;
  // }

  /**
   * 新增
   *
   * @param menu 信息
   * @return 结果
   */
  async addFile(
    conversationId: string,
    fileName: string,
    fileSize: number,
    fileType: string,
    path: string,
    username: string,
  ) {
    const fileId = uuidv4();

    const entity = new File();
    entity.fileId = fileId;
    entity.conversationId = conversationId;
    entity.fileName = fileName;
    entity.fileSize = fileSize;
    entity.fileType = fileType;
    entity.path = path;
    entity.status = 0;
    entity.createdUser = username;
    entity.createdAt = new Date();
    entity.updatedAt = new Date();
    // return this.repository.save(entity);

    // Transactions 启动
    /// create a new query runner
    const queryRunner = this.dataSource.createQueryRunner();

    // establish real database connection using our new query runner
    await queryRunner.connect();

    // lets now open a new transaction:
    await queryRunner.startTransaction();

    try {
      // execute some operations on this transaction:
      await queryRunner.manager.save(entity);

      const message = new Message();
      message.conversationId = conversationId;
      message.fileId = fileId;
      message.messageText = fileName;
      message.sender = 'System';
      message.completed = 1;
      message.status = 0;

      this.messageService.addMessage(message);

      // commit transaction now:
      await queryRunner.commitTransaction();
    } catch (err) {
      // since we have errors let's rollback changes we made
      await queryRunner.rollbackTransaction();
    } finally {
      // you need to release query runner which is manually created:
      await queryRunner.release();
    }
  }
}
