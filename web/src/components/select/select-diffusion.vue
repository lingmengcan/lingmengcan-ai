<script setup lang="ts">
  import { SelectOption } from 'naive-ui';
  import { PropType, onMounted, ref } from 'vue';
  import { getDiffusionModelListByType } from '@/api/draw/model';
  import { ResultEnum } from '@/constants';

  const props = defineProps({
    modelType: {
      type: [String, null] as PropType<string | null>,
      default: null,
    },
    modelId: {
      type: String as PropType<string | null>,
      default: null,
    },
  });

  const emit = defineEmits(['update:modelId']);

  // 状态select options
  const options = ref<SelectOption[]>([]);

  const handleSelect = (value: string) => {
    emit('update:modelId', value);
  };

  onMounted(async () => {
    const res = props.modelType && (await getDiffusionModelListByType(props.modelType));

    if (res && res.code === ResultEnum.SUCCESS) {
      const modelList = res.data;

      options.value = modelList.map((item) => ({
        label: item.modelName,
        value: item.modelId,
      }));
    }
  });
</script>

<template>
  <n-select :value="modelId" :options="options" @update:value="handleSelect" />
</template>
