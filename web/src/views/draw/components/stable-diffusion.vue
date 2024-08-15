<template>
  <div class="flex-1 px-4 pb-4 overflow-auto">
    <n-grid :cols="6" :x-gap="24" :y-gap="16">
      <n-gi :span="6">
        <div class="pb-1">
          个性化生成
          <span class="text-xs text-gray-400">LoRA</span>
        </div>
        <selectLora v-model:lora-list="loraListValue" @selected="selectedLora" />
      </n-gi>
      <n-gi :span="6">
        <div class="pb-1">
          描述词
          <span class="text-xs text-gray-400">Prompt</span>
        </div>
        <n-input v-model:value="txt2imgParamsRef.prompt" type="textarea" rows="5" placeholder="Enter prompt here..." />
      </n-gi>
      <n-gi :span="6">
        <div class="pb-1">
          反向词
          <span class="text-xs text-gray-400">Negative Prompt</span>
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
          生成数量
          <n-tag class="float-right" size="small">{{ txt2imgParamsRef.batch_size }}</n-tag>
        </div>
        <n-slider v-model:value="txt2imgParamsRef.batch_size" :min="1" :max="5" :step="1" />
      </n-gi>
      <n-gi :span="3">
        <div class="pb-1">
          宽度
          <span class="text-xs text-gray-400">Width</span>
          <n-tag class="float-right" size="small">{{ txt2imgParamsRef.width }}</n-tag>
        </div>
        <n-slider v-model:value="txt2imgParamsRef.width" :min="64" :max="2048" :step="1" />
      </n-gi>
      <n-gi :span="3">
        <div class="pb-1">
          高度
          <span class="text-xs text-gray-400">Height</span>
          <n-tag class="float-right" size="small">{{ txt2imgParamsRef.height }}</n-tag>
        </div>
        <n-slider v-model:value="txt2imgParamsRef.height" :min="64" :max="2048" :step="1" />
      </n-gi>
      <n-gi :span="3">
        <div class="pb-1">
          计算步数
          <span class="text-xs text-gray-400">Steps</span>
          <n-tag class="float-right" size="small">{{ txt2imgParamsRef.steps }}</n-tag>
        </div>
        <n-slider v-model:value="txt2imgParamsRef.steps" :min="1" :max="99" :step="1" />
      </n-gi>
      <n-gi :span="3">
        <div class="pb-1">
          精准度
          <span class="text-xs text-gray-400">CFG Scale</span>
          <n-tag class="float-right" size="small">{{ txt2imgParamsRef.cfg_scale }}</n-tag>
        </div>
        <n-slider v-model:value="txt2imgParamsRef.cfg_scale" :min="1" :max="30" :step="1" />
      </n-gi>
      <n-gi :span="3">
        <div class="pb-1">
          采样器
          <span class="text-xs text-gray-400">Sampler</span>
        </div>
        <selectDict
          v-model:dict-code="txt2imgParamsRef.sampler_index"
          :dict-name="txt2imgParamsRef.sampler_name"
          dict-type="SAMPLER"
        />
      </n-gi>
      <n-gi :span="3">
        <div class="pb-1">使用指定种子</div>
        <n-input-number v-model:value="txt2imgParamsRef.seed" :show-button="false" />
      </n-gi>
      <n-gi :span="6">
        <div>
          面部修复
          <span class="text-xs text-gray-400">Restore faces</span>
          <n-switch v-model:value="txt2imgParamsRef.restore_faces" size="small" class="float-right" />
        </div>
      </n-gi>
      <n-gi :span="6">
        <div>
          高分辨率修复
          <span class="text-xs text-gray-400">Hires fix</span>
          <n-switch v-model:value="txt2imgParamsRef.enable_hr" size="small" class="float-right" />
          <n-collapse-transition :show="txt2imgParamsRef.enable_hr" class="pt-1">
            <n-grid :cols="6" :x-gap="24" :y-gap="16">
              <n-gi :span="3">
                <div class="py-2">
                  宽度
                  <span class="text-xs text-gray-400">Width</span>
                  <n-tag class="float-right" size="small">{{ txt2imgParamsRef.hr_resize_x }}</n-tag>
                </div>
                <n-slider v-model:value="txt2imgParamsRef.hr_resize_x" :min="512" :max="3840" :step="1" />
              </n-gi>
              <n-gi :span="3">
                <div class="py-2">
                  高度
                  <span class="text-xs text-gray-400">Height</span>
                  <n-tag class="float-right" size="small">
                    {{ txt2imgParamsRef.hr_resize_y }}
                  </n-tag>
                </div>
                <n-slider v-model:value="txt2imgParamsRef.hr_resize_y" :min="512" :max="3840" :step="1" />
              </n-gi>
              <n-gi :span="6">
                <div class="pb-1">
                  高清化算法
                  <span class="text-xs text-gray-400">Upscaler 1</span>
                </div>
                <selectDict v-model:dict-code="txt2imgParamsRef.hr_upscaler" dict-type="HIRES_FIX_UPSCALER" />
              </n-gi>
              <n-gi :span="6">
                <div class="pb-1">
                  高分辨率采样步数
                  <span class="text-xs text-gray-400">Hires steps</span>
                  <n-tag class="float-right" size="small">
                    {{ txt2imgParamsRef.hr_second_pass_steps }}
                  </n-tag>
                </div>
                <n-slider v-model:value="txt2imgParamsRef.hr_second_pass_steps" :min="0" :max="150" :step="1" />
              </n-gi>
              <n-gi :span="6">
                <div class="pb-1">
                  重绘强度
                  <span class="text-xs text-gray-400">Denoising strength</span>
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
        <n-collapse arrow-placement="right" default-expanded-names="1">
          <n-collapse-item title="ControlNet" name="1">
            <n-radio-group v-model:value="selectedIndex" name="left-size" class="pb-3">
              <n-space>
                <n-radio v-for="index in 3" :key="index" :value="index" @change="handleControlNetChange(index)">
                  {{ $t('views.draw.stableDiffusion.controlNet.control') + ' ' + index }}
                </n-radio>
              </n-space>
            </n-radio-group>

            <div v-for="(params, index) in controlNetParamsList" :key="index">
              <controlNet
                v-if="index + 1 === selectedIndex"
                :control-net-params="params"
                @update:control-net-params="updateControlNetParams(index, $event)"
              />
            </div>
          </n-collapse-item>
        </n-collapse>
      </n-grid-item>
    </n-grid>
  </div>
