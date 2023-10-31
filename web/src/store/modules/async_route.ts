import { toRaw } from 'vue';
import { defineStore } from 'pinia';
import { RouteRecordRaw } from 'vue-router';
import { store } from '@/store';
import { defaultRoutes } from '@/router/index';
import { generateDynamicRoutes } from '@/router/generator';

// interface TreeHelperConfig {
//   id: string;
//   children: string;
//   pid: string;
// }

// const DEFAULT_CONFIG: TreeHelperConfig = {
//   id: 'id',
//   children: 'children',
//   pid: 'pid',
// };

// const getConfig = (config: Partial<TreeHelperConfig>) => Object.assign({}, DEFAULT_CONFIG, config);

export interface AsyncRouteState {
  menus: RouteRecordRaw[];
  routers: any[];
  routersAdded: any[];
  keepAliveComponents: string[];
  isDynamicRouteAdded: boolean;
}

// function filter<T = any>(
//   tree: T[],
//   func: (n: T) => boolean,
//   config: Partial<TreeHelperConfig> = {},
// ): T[] {
//   config = getConfig(config);
//   const children = config.children as string;

//   function listFilter(list: T[]) {
//     return list
//       .map((node: any) => ({ ...node }))
//       .filter((node) => {
//         node[children] = node[children] && listFilter(node[children]);
//         return func(node) || (node[children] && node[children].length);
//       });
//   }

//   return listFilter(tree);
// }

export const useAsyncRouteStore = defineStore({
  id: 'app-async-route',
  state: (): AsyncRouteState => ({
    menus: [],
    routers: defaultRoutes,
    routersAdded: [],
    keepAliveComponents: [],
    // Whether the route has been dynamically added
    isDynamicRouteAdded: false,
  }),
  getters: {
    getMenus(): RouteRecordRaw[] {
      return this.menus;
    },
    getIsDynamicRouteAdded(): boolean {
      return this.isDynamicRouteAdded;
    },
  },
  actions: {
    getRouters() {
      return toRaw(this.routersAdded);
    },
    setDynamicRouteAdded(added: boolean) {
      this.isDynamicRouteAdded = added;
    },
    // 设置动态路由
    setRouters(routers: RouteRecordRaw[]) {
      this.routersAdded = routers;
      this.routers = defaultRoutes.concat(routers);
    },
    setMenus(menus: RouteRecordRaw[]) {
      // 设置动态路由
      this.menus = menus;
    },
    setKeepAliveComponents(compNames: string[]) {
      // 设置需要缓存的组件
      this.keepAliveComponents = compNames;
    },
    async generateRoutes(data) {
      let accessedRouters: RouteRecordRaw[];
      const permissionsList = data.permissions ?? [];

      const routeFilter = (route) => {
        const { meta } = route;
        const { permissions } = meta || {};
        if (!permissions) return true;

        const requiredPermissions = permissions.split(',');
        console.log('permissions', permissionsList);
        return permissionsList.some((item) => requiredPermissions.includes(item.value));
      };

      accessedRouters = await generateDynamicRoutes();

      //如果是写死的路由，过滤账户是否拥有某一个权限，并将菜单从加载列表移除
      //accessedRouters = filter(asyncRoutes, routeFilter);
      console.log(accessedRouters);

      accessedRouters = accessedRouters.filter(routeFilter);
      this.setRouters(accessedRouters);
      this.setMenus(accessedRouters);
      return toRaw(accessedRouters);
    },
  },
});

// Need to be used outside the setup
export function useAsyncRoute() {
  return useAsyncRouteStore(store);
}
