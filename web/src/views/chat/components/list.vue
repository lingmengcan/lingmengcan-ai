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
  import { Dialog } from '@/models/chat';

  const chatStore = useChatStore();

  const dialogList = computed(() => chatStore.dialogList);

  async function handleSelect({ dialogId }: Dialog) {
    if (isActive(dialogId)) return;

    // if (chatStore.activeId) chatStore.updateDialog(dialogId);
    await chatStore.setActive(dialogId);
  }

  function handleEdit(item: Dialog, isEdit: boolean, event?: MouseEvent) {
    event?.stopPropagation();
    item.isEdit = isEdit;
    chatStore.updateDialog(item);
  }

  function handleDelete(item: Dialog, event?: MouseEvent) {
    event?.stopPropagation();
    chatStore.deleteDialog(item);
  }

  function isActive(dialogId: string | undefined) {
    return chatStore.activeId === dialogId;
  }
</script>

<template>
  <n-scrollbar>
    <div class="mt-4">
      <div class="flex flex-col w-full gap-4">
        <div v-for="(item, index) of dialogList" :key="index" class="list-chat">
          <n-button
            :bordered="false"
            class="list-chat-button"
            :class="isActive(item.dialogId) && ['list-chat-button-selected']"
            @click="handleSelect(item)"
          >
            <template #icon>
              <n-icon size="14">
                <ChatboxOutline />
              </n-icon>
            </template>
            <n-input v-if="item.isEdit" v-model:value="item.dialogName" class="text-left" />
            <n-ellipsis
              v-else
              :tooltip="false"
              class="text-[12.5px]"
              :class="isActive(item.dialogId) && ['w-40', 'text-left']"
            >
              {{ item.dialogName }}
            </n-ellipsis>

            <div v-if="isActive(item.dialogId)" class="flex">
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

                <n-popconfirm placement="top" @positive-click="handleDelete(item, $event)">
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
