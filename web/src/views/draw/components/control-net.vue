<template>
  <n-grid :cols="6" :x-gap="24" :y-gap="16">
    <n-gi :span="6">
      <div class="pb-1">
        {{ $t('views.draw.stableDiffusion.controlNet.controlType') }}

        <div class="float-right">
          {{ $t('views.draw.stableDiffusion.controlNet.enable') }}
          <n-switch v-model:value="controlNetParamsRef.enabled" size="small" class="!align-text-top"></n-switch>
        </div>
      </div>
      <selectDict v-model:dict-code="controlNetParamsRef.module" dict-type="CONTROL_NET_TYPE" />
    </n-gi>
    <n-gi :span="6">
      <imageUpload />
    </n-gi>
    <n-gi :span="6">
      <inputSlider
        v-model:value="controlNetParamsRef.weight"
        :min="0"
        :max="2"
        :step="0.05"
        :label="$t('views.draw.stableDiffusion.controlNet.weight')"
      />
    </n-gi>
    <n-gi :span="3">
      <inputSlider
        v-model:value="controlNetParamsRef.guidance_start"
        size="tiny"
        :min="0"
        :max="1"
        :step="0.01"
        :label="$t('views.draw.stableDiffusion.controlNet.guidanceStart')"
      />
    </n-gi>
    <n-gi :span="3">
      <inputSlider
        v-model:value="controlNetParamsRef.guidance_end"
        :min="0"
        :max="1"
        :step="0.01"
        :label="$t('views.draw.stableDiffusion.controlNet.guidanceEnd')"
      />
    </n-gi>
    <n-gi :span="6">
      <inputSlider
        v-model:value="controlNetParamsRef.processor_res"
        :min="64"
        :max="2048"
        :step="1"
        :label="$t('views.draw.stableDiffusion.controlNet.resolution')"
      />
    </n-gi>
    <n-gi :span="6">
      <inputSlider
        v-model:value="controlNetParamsRef.threshold_a"
        :min="1"
        :max="255"
        :step="1"
        :label="$t('views.draw.stableDiffusion.controlNet.thresholdA')"
      />
    </n-gi>
    <n-gi :span="6">
      <inputSlider
        v-model:value="controlNetParamsRef.threshold_b"
        :min="1"
        :max="255"
        :step="1"
        :label="$t('views.draw.stableDiffusion.controlNet.thresholdB')"
      />
    </n-gi>
  </n-grid>
</template>

<script setup lang="ts">
  import selectDict from '@/components/select/select-dict.vue';
  import inputSlider from './input-slider.vue';
  import imageUpload from './image-upload.vue';
  import { PropType, ref } from 'vue';
  import { ControlNetParams } from '@/models/draw';

  const props = defineProps({
    controlNetParams: {
      type: Object as PropType<ControlNetParams>,
      default: null,
    },

    loraList: {
      type: Array<String>,
      default: [],
    },
  });

  const controlNetParamsRef = ref<ControlNetParams>(props.controlNetParams);
</script>
