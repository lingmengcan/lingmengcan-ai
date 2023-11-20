<template>
  <div> <component :is="iconComponent" v-if="iconComponent" /> </div>
</template>

<script lang="ts" setup>
  import { renderIonicons5 } from '@/utils/icons';
  import { DefineComponent, onMounted, shallowRef } from 'vue';

  // 从数据库获取的图标名称
  const iconNameFromDatabase = 'PlusOutlined';

  // 用于存储图标组件的响应式引用
  const iconComponent = shallowRef<DefineComponent | null | String>(null);

  onMounted(() => {
    // 初始化时调用 renderIconName 函数
    iconComponent.value = renderIonicons5(iconNameFromDatabase);
  });
</script>
