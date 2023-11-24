<template>
  <n-layout class="layout" has-sider>
    <n-layout-content class="content"><RouterView> </RouterView></n-layout-content>
  </n-layout>
</template>

<script>
  export default {
    name: 'App',
  };
</script>

<style scoped>
  .layout {
    display: flex;
    flex-direction: column;
    height: 100vh;
    background-color: #000;
  }

  .content {
    flex: 1;
    height: 100vh;
    background-color: #fff;
  }
</style>
