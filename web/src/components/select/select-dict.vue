<script setup lang="ts">
  import { PropType, onMounted, ref, watchEffect } from 'vue';
  import { useDictStore } from '@/store/modules/dict';
  import { SelectOption } from 'naive-ui';

  const props = defineProps({
    dictType: {
      type: [String, null] as PropType<string | null>,
      default: null,
    },
    dictCode: {
      type: [String, null] as PropType<string | null>,
      default: null,
    },
    multiple: {
      type: Boolean,
      default: false,
    },
  });

  const selectValue = ref(props.dictCode);

  const emit = defineEmits(['update:dictCode', 'update:dictName']);

  // 状态select options
  const options = ref<SelectOption[]>([]);

  //监控父组件变化
  watchEffect(() => {
    selectValue.value = props.dictCode;
  });

  const handleSelect = (value: string | (string | number)[], option: SelectOption) => {
    if (Array.isArray(option)) {
      option.forEach((opt) => {
        console.log('Option label:', opt.label);
      });
    } else {
      emit('update:dictName', option.label);
    }
    emit('update:dictCode', value);
  };

  onMounted(async () => {
    const dictArray = props.dictType ? await useDictStore().getDictListByType(props.dictType) : [];
    options.value = dictArray.map((dict) => ({
      label: dict.dictName,
      value: dict.dictCode,
    }));
  });
</script>

<template>
  <n-select
    v-model:value="selectValue"
    :multiple="multiple"
    :options="options"
    @update:value="handleSelect"
  />
</template>
