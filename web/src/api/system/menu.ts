import http, { Result } from '@/utils/http';
import { Method } from 'axios-mapper';

/**
 * @description: 根据用户id获取用户菜单
 */
export const getMenus = () => http.request<Result<any>>('menu/list', Method.GET);
