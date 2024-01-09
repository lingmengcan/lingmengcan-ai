<script setup lang="ts">
  import { computed, onMounted, ref, unref, watch } from 'vue';
  import { useRoute, useRouter } from 'vue-router';
  import { useAsyncRouteStore } from '@/store/modules/async-route';
  import { generatorMenu } from '@/utils/menu';

  const props = defineProps({
    collapsed: {
      type: Boolean,
      required: true,
    },
    isAdmin: {
      type: Boolean,
      default: false,
    },
    mode: {
      type: String,
      default: 'vertical',
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
    const dataMenus = generatorMenu(asyncRouteStore.getMenus);

    if (props.mode === 'vertical') {
      if (props.isAdmin) {
        menus.value = dataMenus;
      } else {
        menus.value = dataMenus.map((item) => {
          delete item.children;
          return item;
        });
      }
    } else {
      const parentKey = openKeys.value.shift();
      const items = dataMenus.find((item) => item.key === parentKey);
      menus.value = items ? items.children : [];
    }

    updateSelectedKeys();
  }

  function updateSelectedKeys() {
    const matched = currentRoute.matched;
    openKeys.value = matched.map((item) => item.name);

    selectedKeys.value = currentRoute.name as string;
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
    class="items-center"
    :options="menus"
    :mode="mode"
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
