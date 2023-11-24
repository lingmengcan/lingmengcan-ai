<script setup lang="ts">
  import MainContent from './components/main.vue';
  import Logo from './components/logo.vue';
  import Menu from './components/menu.vue';
  import Header from './components/header.vue';
  import { ref } from 'vue';

  const collapsed = ref<boolean>(false);

  const inverted = ref(true);
</script>

<template>
  <n-layout class="flex flex-row layout" has-sider>
    <n-layout-sider
      show-trigger="bar"
      collapse-mode="width"
      :collapsed-width="64"
      :collapsed="collapsed"
      :inverted="inverted"
      :width="200"
      :native-scrollbar="false"
      class="layout-sider"
      @collapse="collapsed = true"
      @expand="collapsed = false"
    >
      <Logo :collapsed="collapsed" />
      <Menu :inverted="inverted" :collapsed="collapsed" />
    </n-layout-sider>
    <n-layout :inverted="false">
      <n-layout-header :inverted="false" position="absolute">
        <Header v-model:collapsed="collapsed" :inverted="inverted" />
      </n-layout-header>

      <n-layout-content class="layout-content layout-default-background">
        <div class="h-screen p-2.5 pt-[74px] layout-content-main">
          <MainContent />
        </div>
      </n-layout-content>
      <n-back-top :right="100" />
    </n-layout>
  </n-layout>
</template>

<style lang="less" scoped>
  .layout {
    &-default-background {
      background: #f5f7f9;
    }

    .layout-sider {
      box-shadow: 2px 0 8px 0 rgb(29 35 41 / 5%);
      z-index: 13;
      transition: all 0.2s ease-in-out;
    }

    .layout-sider-fix {
      position: fixed;
      top: 0;
      left: 0;
    }

    .ant-layout {
      overflow: hidden;
    }

    .layout-right-fix {
      overflow-x: hidden;
      padding-left: 200px;
      transition: all 0.2s ease-in-out;
    }

    .layout-content {
      flex: auto;
    }

    .n-layout-header.n-layout-header--absolute-positioned {
      z-index: 11;
    }

    .n-layout-footer {
      background: none;
    }
  }

  .fluid-header {
    padding-top: 0;
  }
</style>
