import { Model, ModelList, ModelParams } from '@/models/model';
import { Method } from '@/utils/axios/types';
import http, { Result } from '@/utils/http';

// 获取列表
export const getModelList = (data: ModelParams) =>
  http.request<Result<ModelList>>('model/list', Method.POST, data);

// 获取列表
export const getModelListByType = (modelType: string) =>
  http.request<Result<Model[]>>('model/list-by-type', Method.POST, { modelType });

// 新增
export const addModel = (data: Model) =>
  http.request<Result<Model>>('model/add', Method.POST, data);

// 修改
export const editModel = (data: Model) =>
  http.request<Result<Model>>('model/edit', Method.POST, data);

// 改变状态
export const changeModelStatus = (data: Model) =>
  http.request<Result<Model>>('model/change-status', Method.POST, data);
