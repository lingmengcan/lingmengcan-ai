import { TextLoader } from 'langchain/document_loaders/fs/text';
import { DocxLoader } from 'langchain/document_loaders/fs/docx';
import { PDFLoader } from 'langchain/document_loaders/fs/pdf';
import { RecursiveCharacterTextSplitter } from 'langchain/text_splitter';
import { Chroma } from '@langchain/community/vectorstores/chroma';
import { OpenAIEmbeddings } from '@langchain/openai';

import { v4 as uuidv4 } from 'uuid';
import { File } from '@/entities/file.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { DocumentLoader } from 'langchain/dist/document_loaders/base';
import { ConfigService } from '@nestjs/config';
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
    fileId: string,
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

    const modelName = 'bge-large-zh-v1.5';

    // Load the docs into the vector store
    // 加载向量存储库
    await Chroma.fromDocuments(
      docs,
      new OpenAIEmbeddings({ openAIApiKey, modelName }, { basePath }),
      {
        collectionName: fileId,
        url: this.configService.get<string>('chromadb.db'),
      },
    );

    // const vectorStore = await MemoryVectorStore.fromDocuments(
    //   docs,
    //   new OpenAIEmbeddings({ openAIApiKey }, { basePath }),
    // );
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
    const fileId = await this.addFile(
      dto.conversationId,
      file.originalname,
      file.size,
      fileType,
      file.path,
      userName,
    );

    await this.refactorVectorStore(fileId, fileType, file.path, basePath, openAIApiKey);

    return fileId;
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
    this.repository.save(entity);

    return fileId;
  }
}
