import { Role, RoleList, RoleMenus, RoleParams } from '@/models/role';
import { Method } from '@/utils/http/axiosplus';
import http, { Result } from '@/utils/http';

// 获取角色列表
export const getRoleList = (data: RoleParams) => http.request<Result<RoleList>>('role/list', Method.POST, data);

// 改变状态
export const changeRoleStatus = (data: Role) => http.request<Result<Role>>('role/change-status', Method.POST, data);

// 获取角色菜单列表
export const getRoleMenuIds = (roleId: string) => http.request<Result<string[]>>('role/menus', Method.POST, { roleId });

// 变更角色所有权限
export const changeRoleMenus = (data: RoleMenus) => http.request<Result<Role>>('role/change-menus', Method.POST, data);

// 新增
export const addRole = (data: Role) => http.request<Result<Role>>('role/add', Method.POST, data);

// 修改
export const editRole = (data: Role) => http.request<Result<Role>>('role/edit', Method.POST, data);
