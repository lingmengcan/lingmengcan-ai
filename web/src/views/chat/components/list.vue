<script lang="ts" setup>
  import {
    ChatboxOutline,
    TrashOutline,
    PencilOutline,
    CloseOutline,
    CheckmarkOutline,
  } from '@vicons/ionicons5';
  import { computed } from 'vue';
  import { useChatStore } from '@/store/modules/chat';
  import { ChatHistory } from '@/models/chat';

  const chatStore = useChatStore();

  const historyList = computed(() => chatStore.history);

  async function handleSelect({ uuid }: ChatHistory) {
    if (isActive(uuid)) return;

    if (chatStore.active) chatStore.updateHistory(chatStore.active, { isEdit: false });
    await chatStore.setActive(uuid);
  }

  function handleEdit({ uuid }: ChatHistory, isEdit: boolean, event?: MouseEvent) {
    event?.stopPropagation();
    chatStore.updateHistory(uuid, { isEdit });
  }

  function handleDelete(index: number, event?: MouseEvent) {
    event?.stopPropagation();
    chatStore.deleteHistory(index);
  }

  function isActive(uuid: number) {
    return chatStore.active === uuid;
  }
</script>

<template>
  <n-scrollbar>
    <div class="mt-4">
      <div class="flex flex-col w-full gap-4">
        <div v-for="(item, index) of historyList" :key="index" class="list-chat">
          <n-button
            :bordered="false"
            class="list-chat-button"
            :class="isActive(item.uuid) && ['list-chat-button-selected']"
            @click="handleSelect(item)"
          >
            <template #icon>
              <n-icon size="14">
                <ChatboxOutline />
              </n-icon>
            </template>
            <n-input v-if="item.isEdit" v-model:value="item.title" class="text-left" />
            <n-ellipsis
              v-else
              :tooltip="false"
              class="text-[12.5px]"
              :class="isActive(item.uuid) && ['w-40', 'text-left']"
            >
              {{ item.title }}
            </n-ellipsis>

            <div v-if="isActive(item.uuid)" class="flex">
              <template v-if="item.isEdit">
                <n-button
                  :bordered="false"
                  class="list-chat-edit-button"
                  @click="handleEdit(item, false, $event)"
                >
                  <template #icon>
                    <n-icon size="14">
                      <CheckmarkOutline />
                    </n-icon>
                  </template>
                </n-button>
                <n-button
                  :bordered="false"
                  class="list-chat-edit-button"
                  @click="item.isEdit = false"
                >
                  <template #icon>
                    <n-icon size="14">
                      <CloseOutline />
                    </n-icon>
                  </template>
                </n-button>
              </template>
              <template v-else>
                <n-button
                  :bordered="false"
                  class="list-chat-edit-button"
                  @click="handleEdit(item, true, $event)"
                >
                  <template #icon>
                    <n-icon size="14">
                      <PencilOutline />
                    </n-icon>
                  </template>
                </n-button>

                <n-popconfirm placement="top" @positive-click="handleDelete(index, $event)">
                  <template #trigger>
                    <n-button :bordered="false" class="list-chat-edit-button">
                      <template #icon>
                        <n-icon size="14">
                          <TrashOutline />
                        </n-icon>
                      </template>
                    </n-button>
                  </template>
                  删除后无法恢复，是否继续删除？
                </n-popconfirm>
              </template>
            </div>
          </n-button>
        </div>
      </div>
    </div>
  </n-scrollbar>
</template>

<style lang="less" scoped>
  .list-chat {
    @apply relative;
    @apply flex;
    @apply items-center;

    &-button {
      @apply w-full;
      @apply h-11;
      background-color: #ebecf0;
      border-radius: 5px;
      justify-content: left;

      &-selected {
        border: solid 2px #5e8cdc;
        background-color: #d4e3fc;
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
