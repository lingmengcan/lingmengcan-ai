import { TextLoader } from 'langchain/document_loaders/fs/text';
import { DocxLoader } from 'langchain/document_loaders/fs/docx';
import { PDFLoader } from 'langchain/document_loaders/fs/pdf';
import { RecursiveCharacterTextSplitter } from 'langchain/text_splitter';
import { MemoryVectorStore } from 'langchain/vectorstores/memory';
import { OpenAIEmbeddings } from '@langchain/openai';
import { v4 as uuidv4 } from 'uuid';
import { File } from '@/entities/file.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { DocumentLoader } from 'langchain/dist/document_loaders/base';
import { ConfigService } from '@nestjs/config';
import { Message } from '@/entities/message.entity';
import { MessageService } from './message.service';

export class FileService {
  constructor(
    @InjectRepository(File)
    private repository: Repository<File>,
    private dataSource: DataSource,
    private configService: ConfigService,
    private readonly messageService: MessageService,
  ) {}

  //上传文件向量化
  async refactorVectorStore(fileType: string, filePath: string) {
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

    const openAIApiKey = this.configService.get<string>('llms.openai_api_key');
    // Load the docs into the vector store
    // 加载向量存储库
    const vectorStore = await MemoryVectorStore.fromDocuments(
      docs,
      new OpenAIEmbeddings({ openAIApiKey }),
    );

    return vectorStore;
  }

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
