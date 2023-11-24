<!-- <template>
  <n-layout has-sider class="top-16 inset-2.5 chat-layout">
    <n-layout-sider :native-scrollbar="false" style="background-color: #ffffff99">
      <div class="left-header">
        <n-icon size="20" class="mr-2">
          <ChatbubblesOutline />
        </n-icon>
        <h2 class="title">对话列表</h2>
      </div>
    </n-layout-sider>
    <n-layout :native-scrollbar="false"> </n-layout>
  </n-layout>
</template>


<style lang="less" scoped>
  .chat-layout {
    background-color: transparent;
    position: absolute !important;

    .left-header {
      display: flex;
      align-items: center;
      justify-content: left;
      height: 64px;
      line-height: 64px;
      overflow: hidden;
      white-space: nowrap;
    }
  }
</style> -->

<script setup lang="ts">
  import { ChatbubblesOutline, AddCircleOutline } from '@vicons/ionicons5';
  import { MenuFoldOutlined } from '@vicons/antd';
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
          <n-button :bordered="false" class="menuout-button">
            <template #icon>
              <n-icon>
                <MenuFoldOutlined />
              </n-icon>
            </template>
          </n-button>
        </div>
        <div class="mt-4">
          <n-button
            dashed="true"
            class="w-full h-10 text-sidebar bg-white flex select-none border-dashed items-center justify-center gap-3 rounded-md border border-[#DCDCDC]-1 text-gy1 transition-colors duration-200 hover:bg-gray-300/10"
          >
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
              <div class="relative flex items-center">
                <n-button
                  class="flex w-full cursor-pointer items-center gap-3 rounded-lg p-3 text-sm transition-colors duration-200 border-2 hover:bg-[#d4e3fc] bg-gy2 border-transparent text-gy1"
                >
                  <template #icon>
                    <n-icon>
                      <AddCircleOutline />
                    </n-icon>
                  </template>
                  <div
                    class="relative max-h-5 flex-1 overflow-hidden text-ellipsis whitespace-nowrap break-all text-left text-[12.5px] leading-3 pr-1"
                  >
                    <n-ellipsis style="max-width: 160px">
                      我们团队有数据分析、可视化报表、ab test平台三个产品，...
                    </n-ellipsis>
                  </div>
                </n-button>
              </div>

              <div class="relative flex items-center">
                <button
                  class="flex w-full cursor-pointer items-center gap-3 rounded-lg p-3 text-sm transition-colors duration-200 border-2 hover:bg-[#d4e3fc] bg-gy2 border-transparent text-gy1"
                >
                  <div
                    class="relative max-h-5 flex-1 overflow-hidden text-ellipsis whitespace-nowrap break-all text-left text-[12.5px] leading-3 pr-1"
                  >
                    我们团队有数据分析、可视化报表、ab test平台三个产品，...
                  </div>
                </button>
              </div>
              <div class="relative flex items-center">
                <button
                  class="flex w-full cursor-pointer items-center gap-3 rounded-lg p-3 text-sm transition-colors duration-200 border-2 hover:bg-[#d4e3fc] bg-[#d4e3fc] border-[#0052d9] text-[#0052d9]"
                >
                  <svg viewBox="0 0 18 18" width="18px" height="18px" style="display: block">
                    <path
                      d="M5.21769 11.8125H14.625V4.5H3.375V13.3481L5.21769 11.8125ZM2.80356 15.2887C2.58374 15.4719 2.25 15.3156 2.25 15.0294V4.5C2.25 3.87868 2.75368 3.375 3.375 3.375H14.625C15.2463 3.375 15.75 3.87868 15.75 4.5V11.8125C15.75 12.4338 15.2463 12.9375 14.625 12.9375H5.625L2.80356 15.2887Z"
                      fill="#0052d9"
                      fill-opacity=".9"
                    ></path>
                  </svg>
                  <div
                    class="relative max-h-5 flex-1 overflow-hidden text-ellipsis whitespace-nowrap break-all text-left text-[12.5px] leading-3 pr-12"
                  >
                    我们团队有数据分析、可视化报表、ab test平台三个产品，...
                  </div>
                </button>
                <div class="absolute z-10 flex text-gray-300 right-1">
                  <button class="min-w-[20px] p-1 text-[#0052d9] hover:text-neutral-400">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="18"
                      height="18"
                      viewBox="0 0 24 24"
                      fill="none"
                      stroke="currentColor"
                      stroke-width="2"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      class="tabler-icon tabler-icon-pencil"
                    >
                      <path d="M4 20h4l10.5 -10.5a1.5 1.5 0 0 0 -4 -4l-10.5 10.5v4"></path>
                      <path d="M13.5 6.5l4 4"></path>
                    </svg>
                  </button>
                  <button class="min-w-[20px] p-1 text-[#0052d9] hover:text-neutral-400">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="18"
                      height="18"
                      viewBox="0 0 24 24"
                      fill="none"
                      stroke="currentColor"
                      stroke-width="2"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      class="tabler-icon tabler-icon-trash"
                    >
                      <path d="M4 7l16 0"></path>
                      <path d="M10 11l0 6"></path>
                      <path d="M14 11l0 6"></path>
                      <path d="M5 7l1 12a2 2 0 0 0 2 2h8a2 2 0 0 0 2 -2l1 -12"></path>
                      <path d="M9 7v-3a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v3"></path>
                    </svg>
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="flex flex-col items-center pt-1 space-y-1 text-sm border-t border-white/20">
          <button
            class="flex w-full cursor-pointer select-none items-center gap-3 rounded-md py-3 px-3 text-[14px] leading-3 text-gy1 transition-colors duration-200 hover:bg-gray-500/10"
          >
            <div>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="18"
                height="18"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
                class="tabler-icon tabler-icon-trash"
              >
                <path d="M4 7l16 0"></path>
                <path d="M10 11l0 6"></path>
                <path d="M14 11l0 6"></path>
                <path d="M5 7l1 12a2 2 0 0 0 2 2h8a2 2 0 0 0 2 -2l1 -12"></path>
                <path d="M9 7v-3a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v3"></path>
              </svg>
            </div>
            <span>清空列表</span>
          </button>
        </div>
      </div>
    </div>
    <div class="flex-1">
      <div
        class="relative flex flex-col flex-1 h-full overflow-hidden bg-white bg-repeat bg-chat-body bg-chat-body-size"
      >
        <div
          class="absolute top-0 left-0 z-10 flex justify-between flex-grow-0 w-full px-3 py-2 lg:py-4 lg:px-6 bg-gradient-to-t from-transparent via-white/50 to-white"
        >
          <div class="flex gap-3">
            <div class="relative h-[40px] text-neutral-800 text-sm flex items-center">
              <div
                class="relative rounded-l h-full px-5 py-2 flex items-center pr-10 cursor-pointer bg-gray-200 min-w-[10rem] overflow-hidden"
              >
                <div class="relative hover:opacity-70">GPT-4</div>
                <svg
                  viewBox="0 0 18 18"
                  width="18px"
                  height="18px"
                  class="absolute top-[50%] right-2 translate-y-[-50%] transition-all"
                  style="display: block"
                >
                  <path
                    d="M3.98282 7.26711L5.01696 6.23297L8.99989 10.2159L12.9828 6.23297L14.017 7.26711L8.99989 12.2842L3.98282 7.26711Z"
                    fill="#000"
                    fill-opacity=".9"
                  ></path>
                </svg>
                <div
                  class="p-2 z-20 absolute top-[calc(100%+0.5rem)] left-0 shadow-[0_0_10px_rgba(0,0,0,0.10)] pt-2 rounded-[0.38rem] bg-white transition-all max-h-0"
                >
                  <div
                    class="px-3 bg-white min-w-[10rem] max-w-[20rem] rounded-[0.19rem] hover:bg-[#F2F3FF] h-[2.25rem] leading-9 text-ellipsis whitespace-nowrap overflow-hidden break-all"
                  >
                    混元
                  </div>
                  <div
                    class="px-3 bg-white min-w-[10rem] max-w-[20rem] rounded-[0.19rem] hover:bg-[#F2F3FF] h-[2.25rem] leading-9 text-ellipsis whitespace-nowrap overflow-hidden break-all"
                  >
                    GPT-3.5
                  </div>
                  <div
                    class="px-3 bg-white min-w-[10rem] max-w-[20rem] rounded-[0.19rem] hover:bg-[#F2F3FF] h-[2.25rem] leading-9 text-ellipsis whitespace-nowrap overflow-hidden break-all"
                  >
                    G PT-4
                  </div>
                </div>
              </div>
              <button
                class="h-full px-3 bg-gray-200 border-l border-gray-300 rounded-r hover:opacity-70 false"
              >
                <svg viewBox="0 0 18 18" width="18px" height="18px" style="display: block">
                  <path
                    d="M12.3751 9C12.3751 10.864 10.8641 12.375 9.00013 12.375C7.13616 12.375 5.62513 10.864 5.62513 9C5.62513 7.13604 7.13616 5.625 9.00013 5.625C10.8641 5.625 12.3751 7.13604 12.3751 9ZM11.2501 9C11.2501 7.75736 10.2428 6.75 9.00013 6.75C7.75749 6.75 6.75013 7.75736 6.75013 9C6.75013 10.2426 7.75749 11.25 9.00013 11.25C10.2428 11.25 11.2501 10.2426 11.2501 9Z"
                    fill-opacity=".9"
                    fill="#333333"
                  ></path>
                  <path
                    d="M9.00013 1.40625L15.8201 5.20312V12.7969L9.00013 16.5938L2.18018 12.7969V5.20312L9.00013 1.40625ZM3.30518 5.8644V12.1356L9.00013 15.3062L14.6951 12.1356V5.8644L9.00013 2.69385L3.30518 5.8644Z"
                    fill-opacity=".9"
                    fill="#333333"
                  ></path>
                </svg>
              </button>
            </div>
          </div>
          <div class="relative flex">
            <button class="w-10 h-10 rounded-md bg-gy2 hover:opacity-70">
              <svg
                viewBox="0 0 24 24"
                width="18px"
                height="18px"
                class="mx-auto"
                style="display: block"
              >
                <path
                  fill-rule="evenodd"
                  clip-rule="evenodd"
                  d="M16.8999 4.40002H17.0999C18.4806 4.40002 19.5999 5.51931 19.5999 6.90002V7.10002C19.5999 8.48073 18.4806 9.60002 17.0999 9.60002H16.8999C15.5192 9.60002 14.3999 8.48073 14.3999 7.10002V6.90003C14.3999 5.51931 15.5192 4.40002 16.8999 4.40002ZM12.8999 6.90003C12.8999 4.69089 14.6908 2.90002 16.8999 2.90002H17.0999C19.309 2.90002 21.0999 4.69089 21.0999 6.90002V7.10002C21.0999 9.30916 19.309 11.1 17.0999 11.1H16.8999C14.6908 11.1 12.8999 9.30916 12.8999 7.10002V6.90003ZM4.5 9.5V4.5H9.5V9.5H4.5ZM3 4C3 3.44772 3.44772 3 4 3H10C10.5523 3 11 3.44772 11 4V10C11 10.5523 10.5523 11 10 11H4C3.44772 11 3 10.5523 3 10V4ZM4.5 19.5V14.5H9.5V19.5H4.5ZM3 14C3 13.4477 3.44772 13 4 13H10C10.5523 13 11 13.4477 11 14V20C11 20.5523 10.5523 21 10 21H4C3.44772 21 3 20.5523 3 20V14ZM14.5 14.5V19.5H19.5V14.5H14.5ZM14 13C13.4477 13 13 13.4477 13 14V20C13 20.5523 13.4477 21 14 21H20C20.5523 21 21 20.5523 21 20V14C21 13.4477 20.5523 13 20 13H14Z"
                  fill="#000A29"
                  fill-opacity=".9"
                ></path>
              </svg>
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="less" scoped>
  .menuout-button {
    @apply bg-gray-100;
    @apply w-10;
    @apply h-10;
  }
</style>
