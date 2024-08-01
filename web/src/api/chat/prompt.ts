import { Prompt } from '@/models/chat';
import { Method } from '@/utils/http/axiosplus';
import http, { Result } from '@/utils/http';

// 获取对话列表
export const getPromptList = () => http.request<Result<Prompt[]>>('prompt/list', Method.POST);

// 新增
export const addPrompt = (data: Prompt) => http.request<Result<Prompt>>('prompt/add', Method.POST, data);

// 修改
export const editPrompt = (data: Prompt) => http.request<Result<Prompt>>('prompt/edit', Method.POST, data);

// 改变状态为删除
export const changePromptStatus = (data: Prompt) =>
  http.request<Result<Prompt>>('prompt/change-status', Method.POST, data);
