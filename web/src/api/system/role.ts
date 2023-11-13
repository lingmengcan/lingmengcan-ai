import { Role, RoleList, RoleParams } from '@/models/role';
import { Method } from '@/utils/axios/types';
import http, { Result } from '@/utils/http';

// 获取角色列表
export const getRoleList = (data: RoleParams) =>
  http.request<Result<RoleList>>('role/list', Method.POST, data);

// 改变状态
export const changeRoleStatus = (data: Role) =>
  http.request<Result<Role>>('role/change-status', Method.POST, data);

// 获取角色菜单列表
export const getRoleMenuIds = (roleId: string) =>
  http.request<Result<string[]>>('role/menus', Method.POST, { roleId });
