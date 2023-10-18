import http, { Result } from '@/utils/http';
import { Method } from 'axios-mapper';

/**
 * @description: 根据用户id获取用户菜单
 */
export const adminMenus = () => http.request<Result<any>>('menus', Method.GET);
