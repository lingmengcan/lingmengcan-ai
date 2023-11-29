<script setup lang="ts">
  import {
    ChatbubblesOutline,
    AddCircleOutline,
    TrashOutline,
    SettingsOutline,
    GridOutline,
    PaperPlaneOutline,
    CloudDownloadOutline,
    CloudUploadOutline,
  } from '@vicons/ionicons5';
  import { MenuFoldOutlined } from '@vicons/antd';
  import { ref } from 'vue';
  import List from './components/list.vue';

  const chatListVisable = ref(true);

  const selectedLlm = ref('ChatGLM3');

  const llmOptions = [
    {
      label: 'ChatGLM3',
      value: 'ChatGLM3',
    },
    {
      label: 'GPT-3.5',
      value: 'GPT-3.5',
    },
  ];
</script>
<template>
  <div class="flex w-full h-full overflow-hidden rounded-md">
    <div>
      <div
        v-if="chatListVisable"
        class="relative flex h-full w-[260px] flex-col p-4 transition-all bg-[#ffffff99]"
      >
        <div class="flex flex-row justify-between h-10">
          <div class="flex items-center text-gray-500">
            <n-icon size="22" class="mx-2">
              <ChatbubblesOutline />
            </n-icon>
            <div>对话列表</div>
          </div>
          <n-button
            :bordered="false"
            class="action-button"
            @click="chatListVisable = !chatListVisable"
          >
            <template #icon>
              <n-icon>
                <MenuFoldOutlined />
              </n-icon>
            </template>
          </n-button>
        </div>
        <div class="mt-4">
          <n-button dashed class="new-chat-button">
            <template #icon>
              <n-icon>
                <AddCircleOutline />
              </n-icon>
            </template>
            创建新对话
          </n-button>
        </div>

        <List />

        <div class="flex-col">
          <n-button :bordered="false" class="gap-3 hover:bg-gray-500/10">
            <template #icon>
              <n-icon size="14">
                <TrashOutline />
              </n-icon>
            </template>
            清空列表
          </n-button>
          <n-button :bordered="false" class="gap-3 hover:bg-gray-500/10">
            <template #icon>
              <n-icon size="14">
                <CloudUploadOutline />
              </n-icon>
            </template>
            导入对话
          </n-button>
          <n-button :bordered="false" class="gap-3 hover:bg-gray-500/10">
            <template #icon>
              <n-icon size="14">
                <CloudDownloadOutline />
              </n-icon>
            </template>
            导出对话
          </n-button>
        </div>
      </div>
    </div>
    <div class="flex-1">
      <div class="relative flex h-full overflow-hidden bg-white">
        <div
          class="absolute z-10 flex justify-between w-full lg:py-4 lg:px-6 bg-gradient-to-t from-transparent via-white/50 to-white"
        >
          <div class="flex gap-3">
            <n-button
              v-if="!chatListVisable"
              :bordered="false"
              class="action-button"
              @click="chatListVisable = !chatListVisable"
            >
              <template #icon>
                <n-icon>
                  <ChatbubblesOutline />
                </n-icon>
              </template>
            </n-button>

            <div
              class="relative z-0 w-52 h-[40px] mr-9 bg-gray-200 rounded-sm text-neutral-800 text-sm flex items-center"
            >
              <n-select
                v-model:value="selectedLlm"
                :bordered="false"
                :options="llmOptions"
                class="llm-select"
              />
              <n-button :bordered="false" class="action-button action-button-border-l">
                <template #icon>
                  <n-icon size="18">
                    <SettingsOutline />
                  </n-icon>
                </template>
              </n-button>
            </div>
          </div>
          <div class="relative flex">
            <n-button :bordered="false" class="action-button">
              <template #icon>
                <n-icon size="18">
                  <GridOutline />
                </n-icon>
              </template>
            </n-button>
          </div>
        </div>
        <div class="flex flex-col justify-center flex-auto overflow-y-auto">
          <div class="max-h-full overflow-x-hidden">
            <div class="mx-auto space-y-4 max-w-[600px]">
              <div class="text-4xl font-semibold text-center text-gray-800">
                你好，我是一个智能对话系统
              </div>
              <div class="text-base text-center text-gray-500">
                作为你的智能伙伴，可以回答问题、查找资料、提供建议和执行简单操作，帮助你更高效地获取所需信息并提供支持。
              </div>
            </div>
          </div>
          <div
            class="w-full pb-2 border-transparent bg-gradient-to-b from-transparent via-white/50 to-white"
          >
            <div
              class="stretch flex flex-row gap-3 last:mb-3 mx-2 mt-12 md:mx-4 md:mt-[52px] md:last:mb-6 lg:mx-auto lg:max-w-3xl"
            >
              <n-input
                type="textarea"
                rows="1"
                autosize
                round
                class="max-h-72 py-2 h-[52px] resize-none"
                placeholder="输入一条消息或键入“/”以选择提示..."
              >
                <template #suffix>
                  <n-button :bordered="false" style="width: 20px">
                    <template #icon>
                      <n-icon size="16">
                        <PaperPlaneOutline />
                      </n-icon>
                    </template>
                  </n-button>
                </template>
              </n-input>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="less" scoped>
  .llm-select {
    :deep(.n-base-selection-label) {
      margin-left: 3px;
      border: none;
      background-color: transparent;
    }
  }

  .action-button {
    @apply bg-gray-200;
    @apply w-10;
    @apply h-10;
    @apply hover:opacity-70;
    border-radius: 0;

    &-border-l {
      border-left: #d8e1f0 1px solid;
    }
  }

  .new-chat-button {
    @apply bg-white;
    @apply w-full;
    @apply h-10;
  }
</style>
