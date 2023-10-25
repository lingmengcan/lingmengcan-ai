import { MenuList, MenuRoute } from '@/models/menu';
import http, { Result } from '@/utils/http';
import { Method } from 'axios-mapper';

/**
 * @description: 根据用户id获取用户菜单
 */
export const getMenus = () => http.request<Result<MenuList>>('menu/list', Method.GET);

export const getMenuRoutes = () => http.request<Result<MenuRoute[]>>('menu/routes', Method.GET);
