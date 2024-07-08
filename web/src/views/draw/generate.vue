<template>
  <div class="flex w-full h-full overflow-hidden rounded-md">
    <div class="relative flex h-full w-[500px] flex-col py-4 transition-all bg-[#ffffff99]">
      <div class="px-4">
        <span class="text-base">模型：</span>
        <n-tag>{{ modelName }}</n-tag>
        <selectModel @selected="handleSelectedModel" />
      </div>
      <n-tabs size="large" justify-content="space-evenly" type="line" animated class="flex-1 overflow-hidden">
        <n-tab-pane name="txt2img" tab="文生图" class="flex flex-col h-full">
          <div class="flex-1 px-4 overflow-auto">
            <n-form :show-label="false">
              <n-grid :cols="6" :x-gap="25">
                <n-form-item-gi :span="6">
                  <div class="w-full">
                    <div class="pb-1">
                      个性化生成
                      <span class="text-xs text-gray-400">LoRA</span>
                    </div>
                    <selectLora :options="modelOptions">
                      <template #default>
                        <option value="option1">Option 1</option>
                        <option value="option2">Option 2</option>
                        <option value="option3" disabled>Option 3 (Disabled)</option>
                      </template>
                    </selectLora>
                  </div>
                </n-form-item-gi>
                <n-form-item-gi :span="6">
                  <div class="w-full">
                    <div class="pb-1">
                      描述词
                      <span class="text-xs text-gray-400">Prompt</span>
                    </div>
                    <n-input v-model:value="prompt" type="textarea" rows="5" placeholder="Enter prompt here..." />
                  </div>
                </n-form-item-gi>
                <n-form-item-gi :span="6">
                  <div class="w-full">
                    <div class="pb-1">
                      反向词
                      <span class="text-xs text-gray-400">Negative Prompt</span>
                    </div>
                    <n-input
                      v-model:value="negativePrompt"
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
                      <n-tag class="float-right" size="small">{{ batchCount }}</n-tag>
                    </div>
                    <n-slider :min="1" :max="5" :step="1" v-model:value="batchCount" />
                  </div>
                </n-form-item-gi>
                <n-form-item-gi :span="3">
                  <div class="w-full">
                    <div class="pb-1">
                      宽度
                      <span class="text-xs text-gray-400">Width</span>
                      <n-tag class="float-right" size="small">{{ imageWidth }}</n-tag>
                    </div>
                    <n-slider :min="64" :max="2048" :step="1" v-model:value="imageWidth" />
                  </div>
                </n-form-item-gi>
                <n-form-item-gi :span="3">
                  <div class="w-full">
                    <div class="pb-1">
                      高度
                      <span class="text-xs text-gray-400">Height</span>
                      <n-tag class="float-right" size="small">{{ imageHeight }}</n-tag>
                    </div>
                    <n-slider :min="64" :max="2048" :step="1" v-model:value="imageHeight" />
                  </div>
                </n-form-item-gi>
                <n-form-item-gi :span="3">
                  <div class="w-full">
                    <div class="pb-1">
                      计算步数
                      <span class="text-xs text-gray-400">Steps</span>
                      <n-tag class="float-right" size="small">{{ steps }}</n-tag>
                    </div>
                    <n-slider :min="1" :max="99" :step="1" v-model:value="steps" />
                  </div>
                </n-form-item-gi>
                <n-form-item-gi :span="3">
                  <div class="w-full">
                    <div class="pb-1">
                      精准度
                      <span class="text-xs text-gray-400">CFG Scale</span>
                      <n-tag class="float-right" size="small">{{ cfgScale }}</n-tag>
                    </div>
                    <n-slider :min="1" :max="30" :step="1" v-model:value="cfgScale" />
                  </div>
                </n-form-item-gi>
                <n-form-item-gi :span="3">
                  <div class="w-full">
                    <div class="pb-1">
                      采样器
                      <span class="text-xs text-gray-400">Sampler</span>
                    </div>
                    <selectDict v-model:dict-code="sampler" dict-type="SAMPLER" />
                  </div>
                </n-form-item-gi>
                <n-form-item-gi :span="3">
                  <div class="w-full">
                    <div class="pb-1">
                      使用指定种子
                      <n-switch v-model:value="neededSeed" size="small" class="float-right">
                        <template #checked>开</template>
                        <template #unchecked>关</template>
                      </n-switch>
                    </div>
                    <n-input v-model:value="seed" />
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
                          <n-radio-button value="large">控制4</n-radio-button>
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
                        <!-- <div class="pb-1">
                          面部修复
                          <span class="text-xs text-gray-400">Restore faces</span>
                          <n-switch v-model:value="active" size="small" class="float-right" />
                          <n-collapse-transition :show="show">
                            <n-grid :cols="6" :x-gap="25">
                              <n-form-item-gi :span="6">
                                <div class="w-full">
                                  <div class="pb-1">
                                    面部修复程度
                                    <span class="text-xs text-gray-400">GFPGAN visibility</span>
                                    <n-tag class="float-right" size="small">{{ step }}</n-tag>
                                  </div>
                                  <n-slider :min="0" :max="1" :step="0.01" />
                                </div>
                              </n-form-item-gi>
                              <n-form-item-gi :span="3">
                                <div class="w-full">
                                  <div class="pb-1">
                                    面部重建程度
                                    <n-tag class="float-right" size="small">{{ scale }}</n-tag>
                                  </div>
                                  <n-slider :min="0" :max="1" :step="0.01" />
                                </div>
                              </n-form-item-gi>
                              <n-form-item-gi :span="3">
                                <div class="w-full">
                                  <div class="pb-1">
                                    面部重建权重
                                    <n-tag class="float-right" size="small">{{ scale }}</n-tag>
                                  </div>
                                  <n-slider :min="0" :max="1" :step="0.01" />
                                </div>
                              </n-form-item-gi>
                            </n-grid>
                          </n-collapse-transition>
                        </div> -->
                        <div>
                          高分辨率修复
                          <span class="text-xs text-gray-400">Hires fix</span>
                          <n-switch v-model:value="upscaleOpened" size="small" class="float-right" />
                          <n-collapse-transition :show="upscaleOpened" class="pt-1">
                            <n-grid :cols="6" :x-gap="25">
                              <n-form-item-gi :span="3">
                                <div class="w-full">
                                  <div class="pb-1">
                                    宽度
                                    <span class="text-xs text-gray-400">Width</span>
                                    <n-tag class="float-right" size="small">{{ resizeWidth }}</n-tag>
                                  </div>
                                  <n-slider :min="512" :max="3840" :step="1" v-model:value="resizeWidth" />
                                </div>
                              </n-form-item-gi>
                              <n-form-item-gi :span="3">
                                <div class="w-full">
                                  <div class="pb-1">
                                    高度
                                    <span class="text-xs text-gray-400">Height</span>
                                    <n-tag class="float-right" size="small">
                                      {{ resizeHeight }}
                                    </n-tag>
                                  </div>
                                  <n-slider :min="512" :max="3840" :step="1" v-model:value="resizeHeight" />
                                </div>
                              </n-form-item-gi>
                              <n-form-item-gi :span="6">
                                <div class="w-full">
                                  <div class="pb-1">
                                    高清化算法
                                    <span class="text-xs text-gray-400">Upscaler 1</span>
                                  </div>
                                  <selectDict v-model:dict-code="sampler" dict-type="SAMPLER" />
                                </div>
                              </n-form-item-gi>
                              <n-form-item-gi :span="6">
                                <div class="w-full">
                                  <div class="pb-1">
                                    高分辨率采样步数
                                    <span class="text-xs text-gray-400">Hires steps</span>
                                    <n-tag class="float-right" size="small">{{ hiresSteps }}</n-tag>
                                  </div>
                                  <n-slider :min="0" :max="150" :step="1" v-model:value="hiresSteps" />
                                </div>
                              </n-form-item-gi>
                              <n-form-item-gi :span="6">
                                <div class="w-full">
                                  <div class="pb-1">
                                    重绘强度
                                    <span class="text-xs text-gray-400">Denoising strength</span>
                                    <n-tag class="float-right" size="small">{{ denoisingStrength }}</n-tag>
                                  </div>
                                  <n-slider :min="0" :max="1" :step="0.1" v-model:value="denoisingStrength" />
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
        </n-tab-pane>
        <n-tab-pane name="img2img" tab="图生图" disabled></n-tab-pane>
        <n-tab-pane name="2video" tab="视频生成" disabled>视频生成</n-tab-pane>
      </n-tabs>
    </div>
  </div>
  <n-card v-if="imageUrl">
    <img :src="imageUrl" alt="Generated Image" style="max-width: 100%" />
  </n-card>
