<script setup lang="ts">
  import { computed, onMounted, ref, unref, watch } from 'vue';
  import { useRoute, useRouter } from 'vue-router';
  import { useAsyncRouteStore } from '@/store/modules/async_route';
  import { generatorMenu } from '@/utils/menu';

  defineProps({
    collapsed: {
      type: Boolean,
      required: true,
    },
  });

  // 当前路由
  const currentRoute = useRoute();
  const router = useRouter();
  const asyncRouteStore = useAsyncRouteStore();
  const menus = ref<any[]>([]);
  const selectedKeys = ref<string>(currentRoute.name as string);

  // 获取当前打开的子菜单
  const matched = currentRoute.matched;
  const getOpenKeys = matched && matched.length ? matched.map((item) => item.name) : [];

  const openKeys = ref(getOpenKeys);

  const getSelectedKeys = computed(() => unref(selectedKeys));
  // 跟随页面路由变化，切换菜单选中状态
  watch(
    () => currentRoute.fullPath,
    () => {
      updateMenu();
    },
  );

  function updateMenu() {
    menus.value = generatorMenu(asyncRouteStore.getMenus);

    updateSelectedKeys();
  }

  function updateSelectedKeys() {
    const matched = currentRoute.matched;
    openKeys.value = matched.map((item) => item.name);
    const activeMenu: string = (currentRoute.meta?.activeMenu as string) || '';
    selectedKeys.value = activeMenu ? (activeMenu as string) : (currentRoute.name as string);
  }

  // 点击菜单
  function clickMenuItem(key: string) {
    // 外链
    if (/http(s)?:/.test(key)) {
      window.open(key);
    } else {
      router.push({ name: key });
    }
  }

  //展开菜单
  function menuExpanded(keys: string[]) {
    if (!keys) return;
    const latestOpenKey = keys.find((key) => openKeys.value.indexOf(key) === -1);
    const isExistChildren = findChildrenLen(latestOpenKey as string);
    openKeys.value = isExistChildren ? (latestOpenKey ? [latestOpenKey] : []) : keys;
  }

  //查找是否存在子路由
  function findChildrenLen(key: string) {
    if (!key) return false;
    const subRouteChildren: string[] = [];
    for (const { children, key } of unref(menus)) {
      if (children && children.length) {
        subRouteChildren.push(key as string);
      }
    }
    return subRouteChildren.includes(key);
  }
  onMounted(() => {
    updateMenu();
  });
</script>

<template>
  <NMenu
    :options="menus"
    mode="vertical"
    :inverted="true"
    :collapsed="collapsed"
    :collapsed-width="64"
    :collapsed-icon-size="20"
    :indent="24"
    :expanded-keys="openKeys"
    :value="getSelectedKeys"
    @update:value="clickMenuItem"
    @update:expanded-keys="menuExpanded"
  />
</template>
