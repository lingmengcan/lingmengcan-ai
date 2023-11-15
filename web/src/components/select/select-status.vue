<script setup lang="ts">
  import { PropType, ref, watchEffect } from 'vue';

  const props = defineProps({
    modelValue: {
      type: [Number, String, null] as PropType<number | string | null>,
      default: null,
    },
  });

  const selectValue = ref(props.modelValue);

  const emit = defineEmits(['update:modelValue']);

  // 状态select options
  const statusOptions = ref([
    { label: '正常', value: 0 },
    { label: '停用', value: 1 },
  ]);

  //监控父组件变化
  watchEffect(() => {
    selectValue.value = props.modelValue;
  });

  const handleSelect = () => {
    emit('update:modelValue', selectValue.value);
  };
</script>

<template>
  <n-select v-model:value="selectValue" :options="statusOptions" @update:value="handleSelect" />
</template>