</template>

<script setup lang="ts">
  import { ref } from 'vue';
  import selectModel from './components/select-model.vue';
  import selectLora from './components/select-lora.vue';

  const modelName = ref('SD V1.5');
  const modelOptions = ref([{ label: 'Midjourney Model(5.2)', value: 'Midjourney Model(5.2)' }]);

  const prompt = ref(
    "Asian girl with delicate collarbones, looking at the audience and smiling. Her hair was slightly curly, and she breathed the warmth of the sun. Around her neck, there is a delicate necklace that matches the metal buckle of the tank top. The background of the picture is a blooming flower sea, which adds vitality to the whole work. The Asian girl's black hair glistened in the sun. The whole painting is full of life and artistic sense, unforgettable.",
  );

  const negativePrompt = ref(
    'nsfw, (worst quality:2), (low quality:2), (normal quality:2), lowers, monochrome, blurry, (wrong:2), (Mutated hands and fingers:1.5), text',
  );

  const batchCount = ref(1);
  const imageWidth = ref(512);
  const imageHeight = ref(512);
  const steps = ref(20);
  const cfgScale = ref(7);
  const sampler = ref('k_dpmpp_2m_ karras');
  const neededSeed = ref(false);
  const seed = ref(-1);
  const resizeWidth = ref(1024);
  const resizeHeight = ref(1024);
  const hiresSteps = ref(20);
  const denoisingStrength = ref(0.7);

  const upscaleOpened = ref(false);

  const imageUrl = ref(null);

  function handleSelectedModel(item: string) {
    modelName.value = item;
  }
</script>

<style lang="less" scoped></style>
