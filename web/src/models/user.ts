// 用户model
export interface User {
  userId: string;
  userName: string;
  nickName: string;
  email: string;
  phone: string;
  sex: string;
  avatar?: string;
  password?: string;
  loginIp?: string;
  loginDate?: string;
  status: number;
  description?: string;
  createdUser?: string;
  updatedUser?: string;
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
 * 查询对象
 */
export interface UserParams {
  userName: string;
  nickName: string;
  phone: string;
  status: string | null;
  page: number;
  pageSize: number;
}

/**
 * 登录表单对象
 */
export interface LoginParams {
  username: string;
  password: string;
  captcha: string;
}

/**
 * 用户权限
 */
export interface UserRight {
  user: User;
  permissions: string[];
}

/**
 * 用户密码重置
 */
export interface UserResetPwd {
  userId: string;
  password: string;
}
