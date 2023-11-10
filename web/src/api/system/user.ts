import { LoginParams, UserRight } from '@/models/user';
import { Method } from '@/utils/axios/types';
import http, { httpNoAuth, Result } from '@/utils/http';

/**
 * 获取验证码
 * @returns
 */
export const getCaptche = () => {
  return httpNoAuth.request<Result<UserRight>>('captcha', Method.GET);
};

/**
 * 登录获取token
 * @param data
 * @returns
 */
export const login = (data: LoginParams) => {
  return httpNoAuth.request<Result<string>>('login', Method.POST, data);
};

/**
 * 根据token获取登录用户信息
 * @returns
 */
export const getUserInfo = () => {
  return http.request<Result<UserRight>>('user/info', Method.GET);
};
