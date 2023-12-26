import { Prompt } from '@/models/chat';
import { Method } from '@/utils/axios/types';
import http, { Result } from '@/utils/http';

// 新增
export const addPrompt = (data: Prompt) =>
  http.request<Result<Prompt>>('prompt/add', Method.POST, data);

// 修改
export const editPrompt = (data: Prompt) =>
  http.request<Result<Prompt>>('prompt/edit', Method.POST, data);
