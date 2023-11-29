<script setup lang="ts">
  import {
    ChatbubblesOutline,
    AddCircleOutline,
    ChatboxOutline,
    TrashOutline,
    PencilOutline,
    SettingsOutline,
    GridOutline,
  } from '@vicons/ionicons5';
  import { MenuFoldOutlined } from '@vicons/antd';
  import { ref } from 'vue';

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
      <div class="relative flex h-full w-[260px] flex-col p-4 transition-all bg-[#ffffff99]">
        <div class="flex flex-row justify-between h-10">
          <div class="flex items-center text-gray-500">
            <n-icon size="22" class="mx-2">
              <ChatbubblesOutline />
            </n-icon>
            <div>对话列表</div>
          </div>
          <n-button :bordered="false" class="action-button">
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
        <div class="flex-grow overflow-auto">
          <div class="mt-4">
            <div class="flex flex-col w-full gap-4">
              <div class="list-chat">
                <n-button :bordered="false" class="list-chat-button">
                  <template #icon>
                    <n-icon size="14">
                      <ChatboxOutline />
                    </n-icon>
                  </template>
                  <n-ellipsis :tooltip="false" class="text-[12.5px]">
                    我们团队有数据分析、可视化报表、ab test平台三个产品，...
                  </n-ellipsis>
                </n-button>
              </div>

              <div class="list-chat">
                <n-button :bordered="false" class="list-chat-button list-chat-button-selected">
                  <template #icon>
                    <n-icon size="14">
                      <ChatboxOutline />
                    </n-icon>
                  </template>
                  <n-ellipsis :tooltip="false" class="text-[12.5px] text-left" style="width: 160px">
                    我们团队有数据
                  </n-ellipsis>
                  <div class="flex">
                    <n-button :bordered="false" class="list-chat-edit-button">
                      <template #icon>
                        <n-icon size="14">
                          <PencilOutline />
                        </n-icon>
                      </template>
                    </n-button>
                    <n-button :bordered="false" class="list-chat-edit-button">
                      <template #icon>
                        <n-icon size="14">
                          <TrashOutline />
                        </n-icon>
                      </template>
                    </n-button>
                  </div>
                </n-button>
              </div>
            </div>
          </div>
        </div>

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
                <TrashOutline />
              </n-icon>
            </template>
            导入对话
          </n-button>
          <n-button :bordered="false" class="gap-3 hover:bg-gray-500/10">
            <template #icon>
              <n-icon size="14">
                <TrashOutline />
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
          class="absolute top-0 left-0 z-10 flex justify-between flex-grow-0 w-full px-3 py-2 lg:py-4 lg:px-6 bg-gradient-to-t from-transparent via-white/50 to-white"
        >
          <div class="flex gap-3">
            <div
              class="relative w-52 h-[40px] bg-gray-200 rounded-md text-neutral-800 text-sm flex items-center"
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
            <div class="mx-auto flex flex-col space-y-4 px-6 md:px-0 sm:max-w-[600px]">
              <div class="text-4xl font-semibold text-center text-gray-800">在对话中完成工作</div>
              <div class="text-base text-center text-gray-500">
                我是一个智能对话系统，可以回答问题、查找资料、提供建议和执行简单操作，帮助你更高效地获取所需信息并提供支持。
              </div>
            </div>
          </div>
          <div
            class="bottom-0 left-0 w-full pb-2 border-transparent bg-gradient-to-b from-transparent via-white/50 to-white"
          >
            <div
              class="stretch flex flex-row gap-3 last:mb-3 mx-2 mt-12 md:mx-4 md:mt-[52px] md:last:mb-6 lg:mx-auto lg:max-w-3xl"
            >
              <div
                class="relative mx-2 flex w-full flex-grow flex-col rounded-lg border border-black/10 bg-white shadow-[0_0_10px_rgba(0,0,0,0.10)]"
              >
                <textarea
                  class="w-full px-6 py-4 pr-12 m-0 text-black bg-transparent border-0 resize-none placeholder:truncate"
                  placeholder="输入一条消息或键入“/”以选择提示..."
                  rows="1"
                  style="
                    resize: none;
                    max-height: 300px;
                    overflow: hidden;
                    height: 52px;
                    bottom: 52px;
                  "
                ></textarea>
                <button
                  class="absolute right-4 bottom-2.5 rounded-sm p-1 text-neutral-800 opacity-60 hover:bg-neutral-200 hover:text-neutral-900"
                >
                  <svg viewBox="0 0 24 24" width="24px" height="24px" style="display: block">
                    <path
                      fill-rule="evenodd"
                      clip-rule="evenodd"
                      d="M4.07442 11.9245C3.28586 11.5473 3.32665 10.4112 4.14023 10.0916L18.4344 4.47604C19.2472 4.15672 20.0501 4.95962 19.7308 5.77245L14.1152 20.0666C13.7956 20.8802 12.6595 20.9209 12.2823 20.1324L9.62684 14.58L4.07442 11.9245ZM11.1365 14.1611L13.1357 18.3411L17.8397 6.36713L5.86575 11.0712L10.0457 13.0703L12.3869 10.7291C12.6881 10.4278 13.1765 10.4278 13.4777 10.7291C13.779 11.0303 13.779 11.5187 13.4777 11.8199L11.1365 14.1611Z"
                      fill-opacity=".9"
                      fill="#333333"
                    ></path>
                  </svg>
                </button>
              </div>
            </div>
            <div
              class="flex flex-wrap justify-center w-full gap-3 px-2 mx-2 mt-6 md:last:mb-6 lg:mx-auto lg:max-w-3xl"
            >
              <div
                class="cursor-pointer px-4 py-2 text-gy1 text-xs border border-[#D8DAE1] rounded-l-full rounded-r-full hover:border-[#0052D9] hover:text-[#0052D9] hover:shadow-lg transition-all"
              >
                📃 设计调研问卷 -&gt;
              </div>
              <div
                class="cursor-pointer px-4 py-2 text-gy1 text-xs border border-[#D8DAE1] rounded-l-full rounded-r-full hover:border-[#0052D9] hover:text-[#0052D9] hover:shadow-lg transition-all"
              >
                📁 设计访谈大纲 -&gt;
              </div>
              <div
                class="cursor-pointer px-4 py-2 text-gy1 text-xs border border-[#D8DAE1] rounded-l-full rounded-r-full hover:border-[#0052D9] hover:text-[#0052D9] hover:shadow-lg transition-all"
              >
                🗣 英文翻译员 -&gt;
              </div>
              <div
                class="cursor-pointer px-4 py-2 text-gy1 text-xs border border-[#D8DAE1] rounded-l-full rounded-r-full hover:border-[#0052D9] hover:text-[#0052D9] hover:shadow-lg transition-all"
              >
                📝 文案润色员 -&gt;
              </div>
              <div
                class="cursor-pointer px-4 py-2 text-gy1 text-xs border border-[#D8DAE1] rounded-l-full rounded-r-full hover:border-[#0052D9] hover:text-[#0052D9] hover:shadow-lg transition-all"
              >
                📑 写产品文档 -&gt;
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="less" scoped>
  .llm-select::v-deep {
    .n-base-selection-label {
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

  .list-chat {
    @apply relative;
    @apply flex;
    @apply items-center;

    &-button {
      @apply w-full;
      @apply h-11;
      background-color: #ebecf0;
      border-radius: 5px;

      &-selected {
        border: solid 2px #5e8cdc;
        background-color: #d4e3fc;
        justify-content: left;
      }
    }

    &-button:hover {
      background-color: #d4e3fc;
    }

    &-edit-button {
      width: 20px;
      min-width: 20px;
      padding: 10px;
      color: #0052d9;
      @apply hover:text-neutral-400;
    }
  }
</style>
