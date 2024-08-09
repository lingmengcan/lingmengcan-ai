<template>
  <div class="flex-1 px-4 pb-4 overflow-auto">
    <n-form :show-label="false">
      <n-grid :cols="6" :x-gap="25">
        <n-form-item-gi :span="6">
          <div class="w-full">
            <div class="pb-1">
              个性化生成
              <span class="text-xs text-gray-400">LoRA</span>
            </div>
            <selectLora v-model:lora-list="loraListValue" @selected="selectedLora" />
          </div>
        </n-form-item-gi>
        <n-form-item-gi :span="6">
          <div class="w-full">
            <div class="pb-1">
              描述词
              <span class="text-xs text-gray-400">Prompt</span>
            </div>
            <n-input v-model:value="txt2imgParams.prompt" type="textarea" rows="5" placeholder="Enter prompt here..." />
          </div>
        </n-form-item-gi>
        <n-form-item-gi :span="6">
          <div class="w-full">
            <div class="pb-1">
              反向词
              <span class="text-xs text-gray-400">Negative Prompt</span>
            </div>
            <n-input
              v-model:value="txt2imgParams.negative_prompt"
              type="textarea"
              rows="3"
              placeholder="Enter negative prompt here..."
            />
          </div>
        </n-form-item-gi>
        <n-form-item-gi :span="6">
          <div class="w-full">
            <div class="pb-1">
              生成数量
              <n-tag class="float-right" size="small">{{ txt2imgParams.batch_size }}</n-tag>
            </div>
            <n-slider v-model:value="txt2imgParams.batch_size" :min="1" :max="5" :step="1" />
          </div>
        </n-form-item-gi>
        <n-form-item-gi :span="3">
          <div class="w-full">
            <div class="pb-1">
              宽度
              <span class="text-xs text-gray-400">Width</span>
              <n-tag class="float-right" size="small">{{ txt2imgParams.width }}</n-tag>
            </div>
            <n-slider v-model:value="txt2imgParams.width" :min="64" :max="2048" :step="1" />
          </div>
        </n-form-item-gi>
        <n-form-item-gi :span="3">
          <div class="w-full">
            <div class="pb-1">
              高度
              <span class="text-xs text-gray-400">Height</span>
              <n-tag class="float-right" size="small">{{ txt2imgParams.height }}</n-tag>
            </div>
            <n-slider v-model:value="txt2imgParams.height" :min="64" :max="2048" :step="1" />
          </div>
        </n-form-item-gi>
        <n-form-item-gi :span="3">
          <div class="w-full">
            <div class="pb-1">
              计算步数
              <span class="text-xs text-gray-400">Steps</span>
              <n-tag class="float-right" size="small">{{ txt2imgParams.steps }}</n-tag>
            </div>
            <n-slider v-model:value="txt2imgParams.steps" :min="1" :max="99" :step="1" />
          </div>
        </n-form-item-gi>
        <n-form-item-gi :span="3">
          <div class="w-full">
            <div class="pb-1">
              精准度
              <span class="text-xs text-gray-400">CFG Scale</span>
              <n-tag class="float-right" size="small">{{ txt2imgParams.cfg_scale }}</n-tag>
            </div>
            <n-slider v-model:value="txt2imgParams.cfg_scale" :min="1" :max="30" :step="1" />
          </div>
        </n-form-item-gi>
        <n-form-item-gi :span="3">
          <div class="w-full">
            <div class="pb-1">
              采样器
              <span class="text-xs text-gray-400">Sampler</span>
            </div>
            <selectDict
              v-model:dict-code="txt2imgParams.sampler_index"
              :dict-name="txt2imgParams.sampler_name"
              dict-type="SAMPLER"
            />
          </div>
        </n-form-item-gi>
        <n-form-item-gi :span="3">
          <div class="w-full">
            <div class="pb-1">使用指定种子</div>
            <n-input-number v-model:value="txt2imgParams.seed" :show-button="false" />
          </div>
        </n-form-item-gi>
        <n-grid-item :span="6">
          <n-collapse arrow-placement="right">
            <!-- <n-collapse-item title="ControlNet" name="1">
                      <div class="w-full">
                        <n-radio-group name="left-size">
                          <n-radio-button value="small">控制1</n-radio-button>
                          <n-radio-button value="medium">控制2</n-radio-button>
                          <n-radio-button value="large">控制3</n-radio-button>
                        </n-radio-group>
                        <div class="py-1">
                          控制方式
                          <n-switch v-model:value="active" size="small" class="float-right">
                            <template #checked>预处理</template>
                            <template #unchecked>不预处理</template>
                          </n-switch>
                        </div>
                        <n-select v-model:value="styleSampler" :options="styleOptions" />
                      </div>
                    </n-collapse-item> -->
            <n-collapse-item title="高级设置" name="2">
              <div class="w-full">
                <div class="pb-1">
                  面部修复
                  <span class="text-xs text-gray-400">Restore faces</span>
                  <n-switch v-model:value="txt2imgParams.restore_faces" size="small" class="float-right" />
                </div>
                <div>
                  高分辨率修复
                  <span class="text-xs text-gray-400">Hires fix</span>
                  <n-switch v-model:value="txt2imgParams.enable_hr" size="small" class="float-right" />
                  <n-collapse-transition :show="txt2imgParams.enable_hr" class="pt-1">
                    <n-grid :cols="6" :x-gap="25">
                      <n-form-item-gi :span="3">
                        <div class="w-full">
                          <div class="pb-1">
                            宽度
                            <span class="text-xs text-gray-400">Width</span>
                            <n-tag class="float-right" size="small">{{ txt2imgParams.hr_resize_x }}</n-tag>
                          </div>
                          <n-slider v-model:value="txt2imgParams.hr_resize_x" :min="512" :max="3840" :step="1" />
                        </div>
                      </n-form-item-gi>
                      <n-form-item-gi :span="3">
                        <div class="w-full">
                          <div class="pb-1">
                            高度
                            <span class="text-xs text-gray-400">Height</span>
                            <n-tag class="float-right" size="small">
                              {{ txt2imgParams.hr_resize_y }}
                            </n-tag>
                          </div>
                          <n-slider v-model:value="txt2imgParams.hr_resize_y" :min="512" :max="3840" :step="1" />
                        </div>
                      </n-form-item-gi>
                      <n-form-item-gi :span="6">
                        <div class="w-full">
                          <div class="pb-1">
                            高清化算法
                            <span class="text-xs text-gray-400">Upscaler 1</span>
                          </div>
                          <selectDict v-model:dict-code="txt2imgParams.hr_upscaler" dict-type="HIRES_FIX_UPSCALER" />
                        </div>
                      </n-form-item-gi>
                      <n-form-item-gi :span="6">
                        <div class="w-full">
                          <div class="pb-1">
                            高分辨率采样步数
                            <span class="text-xs text-gray-400">Hires steps</span>
                            <n-tag class="float-right" size="small">
                              {{ txt2imgParams.hr_second_pass_steps }}
                            </n-tag>
                          </div>
                          <n-slider v-model:value="txt2imgParams.hr_second_pass_steps" :min="0" :max="150" :step="1" />
                        </div>
                      </n-form-item-gi>
                      <n-form-item-gi :span="6">
                        <div class="w-full">
                          <div class="pb-1">
                            重绘强度
                            <span class="text-xs text-gray-400">Denoising strength</span>
                            <n-tag class="float-right" size="small">
                              {{ txt2imgParams.denoising_strength }}
                            </n-tag>
                          </div>
                          <n-slider v-model:value="txt2imgParams.denoising_strength" :min="0" :max="1" :step="0.1" />
                        </div>
                      </n-form-item-gi>
                    </n-grid>
                  </n-collapse-transition>
                </div>
              </div>
            </n-collapse-item>
          </n-collapse>
        </n-grid-item>
      </n-grid>
    </n-form>
  </div>
</template>

<script setup lang="ts">
  import { ref, PropType } from 'vue';
  import selectLora from './select-lora.vue';
  import { Txt2ImgParams } from '@/models/draw';

  const props = defineProps({
    sdParams: {
      type: Object as PropType<Txt2ImgParams>,
      default: null,
    },

    loraList: {
      type: Array<String>,
      default: [],
    },
  });

  const txt2imgParams = ref<Txt2ImgParams>(props.sdParams);
  const loraListValue = ref(props.loraList);
  const emit = defineEmits(['update:loraList']);

  const selectedLora = () => {
    console.log(loraListValue.value);
    emit('update:loraList', loraListValue.value);
  };
</script>
