import { Txt2ImgParams, Txt2ImgResponse } from '@/models/draw';
import { Method } from '@/utils/http/axiosplus';
import http, { Result } from '@/utils/http';

// 获取列表
export const txt2img = (data: Txt2ImgParams) =>
  http.request<Result<Txt2ImgResponse>>('draw/txt2img', Method.POST, data);
