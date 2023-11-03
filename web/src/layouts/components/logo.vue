<script setup lang="ts">
  defineProps({
    collapsed: {
      type: Boolean,
      required: true,
    },
  });
</script>

<template>
  <div class="logo">
    <img src="@/assets/images/logo.png" alt="" class="mr-2" />
    <h2 v-show="!collapsed" class="title">lingmengcan</h2>
  </div>
</template>

<style lang="less" scoped>
  .logo {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 64px;
    line-height: 64px;
    overflow: hidden;
    white-space: nowrap;

    img {
      width: auto;
      height: 28px;
    }
  }
</style>
