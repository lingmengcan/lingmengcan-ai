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
  permissions?: string;
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

/**
 * 查询对象
 */
export interface MenuParams {
  menuName: string;
  status: string | null;
}

export interface Meta {
  //缓存该路由
  cached: boolean;
  //菜单图标
  icon: string;
  //菜单名称 一般必填
  title: string;
  //禁用菜单
  disabled: boolean;
  //隐藏菜单
  hidden: boolean;
  //排序越小越排前
  sort: number;
  query: string;
  // 当路由设置了该属性，则会高亮相对应的侧边栏。
  // 这在某些场景非常有用，比如：一个列表页路由为：/list/basic-list
  // 点击进入详情页，这时候路由为/list/basic-info/1，但你想在侧边栏高亮列表的路由，就可以进行如下设置
  // 注意是配置高亮路由 `name`，不是path
  activeMenu: string;
  //内联外部地址
  frameSrc: string;
  //菜单包含权限集合，满足其中一个就会显示
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
