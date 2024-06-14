<script setup lang="ts">
  import { SelectOption } from 'naive-ui';
  import { useModelStore } from '@/store/modules/model';
  import { PropType, onMounted, ref, watchEffect } from 'vue';

  const props = defineProps({
    modelType: {
      type: [String, null] as PropType<string | null>,
      default: null,
    },
    modelName: {
      type: [String, null] as PropType<string | null>,
      default: null,
    },
  });

  const selectValue = ref(props.modelName);

  const emit = defineEmits(['update:modelName']);

  // 状态select options
  const options = ref<SelectOption[]>([]);

  //监控父组件变化
  watchEffect(() => {
    selectValue.value = props.modelName;
  });

  const handleSelect = () => {
    emit('update:modelName', selectValue.value);
  };

  onMounted(async () => {
    const modelList = props.modelType
      ? await useModelStore().getModelListByType(props.modelType)
      : [];
    options.value = modelList.map((item) => ({
      label: item.modelName,
      value: item.modelName,
    }));
  });
</script>

<template>
  <n-select v-model:value="selectValue" :options="options" @update:value="handleSelect" />
</template>
