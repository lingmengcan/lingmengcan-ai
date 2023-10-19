// 用户model
export interface User {
  userId: string;
  deptId: string;
  deptName?: string;
  userName: string;
  chineseName: string;
  email: string;
  phone: string;
  sex: string;
  avatar?: string;
  password: string;
  loginIp?: string;
  loginDate?: string;
  status: number;
  description?: string;
  createdUser: string;
  updatedUser: string;
  createdAt?: string;
  updatedAt?: string;
}

// 列表对象
export interface UserList {
  list: User[];
  page: number;
  pageSize: number;
  count: number;
}

/**
 * 登录表单对象
 */
export interface LoginParams {
  username: string;
  password: string;
  code: string;
}

/**
 * 用户权限
 */
export interface UserRight {
  user: User;
  roles: string[];
  permissions: string[];
}
