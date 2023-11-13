// 角色model
export interface Role {
  roleId: string;
  roleName: string;
  roleCode: string;
  sort: number;
  status: number;
  description?: string;
  createdUser?: string;
  updatedUser?: string;
  createdAt?: string;
  updatedAt?: string;
}

// 列表对象
export interface RoleList {
  list: Role[];
  page: number;
  pageSize: number;
  count: number;
}

/**
 * 角色查询对象
 */
export interface RoleParams {
  roleName: string;
  roleCode: string;
  status: string | undefined;
  page: number;
  pageSize: number;
}

/**
 * 批量删除对象
 */
export interface RoleDelBatch {
  roleIds: string[];
}

/**
 * 角色用户查询对象
 */
export interface RoleUserQueryParams {
  userName: string;
  phone: string;
  roleId: string;
  page: number;
  pageSize: number;
}

/**
 * 授权用户
 */
export interface RoleUsers {
  roleId: string;
  userIds: string[];
}

/**
 * 授权菜单
 */
export interface RoleMenus {
  roleId: string;
  menuIds: string[];
}
