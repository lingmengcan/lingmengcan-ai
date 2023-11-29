<template>
  <n-button class="custom-button">Click me</n-button>
</template>

<script lang="ts" setup>
  import { useChat } from '@/store/modules/chat';
  const chatStore = useChat();
</script>

<style scoped>
  .custom-button {
    background-color: red;
    color: white;
  }
</style>
