import { useUserStore } from '@/store/modules/user';
/**
 * 检查权限
 * @param accesses
 */
function _somePermissions(permission: string) {
  const userStore = useUserStore();
  const permissions = userStore.permissions;

  return permissions.some((item) => {
    return item === permission;
  });
}

/**
 * 判断是否存在权限
 * 可用于 v-if 显示逻辑
 * */
export function hasPermission(permission: string): boolean {
  if (!permission || !permission.length) return false;
  return _somePermissions(permission);
}

/**
 * 是否包含指定的所有权限
 * @param accesses
 */
export function hasPermissionAnd(permissions: string[]): boolean {
  if (Array.isArray(permissions)) {
    return permissions.every((item) => {
      return _somePermissions(item);
    });
  }
  throw new Error(`[hasPermissionAnd]: ${permissions} should be a array !`);
}

/**
 * 是否包含其中某个权限
 * @param accesses
 * @param accessMap
 */
export function hasPermissionOr(permissions: string[]): boolean {
  if (Array.isArray(permissions)) {
    return permissions.some((item) => {
      return _somePermissions(item);
    });
  }
  throw new Error(`[hasPermissionOr]: ${permissions} should be a array !`);
}
