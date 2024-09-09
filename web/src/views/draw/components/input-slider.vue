<template>
  <div class="pb-1">
    {{ label }}

    <n-input-number
      v-model:value="valueRef"
      class="float-right w-12"
      size="tiny"
      :min="min"
      :max="max"
      :step="step"
      :show-button="false"
    />
  </div>
  <n-slider v-model:value="valueRef" :min="min" :max="max" :step="step" />
</template>
<script setup lang="ts">
  import { PropType, ref, watch } from 'vue';

  const props = defineProps({
    value: {
      type: [Number, String, null] as PropType<number | string | null>,
      default: null,
    },
    label: {
      type: String as PropType<string>,
      default: '',
    },
    min: {
      type: Number as PropType<number>,
      default: null,
    },
    max: {
      type: Number as PropType<number>,
      default: null,
    },
    step: {
      type: Number as PropType<number>,
      default: null,
    },
  });

  const emit = defineEmits(['update:value']);

  const valueRef = ref(props.value);

  // 监听props变化并同步更新valueRef
  watch(
    () => props.value,
    (newVal) => {
      if (newVal) {
        valueRef.value = newVal;
      }
    },
  );

  // 监听controlNetParamsRef的变化并emit给父组件
  watch(valueRef, (newVal) => {
    emit('update:value', newVal);
  });
</script>
