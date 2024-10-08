<script lang="ts" setup>
  import { ChatboxOutline, TrashOutline, PencilOutline, CloseOutline, CheckmarkOutline } from '@vicons/ionicons5';
  import { computed, onMounted } from 'vue';
  import { useChatStore } from '@/store/modules/chat';
  import { Conversation } from '@/models/chat';

  const chatStore = useChatStore();

  // const conversationList = ref([]);

  const conversationList = computed(() => {
    const list = chatStore.conversationList;
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

  onMounted(async () => {
    chatStore.setConversationList();
  });
</script>

<template>
  <n-scrollbar>
    <div class="mt-4">
      <div class="flex flex-col w-full gap-4">
        <div v-for="(item, index) of conversationList" :key="index">
          <n-input v-if="item.isEdit" v-model:value="item.conversationName" class="items-center w-full h-11">
            <template #suffix>
              <n-icon
                size="14"
                class="mr-1 text-blue-800 cursor-pointer hover:text-gray-500"
                @click="handleEdit(item, false, $event)"
              >
                <CheckmarkOutline />
              </n-icon>

              <n-icon size="14" class="text-blue-800 cursor-pointer hover:text-gray-500" @click="item.isEdit = false">
                <CloseOutline />
              </n-icon>
            </template>
          </n-input>
          <n-button
            v-else
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
              <n-icon
                size="14"
                class="mr-1 text-blue-800 cursor-pointer hover:text-gray-500"
                @click="handleEdit(item, true, $event)"
              >
                <PencilOutline />
              </n-icon>

              <n-popconfirm placement="top" @positive-click="handleDelete(item, $event)">
                <template #trigger>
                  <n-icon size="14" class="text-blue-800 cursor-pointer hover:text-gray-500">
                    <TrashOutline />
                  </n-icon>
                </template>
                {{ $t('common.deleteConfirm') }}
              </n-popconfirm>
            </div>
          </n-button>
        </div>
      </div>
    </div>
  </n-scrollbar>
</template>

<style lang="less" scoped>
  .list-chat-button {
    @apply w-full h-11 bg-sky-200 rounded-md justify-start;

    &-selected {
      @apply bg-sky-300;
    }
  }
</style>
