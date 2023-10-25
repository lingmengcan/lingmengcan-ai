/**
 * 路由配置信息
 *
 */
export class Route {
  /**
   * 路由名字
   */
  name: string;

  /**
   * 路由地址
   */
  path: string;

  /**
   * 重定向地址，当设置 noRedirect 的时候该路由在面包屑导航中不可被点击
   */
  redirect: string;

  /**
   * 组件地址
   */
  component: string;

  /**
   * 路由参数：如 {"id": 1, "name": "ry"}
   */
  query: string;

  /**
   * 其他元素
   */
  meta: Meta;

  /**
   * 子路由
   */
  children: Route[];
}

/**
 * 路由元信息
 *
 */
export class Meta {
  /**
   * 设置该路由在侧边栏和面包屑中展示的名字
   */
  title: string;

  /**
   * 设置该路由的图标，对应路径src/assets/icons/svg
   */
  icon: string;

  /**
   * 设置为true，则会被 <keep-alive>缓存
   */
  cached: boolean;

  /**
   * 参数
   */
  query: string;

  /**
   * 是否隐藏路由，当设置 true 的时候该路由不会再侧边栏出现
   */
  hidden: boolean;
}
