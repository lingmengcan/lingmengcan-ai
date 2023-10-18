<script setup lang="ts"></script>

<template>
  <div class="logo">
    <img src="@/assets/images/logo.png" alt="" class="mr-2" />
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
      height: 32px;
    }
  }
</style>
