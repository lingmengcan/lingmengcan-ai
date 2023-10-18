<script setup lang="ts">
  import { computed, onMounted, reactive, ref, unref, watch } from 'vue';
  import { useRoute } from 'vue-router';
  import { useAsyncRouteStore } from '@/store/modules/async_route';
  import { generatorMenu } from '@/utils/menu';

  // 当前路由
  const currentRoute = useRoute();
  const asyncRouteStore = useAsyncRouteStore();
  const menus = ref<any[]>([]);
  const selectedKeys = ref<string>(currentRoute.name as string);

  // 获取当前打开的子菜单
  const matched = currentRoute.matched;
  const getOpenKeys = matched && matched.length ? matched.map((item) => item.name) : [];

  const state = reactive({
    openKeys: getOpenKeys,
  });

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
    state.openKeys = matched.map((item) => item.name);
    const activeMenu: string = (currentRoute.meta?.activeMenu as string) || '';
    selectedKeys.value = activeMenu ? (activeMenu as string) : (currentRoute.name as string);
  }

  onMounted(() => {
    updateMenu();
  });
</script>

<template>
  <NMenu
    :options="menus"
    mode="vertical"
    :collapsed="true"
    :collapsed-width="64"
    :collapsed-icon-size="20"
    :indent="24"
    :value="getSelectedKeys"
  />
</template>
