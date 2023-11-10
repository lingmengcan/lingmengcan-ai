<template>
  <div class="layout-header">
    <!--顶部菜单-->
    <!--左侧菜单-->
    <div class="layout-header-left">
      <!-- 菜单收起 -->
      <div
        class="ml-1 layout-header-trigger layout-header-trigger-min"
        @click="emit('update:collapsed', !collapsed)"
      >
        <n-icon v-if="collapsed" size="18">
          <MenuUnfoldOutlined />
        </n-icon>
        <n-icon v-else size="18">
          <MenuFoldOutlined />
        </n-icon>
      </div>

      <!-- 面包屑 -->
      <n-breadcrumb>
        <template
          v-for="routeItem in breadcrumbList"
          :key="routeItem.name === 'Redirect' ? void 0 : routeItem.name"
        >
          <n-breadcrumb-item v-if="routeItem.meta.title">
            <span class="link-text">
              <component :is="routeItem.meta.icon" v-if="routeItem.meta.icon" />
              {{ routeItem.meta.title }}
            </span>
          </n-breadcrumb-item>
        </template>
      </n-breadcrumb>
    </div>

    <div class="layout-header-right">
      <!--切换全屏-->
      <div class="layout-header-trigger layout-header-trigger-min">
        <n-tooltip placement="bottom">
          <template #trigger>
            <n-icon size="18">
              <component :is="fullscreenIcon" @click="toggleFullScreen" />
            </n-icon>
          </template>
          <span>全屏</span>
        </n-tooltip>
      </div>
      <!-- 个人中心 -->
      <div class="layout-header-trigger layout-header-trigger-min">
        <n-dropdown trigger="hover" :options="avatarOptions" @select="avatarSelect">
          <div class="avatar">
            <n-avatar round>
              {{ username }}
              <template #icon>
                <UserOutlined />
              </template>
            </n-avatar>
          </div>
        </n-dropdown>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
  import { useUserStore } from '@/store/modules/user';
  import { MenuFoldOutlined, MenuUnfoldOutlined, UserOutlined } from '@vicons/antd';
  import { useDialog, useMessage } from 'naive-ui';
  import { computed, ref } from 'vue';
  import { RouteLocationMatched, useRoute, useRouter } from 'vue-router';

  defineProps({
    collapsed: {
      type: Boolean,
      required: true,
    },
  });

  const emit = defineEmits(['update:collapsed']);

  const router = useRouter();
  const route = useRoute();
  const fullscreenIcon = ref('FullscreenOutlined');
  const userStore = useUserStore();
  const message = useMessage();
  const dialog = useDialog();

  const username = ''; //userStore.getNickname();

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
      document.fullscreenElement !== null ? 'FullscreenExitOutlined' : 'FullscreenOutlined');

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

<style lang="less" scoped>
  .layout-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0;
    height: 64px;
    box-shadow: 0 1px 4px rgb(0 21 41 / 8%);
    transition: all 0.2s ease-in-out;
    width: 100%;
    z-index: 11;

    &-left {
      display: flex;
      align-items: center;

      .logo {
        display: flex;
        align-items: center;
        justify-content: center;
        height: 64px;
        line-height: 64px;
        overflow: hidden;
        white-space: nowrap;
        padding-left: 10px;

        img {
          width: auto;
          height: 32px;
          margin-right: 10px;
        }

        .title {
          margin-bottom: 0;
        }
      }

      ::v-deep(.ant-breadcrumb span:last-child .link-text) {
        color: #515a6e;
      }

      .n-breadcrumb {
        display: inline-block;
      }

      &-menu {
        color: var(--text-color);
      }
    }

    &-right {
      display: flex;
      align-items: center;
      margin-right: 20px;

      .avatar {
        display: flex;
        align-items: center;
        height: 64px;
      }

      > * {
        cursor: pointer;
      }
    }

    &-trigger {
      display: inline-block;
      width: 64px;
      height: 64px;
      text-align: center;
      cursor: pointer;
      transition: all 0.2s ease-in-out;

      .n-icon {
        display: flex;
        align-items: center;
        height: 64px;
        line-height: 64px;
      }

      &:hover {
        background: hsla(0, 0%, 100%, 0.08);
      }

      .anticon {
        font-size: 16px;
        color: #515a6e;
      }
    }

    &-trigger-min {
      width: auto;
      padding: 0 12px;
    }
  }

  .layout-header-light {
    background: #fff;
    color: #515a6e;

    .n-icon {
      color: #515a6e;
    }

    .layout-header-left {
      ::v-deep(.n-breadcrumb .n-breadcrumb-item:last-child .n-breadcrumb-item__link) {
        color: #515a6e;
      }
    }

    .layout-header-trigger {
      &:hover {
        background: #f8f8f9;
      }
    }
  }

  .layout-header-fix {
    position: fixed;
    top: 0;
    right: 0;
    left: 200px;
    z-index: 11;
  }
</style>
