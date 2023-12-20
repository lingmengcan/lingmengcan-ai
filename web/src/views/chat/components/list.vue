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
  import { Conversation } from '@/models/chat';

  const chatStore = useChatStore();

  const conversationList = computed(() => {
    const list = chatStore.conversationList;
    if (list.length === 0) {
      chatStore.getConversationList();
    }
    return list;
  });

  async function handleSelect({ conversationId }: Conversation) {
    if (isActive(conversationId)) return;

    await chatStore.setActive(conversationId);
  }

  function handleEdit(item: Conversation, isEdit: boolean, event?: MouseEvent) {
    event?.stopPropagation();
    item.isEdit = isEdit;
    if (!isEdit) {
      chatStore.updateConversation(item);
    }
  }

  function handleDelete(item: Conversation, event?: MouseEvent) {
    event?.stopPropagation();
    chatStore.deleteConversation(item);
  }

  function isActive(conversationId: string | undefined) {
    return chatStore.activeId === conversationId;
  }
</script>

<template>
  <n-scrollbar>
    <div class="mt-4">
      <div class="flex flex-col w-full gap-4">
        <div v-for="(item, index) of conversationList" :key="index" class="list-chat">
          <n-input v-if="item.isEdit" v-model:value="item.conversationName" class="list-chat-input">
            <template #suffix>
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
          </n-input>
          <n-button
            v-else
            :bordered="false"
            class="list-chat-button"
            :class="isActive(item.conversationId) && ['list-chat-button-selected']"
            @click="handleSelect(item)"
          >
            <template #icon>
              <n-icon size="14">
                <ChatboxOutline />
              </n-icon>
            </template>
            <n-ellipsis
              :tooltip="false"
              class="text-[12.5px]"
              :class="isActive(item.conversationId) && ['w-40', 'text-left']"
            >
              {{ item.conversationName }}
            </n-ellipsis>

            <div v-if="isActive(item.conversationId)" class="flex">
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
            </div>
          </n-button>
        </div>
      </div>
    </div>
  </n-scrollbar>
</template>

<style lang="less" scoped>
  .list-chat {
    @apply relative flex items-center;

    &-input {
      @apply w-full h-11 items-center;
    }

    &-button {
      @apply w-full h-11;
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
