import { MediaParams, Txt2ImgParams, Txt2ImgResponse, MediaList } from '@/models/draw';
import { Method } from '@/utils/http/axiosplus';
import http, { Result } from '@/utils/http';

// 文生图
export const txt2img = (data: Txt2ImgParams) =>
  http.request<Result<Txt2ImgResponse>>('draw/txt2img', Method.POST, data);

// 获取列表
export const getMediaList = (data: MediaParams) => http.request<Result<MediaList>>('draw/list', Method.POST, data);
