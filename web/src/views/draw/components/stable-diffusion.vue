<template>
  <div class="flex-1 px-4 pb-4 overflow-auto">
    <n-grid :cols="6" :x-gap="24" :y-gap="16">
      <n-gi :span="6">
        <div class="pb-1">{{ $t('views.draw.stableDiffusion.personalizedGeneration') }}</div>
        <selectLora v-model:lora-list="loraListValue" @selected="selectedLora" />
      </n-gi>
      <n-gi :span="6">
        <div class="pb-1">
          {{ $t('views.draw.stableDiffusion.prompt') }}
        </div>
        <n-input v-model:value="txt2imgParamsRef.prompt" type="textarea" rows="5" placeholder="Enter prompt here..." />
      </n-gi>
      <n-gi :span="6">
        <div class="pb-1">
          {{ $t('views.draw.stableDiffusion.negativePrompt') }}
        </div>
        <n-input
          v-model:value="txt2imgParamsRef.negative_prompt"
          type="textarea"
          rows="3"
          placeholder="Enter negative prompt here..."
        />
      </n-gi>
      <n-gi :span="6">
        <div class="pb-1">
          {{ $t('views.draw.stableDiffusion.batchSize') }}
          <n-tag class="float-right" size="small">{{ txt2imgParamsRef.batch_size }}</n-tag>
        </div>
        <n-slider v-model:value="txt2imgParamsRef.batch_size" :min="1" :max="5" :step="1" />
      </n-gi>
      <n-gi :span="3">
        <div class="pb-1">
          {{ $t('views.draw.stableDiffusion.width') }}
          <n-tag class="float-right" size="small">{{ txt2imgParamsRef.width }}</n-tag>
        </div>
        <n-slider v-model:value="txt2imgParamsRef.width" :min="64" :max="2048" :step="1" />
      </n-gi>
      <n-gi :span="3">
        <div class="pb-1">
          {{ $t('views.draw.stableDiffusion.height') }}
          <n-tag class="float-right" size="small">{{ txt2imgParamsRef.height }}</n-tag>
        </div>
        <n-slider v-model:value="txt2imgParamsRef.height" :min="64" :max="2048" :step="1" />
      </n-gi>
      <n-gi :span="3">
        <div class="pb-1">
          {{ $t('views.draw.stableDiffusion.steps') }}
          <n-tag class="float-right" size="small">{{ txt2imgParamsRef.steps }}</n-tag>
        </div>
        <n-slider v-model:value="txt2imgParamsRef.steps" :min="1" :max="99" :step="1" />
      </n-gi>
      <n-gi :span="3">
        <div class="pb-1">
          {{ $t('views.draw.stableDiffusion.cfgScale') }}
          <n-tag class="float-right" size="small">{{ txt2imgParamsRef.cfg_scale }}</n-tag>
        </div>
        <n-slider v-model:value="txt2imgParamsRef.cfg_scale" :min="1" :max="30" :step="1" />
      </n-gi>
      <n-gi :span="3">
        <div class="pb-1">
          {{ $t('views.draw.stableDiffusion.sampler') }}
        </div>
        <selectDict
          v-model:dict-code="txt2imgParamsRef.sampler_index"
          :dict-name="txt2imgParamsRef.sampler_name"
          dict-type="SAMPLER"
        />
      </n-gi>
      <n-gi :span="3">
        <div class="pb-1">{{ $t('views.draw.stableDiffusion.seed') }}</div>
        <n-input-number v-model:value="txt2imgParamsRef.seed" :show-button="false" />
      </n-gi>
      <n-gi :span="6">
        <div>
          {{ $t('views.draw.stableDiffusion.restoreFaces') }}
          <n-switch v-model:value="txt2imgParamsRef.restore_faces" size="small" class="float-right" />
        </div>
      </n-gi>
      <n-gi :span="6">
        <div>
          {{ $t('views.draw.stableDiffusion.hiresFix') }}

          <n-switch v-model:value="txt2imgParamsRef.enable_hr" size="small" class="float-right" />
          <n-collapse-transition :show="txt2imgParamsRef.enable_hr" class="pt-1">
            <n-grid :cols="6" :x-gap="24" :y-gap="16">
              <n-gi :span="3">
                <div class="py-2">
                  {{ $t('views.draw.stableDiffusion.width') }}
                  <n-tag class="float-right" size="small">{{ txt2imgParamsRef.hr_resize_x }}</n-tag>
                </div>
                <n-slider v-model:value="txt2imgParamsRef.hr_resize_x" :min="512" :max="3840" :step="1" />
              </n-gi>
              <n-gi :span="3">
                <div class="py-2">
                  {{ $t('views.draw.stableDiffusion.height') }}
                  <n-tag class="float-right" size="small">
                    {{ txt2imgParamsRef.hr_resize_y }}
                  </n-tag>
                </div>
                <n-slider v-model:value="txt2imgParamsRef.hr_resize_y" :min="512" :max="3840" :step="1" />
              </n-gi>
              <n-gi :span="6">
                <div class="pb-1">
                  {{ $t('views.draw.stableDiffusion.upscaler1') }}
                </div>
                <selectDict v-model:dict-code="txt2imgParamsRef.hr_upscaler" dict-type="HIRES_FIX_UPSCALER" />
              </n-gi>
              <n-gi :span="6">
                <div class="pb-1">
                  {{ $t('views.draw.stableDiffusion.hiresSteps') }}
                  <n-tag class="float-right" size="small">
                    {{ txt2imgParamsRef.hr_second_pass_steps }}
                  </n-tag>
                </div>
                <n-slider v-model:value="txt2imgParamsRef.hr_second_pass_steps" :min="0" :max="150" :step="1" />
              </n-gi>
              <n-gi :span="6">
                <div class="pb-1">
                  {{ $t('views.draw.stableDiffusion.denoisingStrength') }}
                  <n-tag class="float-right" size="small">
                    {{ txt2imgParamsRef.denoising_strength }}
                  </n-tag>
                </div>
                <n-slider v-model:value="txt2imgParamsRef.denoising_strength" :min="0" :max="1" :step="0.1" />
              </n-gi>
            </n-grid>
          </n-collapse-transition>
        </div>
      </n-gi>
      <n-grid-item :span="6">
        <n-collapse arrow-placement="right">
          <n-collapse-item title="ControlNet" name="1">
            <n-tabs
              v-model:value="controlNetValue"
              justify-content="space-evenly"
              type="card"
              addable
              closable
              animated
              @close="handleControNetRemove"
              @add="handleControNetAdd"
            >
              <n-tab-pane
                v-for="(_, index) in controlNetParamsListRef"
                :key="index"
                :name="index"
                :tab="$t('views.draw.stableDiffusion.controlNet.control') + ' ' + index"
              >
                <controlNet v-model:control-net-params="controlNetParamsListRef[index]" />
              </n-tab-pane>
            </n-tabs>
          </n-collapse-item>
        </n-collapse>
      </n-grid-item>
    </n-grid>
  </div>
