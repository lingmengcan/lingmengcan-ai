import { defineStore } from 'pinia';
import { store } from '@/store';
import { ACCESS_TOKEN, CURRENT_USER, ResultEnum } from '@/constants';
import DataStorage from '@/utils/storage';
import { getUserInfo, login } from '@/api/system/user';
import { LoginParams, User } from '@/models/user';

export interface UserState {
  token: string;
  username: string;
  welcome: string;
  avatar: string;
  permissions: string[];
  userInfo: User;
}

export const useUserStore = defineStore({
  id: 'app-user',
  state: (): UserState => ({
    token: DataStorage.get(ACCESS_TOKEN, ''),
    username: '',
    welcome: '',
    avatar: '',
    permissions: [],
    userInfo: DataStorage.get(CURRENT_USER, {}),
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
    getUserInfo(): User {
      return this.userInfo;
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
    setUserInfo(info: User) {
      this.userInfo = info;
    },
    // 登录
    async login(params: LoginParams) {
      const res = await login(params);

      if (res && res.code === ResultEnum.SUCCESS) {
        DataStorage.set(ACCESS_TOKEN, res.data);
        console.log('token', DataStorage.get(ACCESS_TOKEN));
        this.setToken(res.data);
      }
      return res;
    },

    // 获取用户信息
    async getInfo() {
      const res = await getUserInfo();

      if (res && res.code === 0) {
        const { user, permissions } = res.data;

        this.setPermissions(permissions);
        this.setUserInfo(user);
        this.setAvatar(user.avatar as string);
      }

      return res?.data;
    },

    // 登出
    async logout() {
      this.setPermissions([]);
      this.setUserInfo({
        userName: '',
        email: '',
        userId: '',
        deptId: '',
        chineseName: '',
        phone: '',
        sex: '',
        password: '',
        status: 0,
        createdUser: '',
        updatedUser: '',
      });
      DataStorage.remove(ACCESS_TOKEN);
      DataStorage.remove(CURRENT_USER);
    },
  },
});

// Need to be used outside the setup
export function useUser() {
  return useUserStore(store);
}
