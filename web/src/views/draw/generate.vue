<template>
  <div class="flex w-full h-full overflow-hidden rounded-md">
    <div class="relative flex h-full w-[500px] flex-col py-3 transition-all bg-[#ffffff99]">
      <div class="px-4">
        <span class="text-base">模型：</span>
        <n-tag>{{ modelName }}</n-tag>
        <selectModel
          v-model:model-name="txt2imgParams.override_settings.sd_model_checkpoint"
          @selected="handleSelectedModel"
        />
      </div>
      <n-tabs size="large" justify-content="space-evenly" type="line" animated class="flex-1 overflow-hidden">
        <n-tab-pane name="txt2img" tab="文生图" class="flex flex-col h-full">
          <div class="flex-1 px-4 pb-4 overflow-auto">
            <n-form :show-label="false">
              <n-grid :cols="6" :x-gap="25">
                <n-form-item-gi :span="6">
                  <div class="w-full">
                    <div class="pb-1">
                      个性化生成
                      <span class="text-xs text-gray-400">LoRA</span>
                    </div>
                    <selectLora />
                  </div>
                </n-form-item-gi>
                <n-form-item-gi :span="6">
                  <div class="w-full">
                    <div class="pb-1">
                      描述词
                      <span class="text-xs text-gray-400">Prompt</span>
                    </div>
                    <n-input
                      v-model:value="txt2imgParams.prompt"
                      type="textarea"
                      rows="5"
                      placeholder="Enter prompt here..."
                    />
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
                                  <n-slider
                                    v-model:value="txt2imgParams.hr_resize_x"
                                    :min="512"
                                    :max="3840"
                                    :step="1"
                                  />
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
                                  <n-slider
                                    v-model:value="txt2imgParams.hr_resize_y"
                                    :min="512"
                                    :max="3840"
                                    :step="1"
                                  />
                                </div>
                              </n-form-item-gi>
                              <n-form-item-gi :span="6">
                                <div class="w-full">
                                  <div class="pb-1">
                                    高清化算法
                                    <span class="text-xs text-gray-400">Upscaler 1</span>
                                  </div>
                                  <selectDict v-model:dict-code="txt2imgParams.hr_upscaler" dict-type="SAMPLER" />
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
                                  <n-slider
                                    v-model:value="txt2imgParams.hr_second_pass_steps"
                                    :min="0"
                                    :max="150"
                                    :step="1"
                                  />
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
                                  <n-slider
                                    v-model:value="txt2imgParams.denoising_strength"
                                    :min="0"
                                    :max="1"
                                    :step="0.1"
                                  />
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
      <div class="flex justify-center pt-3 border-t">
        <n-button type="primary" :loading="generating" @click="handleGenerate">生成图片</n-button>
      </div>
    </div>

    <n-infinite-scroll class="flex-1 pl-5" :distance="10" @load="handleLoad">
      <div v-masonry transition-duration="0.3s" :gutter="12">
        <template v-if="generating">
          <div
            v-for="num in txt2imgParams.batch_size"
            :key="num"
            v-masonry-tile
            class="flex items-center justify-center w-64 h-64 mb-3 bg-white rounded-md opacity-50"
          >
            <n-spin size="large" />
          </div>
        </template>

        <div v-for="image in images" :key="image.mediaId" v-masonry-tile class="w-64 masonry-item">
          <n-image :src="image.filePath" class="w-full mb-3 rounded-md" />
        </div>
      </div>
      <div v-if="scrolling" class="flex items-center justify-center">
        <n-spin size="small" />
        加载中...
      </div>
      <div v-if="noMore" class="flex items-center justify-center">没有更多了</div>
    </n-infinite-scroll>
  </div>
</template>

<script setup lang="ts">
  import { ref, reactive, onMounted, computed } from 'vue';
  import selectModel from './components/select-model.vue';
  import selectLora from './components/select-lora.vue';
  import { Media, Txt2ImgParams } from '@/models/draw';
  import { getMediaList, txt2img } from '@/api/draw';

  // 新增/修改弹窗数据初始化
  const txt2imgParams = reactive<Txt2ImgParams>({
    prompt: 'masterpiece, best quality, Winter, snow, forest, sun slanting, dark clouds',
    negative_prompt:
      'sfw, (worst quality:2), (low quality:2), (normal quality:2), lowers, monochrome, blurry, (wrong:2), (Mutated hands and fingers:1.5), text',
    seed: -1, // 随机种子，用于控制生成的随机性
    sampler_name: 'DPM++ 2M', // 采样器的名称
    batch_size: 1, // 每批次生成的图像数量
    steps: 20, // 生成步骤数
    cfg_scale: 7, // CFG比例，控制图像生成的一致性
    width: 512, // 图像宽度
    height: 512, // 图像高度
    denoising_strength: 0.7, // 去噪强度
    override_settings: { sd_model_checkpoint: 'v1-5pruned-emaonly' }, // 覆盖设置，包含自定义的设置
    enable_hr: false, // 是否启用高分辨率
    hr_upscaler: '', // 高分辨率上高清算法
    hr_second_pass_steps: 0, // 高分辨率第二阶段步骤数
    hr_resize_x: 1024, // 高分辨率调整后的宽度
    hr_resize_y: 1024, // 高分辨率调整后的高度
    sampler_index: 'DPM++ 2M', // 采样方法
  });

  const modelName = ref('v1-5pruned-emaonly');

  const generating = ref(false);

  // 定义图片数组
  const images = ref<Media[]>([]);
  const page = ref<number>(1);
  const pageSize = ref<number>(10);
  const itemCount = ref(0);
  const scrolling = ref(false);

  const noMore = computed(() => pageSize.value * page.value > itemCount.value);
  // 获取所有图片
  const getImages = async (currentPage: number, currentPageSize = 10) => {
    try {
      const requestData = {
        mediaType: 'image',
        status: 'completed',
        page: currentPage,
        pageSize: currentPageSize,
      };

      const res = await getMediaList(requestData);

      if (res?.code === 0) {
        if (currentPage === 1) {
          images.value = res.data?.list;
        } else {
          images.value.push(...res.data?.list);
        }

        page.value = currentPage;
        pageSize.value = currentPageSize;
        itemCount.value = res.data.count;
      }
    } catch (err) {
      images.value = [];
    }
  };

  function handleSelectedModel(item: string) {
    txt2imgParams.override_settings.sd_model_checkpoint = item;
    modelName.value = item;
  }

  const handleGenerate = async () => {
    generating.value = true;
    const requestData = {
      ...txt2imgParams,
    };

    const res = await txt2img(requestData);

    if (res?.code === 0) {
      generating.value = false;
      await getImages(page.value, pageSize.value);
    }
  };

  const handleLoad = async () => {
    if (scrolling.value || noMore.value) return;
    scrolling.value = true;
    await getImages(page.value + 1, pageSize.value);
    scrolling.value = false;
  };

  onMounted(async () => {
    await getImages(page.value, pageSize.value);
  });
</script>

<style lang="less" scoped></style>