</template>

<script setup lang="ts">
  import { ref, PropType, reactive, watchEffect } from 'vue';
  import selectLora from './select-lora.vue';
  import controlNet from './control-net.vue';
  import { ControlNetParams, Txt2ImgParams } from '@/models/draw';

  const props = defineProps({
    txt2imgParams: {
      type: Object as PropType<Txt2ImgParams>,
      default: null,
    },

    loraList: {
      type: Array<String>,
      default: [],
    },
  });

  const txt2imgParamsRef = ref(props.txt2imgParams);
  const loraListValue = ref(props.loraList);
  const emit = defineEmits(['update:txt2imgParams', 'update:loraList']);

  const defaultControlNetParams: ControlNetParams = {
    enabled: true, // 启用
    control_mode: 'Balanced', // 对应webui 的 Control Mode 可以直接填字符串 推荐使用下标 0 1 2
    module: undefined, // 对应webui 的 Preprocessor
    weight: 1, // 对应webui 的Control Weight
    resize_mode: 'Crop and Resize',
    guidance_start: 0, // 什么时候介入 对应webui 的 Starting Control Step
    guidance_end: 1, // 什么时候退出 对应webui 的 Ending Control Step
    pixel_perfect: true, // 像素完美
    processor_res: 512, // 预处理器分辨率
    save_detected_map: true, // 因为使用了 controlnet API会返回生成controlnet的效果图，默认是True，如果不需要，改成False
    image: '', // 图片 格式为base64
  };

  const controlNetParamsListRef = reactive(Array.from({ length: 1 }, () => ({ ...defaultControlNetParams })));

  const controlNetValue = ref(0);

  function handleControNetAdd() {
    controlNetParamsListRef.push({ ...defaultControlNetParams });

    controlNetValue.value = controlNetParamsListRef.length - 1;
  }

  function handleControNetRemove(index: number) {
    controlNetParamsListRef.splice(index, 1);

    if (index === controlNetValue.value) {
      controlNetValue.value = Math.min(index, controlNetParamsListRef.length - 1);
    }
  }

  const selectedLora = () => {
    emit('update:loraList', loraListValue.value);
  };

  //监控父组件变化
  watchEffect(() => {
    txt2imgParamsRef.value.alwayson_scripts!.controlnet.args = controlNetParamsListRef;
  });
</script>
