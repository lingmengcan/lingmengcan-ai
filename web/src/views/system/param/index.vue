<template>
  <n-icon size="40" :depth="1">
    <component :is="iconComponent" />
  </n-icon>
</template>

<script lang="ts" setup>
  import { renderIconName } from '@/utils/icons';
  import { markRaw, ref } from 'vue';

  // 从数据库获取的图标名称
  const iconNameFromDatabase = 'PlusOutlined';

  // 用于存储图标组件的响应式引用
  const iconComponent = ref(renderIconName(iconNameFromDatabase));

  // iconComponent.value = renderIconName(iconNameFromDatabase);

  // 按需导入图标组件
  // import(`@vicons/antd`).then((module) => {
  //   iconComponent.value = module[iconNameFromDatabase];
  // });
</script>
