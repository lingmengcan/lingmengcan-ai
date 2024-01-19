import { Embeddings } from '@langchain/core/embeddings';
import { OpenAIEmbeddings } from '@langchain/openai';

export class EmbeddingManager {
  private static instance: EmbeddingManager;
  private embeddings: { [key: string]: Embeddings } = {};
  private openAIKey: string | undefined;
  private cohereKey: string | undefined;
  currentEmbeddingName: 'default' | 'cohere' | 'openai' = 'default';
  private constructor(init?: {
    openAIKey?: string;
    cohereKey?: string;
    embeddingName?: 'default' | 'cohere' | 'openai';
  }) {
    // console.log('init', this.openAIKey , this.cohereKey);
    // this.embeddings.default = new T2VLargeChineseEmbeddings();
    this.openAIKey = init?.openAIKey || process.env.OPENAI_API_KEY;

    this.openAIKey &&
      (this.embeddings.openai = new OpenAIEmbeddings({ openAIApiKey: this.openAIKey }));

    this.currentEmbeddingName = init?.embeddingName || 'default';
  }
  public static getInstance(init?: {
    openAIKey?: string;
    cohereKey?: string;
    embeddingName?: 'default' | 'cohere' | 'openai';
  }): EmbeddingManager {
    if (!EmbeddingManager.instance) {
      if (!init) {
        EmbeddingManager.instance = new EmbeddingManager();
      } else {
        EmbeddingManager.instance = new EmbeddingManager(init);
      }
    }
    return EmbeddingManager.instance;
  }
  public static getEmbedding(embeddingName: string): Embeddings {
    return EmbeddingManager.getInstance().embeddings[embeddingName];
  }
  public static getCurrentEmbedding(): Embeddings {
    console.log('getCurrentEmbedding', EmbeddingManager.getInstance().currentEmbeddingName);

    return EmbeddingManager.getInstance().embeddings[
      EmbeddingManager.getInstance().currentEmbeddingName
    ];
  }
  public static setCurrentEmbedding(embeddingName: 'default' | 'cohere' | 'openai'): {
    status: 'success' | 'error';
  } {
    if (['default', 'cohere', 'openai'].includes(embeddingName)) {
      console.log('setCurrentEmbedding', embeddingName);

      EmbeddingManager.getInstance().currentEmbeddingName = embeddingName;
      return {
        status: 'success',
      };
    } else {
      throw new Error('embedding embeddingName not found');
    }
  }
  public static async resetEmbedding(init?: {
    openAIKey?: string;
    cohereKey?: string;
    embeddingName?: 'default' | 'cohere' | 'openai';
  }) {
    EmbeddingManager.instance = new EmbeddingManager(init);
  }
}
