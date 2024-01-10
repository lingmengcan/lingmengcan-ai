<template>
  <div class="flex flex-col justify-center w-full rounded-lg py-12 h-screen">
    <div class="text-center">
      <img class="mx-auto w-[350px]" src="~@/assets/images/error/404.svg" alt="" />
    </div>
    <div class="text-center">
      <h1 class="text-base text-gray-500 py-5">抱歉，你访问的页面不存在</h1>
      <n-button type="info" @click="goHome">回到首页</n-button>
    </div>
  </div>
</template>

<script lang="ts" setup>
  import { useRouter } from 'vue-router';
  const router = useRouter();
  function goHome() {
    router.push('/');
  }
</script>
