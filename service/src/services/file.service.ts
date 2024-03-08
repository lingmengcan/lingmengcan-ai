import * as fs from 'fs';
import { DirectoryLoader } from 'langchain/document_loaders/fs/directory';
import { TextLoader } from 'langchain/document_loaders/fs/text';
import { DocxLoader } from 'langchain/document_loaders/fs/docx';
import { PDFLoader } from 'langchain/document_loaders/fs/pdf';
import { RecursiveCharacterTextSplitter } from 'langchain/text_splitter';
import { MemoryVectorStore } from 'langchain/vectorstores/memory';
import { OpenAIEmbeddings } from '@langchain/openai';

export class FileService {
  //上传文件向量化
  async refactorVectorStore() {
    const loader = new DirectoryLoader('./upload-files', {
      '.txt': (path) => new TextLoader(path),
      '.docx': (path) => new DocxLoader(path),
      '.pdf': (path) => new PDFLoader(path),
    });
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
    return vectorStore;
  }

  //获取本地文件列表
  async getFileList() {
    const directoryPath = './upload-files';
    const files = fs.readdirSync(directoryPath);
    return files;
  }

  //删除文件
  async deleteFile(fileName) {
    const directoryPath = './fileUpload';
    fs.rmSync(`${directoryPath}/${fileName}`);
  }
}
