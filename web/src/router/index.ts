import { RouteRecordRaw, createRouter, createWebHistory } from 'vue-router';
import { LoginRoute, RedirectRoute, RootRoute } from '@/router/constant';

export interface ModuleType {
  default: Array<RouteRecordRaw> | RouteRecordRaw;
}

const modules = import.meta.glob<ModuleType>('./modules/**/*.ts', { eager: true });

const routeModuleList: RouteRecordRaw[] = Object.values(modules).flatMap((module) => {
  const mod = module.default ?? {};
  return Array.isArray(mod) ? mod : [mod];
});

function sortRoute(a, b): number {
  return (a.meta?.sort ?? 0) - (b.meta?.sort ?? 0);
}

routeModuleList.sort(sortRoute);

//需要验证权限
export const asyncRoutes = [...routeModuleList];
console.log(asyncRoutes);

//普通路由 无需验证权限
export const constantRouter: RouteRecordRaw[] = [LoginRoute, RootRoute, RedirectRoute];
console.log(constantRouter);

const router = createRouter({
  history: createWebHistory(),
  routes: constantRouter,
  strict: true,
  scrollBehavior: () => ({ left: 0, top: 0 }),
});

export default router;
