<script setup lang="tsx">
  import { onBeforeMount } from 'vue';
  import { useRoute, useRouter } from 'vue-router';
  import { NEmpty } from 'naive-ui';

  const route = useRoute();
  const router = useRouter();
  onBeforeMount(() => {
    const { params, query } = route;
    const { path } = params;
    router.replace({
      path: '/' + (Array.isArray(path) ? path.join('/') : path),
      query,
    });
  });
  const App = () => {
    return <NEmpty />;
  };
</script>

<template>
  <App />
</template>
