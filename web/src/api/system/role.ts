import { RoleList, RoleParams } from '@/models/role';
import { Method } from '@/utils/axios/types';
import http, { Result } from '@/utils/http';

// 获取角色列表
export const getRoleList = (data: RoleParams) =>
  http.request<Result<RoleList>>('role/list', Method.POST, data);
