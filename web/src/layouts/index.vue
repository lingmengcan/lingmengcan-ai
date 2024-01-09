<script setup lang="ts">
  import MainContent from './components/main.vue';
  import Logo from './components/logo.vue';
  import Menu from './components/menu.vue';
  import Header from './components/header.vue';
  import { ref } from 'vue';

  const collapsed = ref<boolean>(true);

  const inverted = ref(true);
</script>

<template>
  <n-layout class="flex flex-row" has-sider>
    <n-layout-sider
      show-trigger="bar"
      collapse-mode="width"
      :collapsed-width="64"
      :collapsed="collapsed"
      :inverted="inverted"
      :width="200"
      :native-scrollbar="false"
      @collapse="collapsed = true"
      @expand="collapsed = false"
    >
      <Logo :collapsed="collapsed" />
      <Menu :inverted="inverted" :collapsed="collapsed" mode="vertical" />
    </n-layout-sider>
    <n-layout :inverted="false">
      <n-layout-header :inverted="false" position="absolute" class="z-10">
        <Header v-model:collapsed="collapsed" :inverted="inverted" />
      </n-layout-header>

      <n-layout-content>
        <div class="h-screen p-2.5 pt-[74px] bg-slate-200">
          <MainContent />
        </div>
      </n-layout-content>
      <n-back-top :right="100" />
    </n-layout>
  </n-layout>
</template>
