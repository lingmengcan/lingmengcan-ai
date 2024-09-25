// 用户model
export interface Llm {
  modelId: string;
  modelName: string;
  modelType?: string;
  modelTypeName?: string;
  baseUrl?: string;
  apiKey?: string;
  apiType?: string;
  defaultEmbeddingModel?: string;
  status: string;
  description?: string;
  createdUser?: string;
  updatedUser?: string;
  createdAt?: string;
  updatedAt?: string;
}

// 列表对象
export interface LlmList {
  list: Llm[];
  page: number;
  pageSize: number;
  count: number;
}

/**
 * 查询对象
 */
export interface LlmParams {
  modelName: string;
  modelType: string;
  page: number;
  pageSize: number;
}