</template>

<script setup lang="ts">
  import { ref, PropType, reactive } from 'vue';
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

  const txt2imgParamsRef = ref<Txt2ImgParams>(props.txt2imgParams);
  const loraListValue = ref(props.loraList);
  const emit = defineEmits(['update:loraList']);

  const defaultControlNetParams: ControlNetParams = {
    enabled: true, // 启用
    control_mode: 1, // 对应webui 的 Control Mode 可以直接填字符串 推荐使用下标 0 1 2
    model: 'control_v11p_sd15_canny [d14c016b]', // 对应webui 的 Model
    module: '', // 对应webui 的 Preprocessor
    weight: 1, // 对应webui 的Control Weight
    resize_mode: '',
    threshold_a: 100, // 阈值a 部分control module会用上
    threshold_b: 200, // 阈值b
    guidance_start: 0, // 什么时候介入 对应webui 的 Starting Control Step
    guidance_end: 1, // 什么时候退出 对应webui 的 Ending Control Step
    pixel_perfect: true, // 像素完美
    processor_res: 512, // 预处理器分辨率
    save_detected_map: true, // 因为使用了 controlnet API会返回生成controlnet的效果图，默认是True，如果不需要，改成False
    input_image: '', // 图片 格式为base64
  };

  const selectedIndex = ref(1); // 用来存储当前选中的radio index

  const controlNetParamsList = reactive(Array.from({ length: 3 }, () => ({ ...defaultControlNetParams })));

  function updateControlNetParams(index: number, newParams: ControlNetParams) {
    controlNetParamsList[index] = newParams;
  }

  const handleControlNetChange = (index: number) => {
    selectedIndex.value = index;
  };
  const selectedLora = () => {
    emit('update:loraList', loraListValue.value);
  };
</script>
