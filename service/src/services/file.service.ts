import * as fs from 'fs';
import { TextLoader } from 'langchain/document_loaders/fs/text';
import { DocxLoader } from 'langchain/document_loaders/fs/docx';
import { PDFLoader } from 'langchain/document_loaders/fs/pdf';
import { RecursiveCharacterTextSplitter } from 'langchain/text_splitter';
import { MemoryVectorStore } from 'langchain/vectorstores/memory';
import { OpenAIEmbeddings } from '@langchain/openai';
import { FileDto } from '@/dtos/file.dto';
import { v4 as uuidv4 } from 'uuid';
import { File } from '@/entities/file.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { extname } from 'path';
import { DocumentLoader } from 'langchain/dist/document_loaders/base';

export class FileService {
  constructor(
    @InjectRepository(File)
    private repository: Repository<File>,
    private dataSource: DataSource,
  ) {}

  //上传文件向量化
  async refactorVectorStore(dto: FileDto, username: string, file: Express.Multer.File) {
    const fileType = extname(file.filename);

    let loader: DocumentLoader;

    switch (fileType) {
      case '.pdf':
        loader = new PDFLoader(file.path);
        break;
      case '.txt':
        loader = new TextLoader(file.path);
        break;
      case '.docx':
        loader = new DocxLoader(file.path);
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
    // Load the docs into the vector store
    // 加载向量存储库
    const vectorStore = await MemoryVectorStore.fromDocuments(docs, new OpenAIEmbeddings());

    // 添加文件信息到数据库
    this.addFile(dto.conversationId, file.originalname, file.size, fileType, file.path, username);
    return vectorStore;
  }

  //获取本地文件列表
  async getLocalFileList() {
    const directoryPath = './upload-files';
    const files = fs.readdirSync(directoryPath);
    return files;
  }

  //删除文件
  async deleteLocalFile(fileName: string) {
    const directoryPath = './fileUpload';
    fs.rmSync(`${directoryPath}/${fileName}`);
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
    return this.repository.save(entity);
  }
}
