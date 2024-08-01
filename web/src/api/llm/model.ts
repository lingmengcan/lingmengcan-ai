import { Llm, LlmList, LlmParams } from '@/models/llm';
import { Method } from '@/utils/http/axiosplus';
import http, { Result } from '@/utils/http';

// 获取列表
export const getLlmList = (data: LlmParams) => http.request<Result<LlmList>>('model/llm-list', Method.POST, data);

// 获取列表
export const getLlmListByType = (modelType: string) =>
  http.request<Result<Llm[]>>('model/llm-list-by-type', Method.POST, { modelType });

// 新增
export const addLlm = (data: Llm) => http.request<Result<Llm>>('model/llm-add', Method.POST, data);

// 修改
export const editLlm = (data: Llm) => http.request<Result<Llm>>('model/llm-edit', Method.POST, data);

// 改变状态
export const changeLlmStatus = (data: Llm) => http.request<Result<Llm>>('model/llm-change-status', Method.POST, data);
