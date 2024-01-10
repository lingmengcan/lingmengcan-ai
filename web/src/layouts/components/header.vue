<template>
  <div
    class="flex items-center justify-between p-0 w-full h-16 shadow-md transition-all duration-200 z-10"
  >
    <!--顶部菜单-->
    <!--左侧菜单-->
    <div class="flex items-center">
      <!-- 菜单收起 -->
      <div
        class="flex m-3 cursor-pointer hover:bg-gray-200"
        @click="emit('update:collapsed', !collapsed)"
      >
        <n-icon v-if="collapsed" size="20">
          <MenuUnfoldOutlined />
        </n-icon>
        <n-icon v-else style="margin: 0" size="20">
          <MenuFoldOutlined />
        </n-icon>
      </div>

      <!-- 面包屑 -->
      <n-breadcrumb class="flex mr-10">
        <template
          v-for="routeItem in breadcrumbList"
          :key="routeItem.name === 'Redirect' ? void 0 : routeItem.name"
        >
          <n-breadcrumb-item v-if="routeItem.meta.title">
            <span class="text-base">
              {{ routeItem.meta.title }}
            </span>
          </n-breadcrumb-item>
        </template>
      </n-breadcrumb>

      <!-- 菜单 -->
      <Menu :inverted="false" :collapsed="false" mode="horizontal" />
    </div>

    <div class="flex items-center mr-5">
      <!--切换全屏-->
      <div
        class="flex items-center h-16 px-3 text-center cursor-pointer transition-all duration-200 ease-in-out"
      >
        <n-tooltip placement="bottom" class="hover:bg-gray-200">
          <template #trigger>
            <n-icon size="18">
              <component :is="fullscreenIcon" @click="toggleFullScreen" />
            </n-icon>
          </template>
          <span>全屏</span>
        </n-tooltip>
      </div>
      <!-- 个人中心 -->
      <div
        class="inline-block h-16 text-center cursor-pointer transition-all duration-200 ease-in-out"
      >
        <n-dropdown trigger="hover" :options="avatarOptions" @select="avatarSelect">
          <div class="flex items-center h-16 px-1 hover:bg-gray-200">
            <Avatar round />
            <span class="ml-1 text-sky-500">{{ username }}</span>
          </div>
        </n-dropdown>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
  import { useUserStore } from '@/store/modules/user';
  import {
    MenuFoldOutlined,
    MenuUnfoldOutlined,
    FullscreenOutlined,
    FullscreenExitOutlined,
  } from '@vicons/antd';
  import { useDialog, useMessage } from 'naive-ui';
  import { computed, shallowRef } from 'vue';
  import { RouteLocationMatched, useRoute, useRouter } from 'vue-router';
  import Menu from './menu.vue';
  import Avatar from '@/components/avatar/index.vue';

  defineProps({
    collapsed: {
      type: Boolean,
      required: true,
    },
  });

  const emit = defineEmits(['update:collapsed']);

  const router = useRouter();
  const route = useRoute();
  const fullscreenIcon = shallowRef(FullscreenOutlined);
  const userStore = useUserStore();
  const message = useMessage();
  const dialog = useDialog();

  const username = userStore.getUsername;

  const breadcrumbList = computed(() => {
    return generator(route.matched);
  });

  const generator = (routerMap: RouteLocationMatched[]) => {
    routerMap.map((item) => {
      const currentMenu = {
        ...item,
        label: item.meta.title,
        key: item.name,
        disabled: item.path === '/',
      };
      return currentMenu;
    });
    // 只保留根路径
    return routerMap.slice(0, 1);
  };

  // 切换全屏图标
  const toggleFullscreenIcon = () =>
    (fullscreenIcon.value =
      document.fullscreenElement !== null ? FullscreenExitOutlined : FullscreenOutlined);

  // 监听全屏切换事件
  document.addEventListener('fullscreenchange', toggleFullscreenIcon);

  // 全屏切换
  const toggleFullScreen = () => {
    if (!document.fullscreenElement) {
      document.documentElement.requestFullscreen();
    } else {
      if (document.exitFullscreen) {
        document.exitFullscreen();
      }
    }
  };

  const avatarOptions = [
    {
      label: '个人设置',
      key: 1,
    },
    {
      label: '退出登录',
      key: 2,
    },
  ];

  //头像下拉菜单
  const avatarSelect = (key: number) => {
    switch (key) {
      case 1:
        router.push({ name: 'setting' });
        break;
      case 2:
        doLogout();
        break;
    }
  };

  // 退出登录
  const doLogout = () => {
    dialog.info({
      title: '提示',
      content: '您确定要退出登录吗',
      positiveText: '确定',
      negativeText: '取消',
      onPositiveClick: () => {
        userStore.logout().then(() => {
          message.success('成功退出登录');

          router
            .replace({
              name: 'Login',
              query: {
                redirect: route.fullPath,
              },
            })
            .finally(() => location.reload());
        });
      },
      onNegativeClick: () => {},
    });
  };
</script>
