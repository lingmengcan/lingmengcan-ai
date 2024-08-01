// 用户model
export interface DiffusionModel {
  modelId: string;
  baseModelId?: string;
  modelName: string;
  modelCode?: string;
  modelType?: string;
  modelTypeName?: string;
  modelCover?: string;
  tags?: string;
  status: string;
  description?: string;
  createdUser?: string;
  updatedUser?: string;
  createdAt?: string;
  updatedAt?: string;
}

// 列表对象
export interface DiffusionModelList {
  list: DiffusionModel[];
  page: number;
  pageSize: number;
  count: number;
}

/**
 * 查询对象
 */
export interface DiffusionModelParams {
  modelName: string;
  modelType: string;
  page: number;
  pageSize: number;
}
