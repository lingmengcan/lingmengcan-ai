import { DiffusionModel, DiffusionModelList, DiffusionModelParams } from '@/models/diffusion-model';
import { Method } from '@/utils/http/axiosplus';
import http, { Result } from '@/utils/http';

// 获取列表
export const getDiffusionModelList = (data: DiffusionModelParams) =>
  http.request<Result<DiffusionModelList>>('model/diffusion-list', Method.POST, data);

// 获取列表
export const getDiffusionModelListByType = (modelType: string) =>
  http.request<Result<DiffusionModel[]>>('model/diffusion-list-by-type', Method.POST, { modelType });

// 新增
export const addDiffusionModel = (data: DiffusionModel) =>
  http.request<Result<DiffusionModel>>('model/diffusion-add', Method.POST, data);

// 修改
export const editDiffusionModel = (data: DiffusionModel) =>
  http.request<Result<DiffusionModel>>('model/diffusion-edit', Method.POST, data);

// 改变状态
export const changeDiffusionModelStatus = (data: DiffusionModel) =>
  http.request<Result<DiffusionModel>>('model/diffusion-change-status', Method.POST, data);
