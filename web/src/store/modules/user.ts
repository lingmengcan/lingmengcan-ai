import { defineStore } from 'pinia';
import { store } from '@/store';
import { ACCESS_TOKEN, CURRENT_USER, ResultEnum } from '@/constants';
import DataStorage from '@/utils/storage';
import { login } from '@/api/system/user';

export type UserInfoType = {
  // TODO: add your own data
  name: string;
  email: string;
};

export interface UserState {
  token: string;
  username: string;
  welcome: string;
  avatar: string;
  permissions: string[];
  info: UserInfoType;
}

export const useUserStore = defineStore({
  id: 'app-user',
  state: (): UserState => ({
    token: DataStorage.get(ACCESS_TOKEN, ''),
    username: '',
    welcome: '',
    avatar: '',
    permissions: [],
    info: DataStorage.get(CURRENT_USER, {}),
  }),
  getters: {
    getToken(): string {
      return this.token;
    },
    getAvatar(): string {
      return this.avatar;
    },
    getNickname(): string {
      return this.username;
    },
    getPermissions(): string[] {
      return this.permissions;
    },
    getUserInfo(): UserInfoType {
      return this.info;
    },
  },
  actions: {
    setToken(token: string) {
      this.token = token;
    },
    setAvatar(avatar: string) {
      this.avatar = avatar;
    },
    setPermissions(permissions: string[]) {
      this.permissions = permissions;
    },
    setUserInfo(info: UserInfoType) {
      this.info = info;
    },
    // 登录
    async login(params: any) {
      const res = await login(params);

      if (res && res.code === ResultEnum.SUCCESS) {
        DataStorage.set(ACCESS_TOKEN, res.data);
        // DataStorage.set(CURRENT_USER, res.data);
        this.setToken(res.data);
        // this.setUserInfo(res.data);
      }
      return res;
    },

    // 获取用户信息
    // async getInfo() {
    //   const result = await getUserInfoApi();
    //   if (result.permissions && result.permissions.length) {
    //     const permissionsList = result.permissions;
    //     this.setPermissions(permissionsList);
    //     this.setUserInfo(result);
    //   } else {
    //     throw new Error('getInfo: permissionsList must be a non-null array !');
    //   }
    //   this.setAvatar(result.avatar);
    //   return result;
    // },

    // 登出
    async logout() {
      this.setPermissions([]);
      this.setUserInfo({ name: '', email: '' });
      DataStorage.remove(ACCESS_TOKEN);
      DataStorage.remove(CURRENT_USER);
    },
  },
});

// Need to be used outside the setup
export function useUser() {
  return useUserStore(store);
}
