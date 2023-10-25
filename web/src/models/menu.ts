// 菜单model
export interface Menu {
  menuId: string;
  parentId?: string;
  menuName: string;
  component?: string;
  path?: string;
  query?: string;
  redirect?: string;
  params?: string;
  menuType?: string;
  hidden?: number;
  cached?: number;
  icon?: string;
  sort?: number;
  status?: number;
  description?: string;
  createdUser?: string;
  updatedUser?: string;
  createdAt?: string;
  updatedAt?: string;
  children?: Menu[];
}

export interface MenuList {
  menus: Menu[];
}

/**
 * 查询对象
 */
export interface MenuQueryParams {
  menuName: string;
  status: string;
}

export interface Meta {
  cached: boolean;
  icon: string;
  title: string;
  query: string;
  hidden: boolean;
  permissions: string[];
}

export interface MenuRoute {
  name: string;
  path: string;
  component: string;
  redirect: string;
  meta: Meta;
  children?: MenuRoute[];
}
