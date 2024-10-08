import { MediaParams, Txt2ImgParams, GenerateImgRes, MediaList, ControlNetPreprocessor } from '@/models/draw';
import { Method } from '@/utils/http/axiosplus';
import http, { Result } from '@/utils/http';

// 文生图
export const txt2img = (data: Txt2ImgParams) => http.request<Result<GenerateImgRes>>('draw/txt2img', Method.POST, data);

// 获取媒体列表
export const getMediaList = (data: MediaParams) => http.request<Result<MediaList>>('draw/list', Method.POST, data);

// 获取control net 预处理器列表
export const getPreprocessorList = () =>
  http.request<Result<ControlNetPreprocessor[]>>('draw/control-net-preprocessor-list', Method.POST);
