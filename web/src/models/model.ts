// 用户model
export interface Model {
  modelId: string;
  modelName: string;
  modelType?: string;
  modelTypeName?: string;
  baseUrl?: string;
  apiKey?: string;
  defaultEmbeddingModel?: string;
  sort: number;
  status: number | null;
  description?: string;
  createdUser?: string;
  updatedUser?: string;
  createdAt?: string;
  updatedAt?: string;
}

// 列表对象
export interface ModelList {
  list: Model[];
  page: number;
  pageSize: number;
  count: number;
}

/**
 * 查询对象
 */
export interface ModelParams {
  modelName: string;
  modelType: string;
  page: number;
  pageSize: number;
}
