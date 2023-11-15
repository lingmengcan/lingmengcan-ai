import { Menu, MenuParams, MenuRoute } from '@/models/menu';
import { Method } from '@/utils/axios/types';
import http, { Result } from '@/utils/http';

/**
 * @description: 根据用户id获取用户菜单
 */
export const getMenus = () => {
  return http.request<Result<Menu[]>>('menu/list', Method.POST);
};

export const getMenuRoutes = () => {
  return http.request<Result<MenuRoute[]>>('menu/routes', Method.GET);
};

// 获取菜单列表
export const getMenuList = (data: MenuParams) =>
  http.request<Result<Menu[]>>('menu/list', Method.POST, data);

// 删除
export const deleteMenu = (menuId: string) =>
  http.request<Result<Menu>>('menu/del', Method.POST, { menuId });
