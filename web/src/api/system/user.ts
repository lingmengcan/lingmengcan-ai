import { LoginParams, UserRight } from '@/models/user';
import http, { Result, httpConfig } from '@/utils/http';
import { ContentType, Method } from 'axios-mapper';

/**
 * 获取验证码
 * @returns
 */
export const getCaptche = () =>
  http.request<Result<UserRight>>(
    'captcha',
    Method.GET,
    undefined,
    ContentType.json,
    httpConfig(false),
  );

/**
 * 登录获取token
 * @param data
 * @returns
 */
export const login = (data: LoginParams) =>
  http.request<Result<string>>('login', Method.POST, data, ContentType.json, httpConfig(false));

/**
 * 根据token获取登录用户信息
 * @returns
 */
export const getUserInfo = () => http.request<Result<UserRight>>('user/info', Method.GET);
