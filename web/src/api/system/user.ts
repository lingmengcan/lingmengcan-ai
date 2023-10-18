import http, { Result, httpConfig } from '@/utils/http';
import { ContentType, Method } from 'axios-mapper';

/**
 * 登录获取token
 * @param data
 * @returns
 */
export const login = (data) =>
  http.request<Result<string>>('login', Method.POST, data, ContentType.json, httpConfig(false));
