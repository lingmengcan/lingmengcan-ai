<script lang="ts" setup>
  import { PropType, Ref, watchEffect, computed, onMounted, ref } from 'vue';
  import { useRoute } from 'vue-router';
  import { useChatStore } from '@/store/modules/chat';
  import { useScroll } from '../hooks/useScroll';
  import { Message } from '@/models/chat';
  import { chat } from '@/api/chat/chat';
  import {
    ChatbubblesOutline,
    SettingsOutline,
    GridOutline,
    PaperPlaneOutline,
    StopCircleOutline,
  } from '@vicons/ionicons5';
  import MessageComponent from './message.vue';

  defineProps({
    chatListVisable: {
      type: [Boolean] as PropType<boolean>,
      default: true,
    },
  });

  const emit = defineEmits(['update:chatListVisable']);

  const inputRef = ref<Ref | null>(null);
  const route = useRoute();
  const chatStore = useChatStore();

  const conversationId = ref<string>((route.params as { conversationId: string }).conversationId);

  const messages = computed(() => chatStore.messages);

  const prompt = ref<string>('');
  const loading = ref<boolean>(false);

  const usingContext = ref(true);

  const { scrollRef, scrollToBottom, scrollToBottomIfAtBottom } = useScroll();

  // 历史记录相关
  const history: any = ref([]);

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

  function handleStop() {
    if (loading.value) {
      loading.value = false;
    }
  }

  function handleEnter(event: KeyboardEvent) {
    if (event.key === 'Enter' && !event.shiftKey) {
      event.preventDefault();
      handleSubmit();
    }
  }

  function handleSubmit() {
    if (loading.value) return;

    if (conversationId.value) {
      switch (selectedLlm.value) {
        case 'ChatGLM3':
          onConversation();
          break;
        case 'GPT-3.5':
          break;
      }
    } else {
      chatStore.addConversation().then(() => {
        conversationId.value = chatStore.activeId!;
        onConversation();
      });
    }
  }

  async function onConversation() {
    const message = prompt.value;

    if (usingContext.value) {
      for (let i = 0; i < messages.value.length; i = i + 2) {
        const humanMessage = messages.value[i];
        const aiMessage = messages.value[i + 1];
        history.value.push([
          `human:${humanMessage.sender === 'human' && humanMessage.messageText}`,
          `ai:${aiMessage.previousId === humanMessage.messageId && aiMessage.messageText}`,
        ]);
      }
    } else {
      history.value.length = 0;
    }

    if (!message || message.trim() === '') return;

    // 问题入库
    const newChat: Message = {
      conversationId: conversationId.value,
      messageText: message,
      sender: 'human',
      status: 0,
      completed: 1,
    };

    const question = await chatStore.addChatByConversationId(newChat);

    // 创建回答
    const answer = await chatStore.addChatByConversationId({
      conversationId: conversationId.value,
      previousId: question?.messageId,
      messageText: '',
      sender: 'ai',
      status: 0,
      completed: 0,
    });

    scrollToBottom();

    // 等待回答
    loading.value = true;
    prompt.value = '';

    try {
      const fetchChatAPIOnce = async () => {
        const res = await chat({ message, history: history.value });

        if (answer) {
          answer.messageText = res.data.text ?? '';
          answer.completed = 1;
          // 创建回答
          await chatStore.updateChatByConversationId(answer);

          scrollToBottom();
        }

        scrollToBottom();
        loading.value = false;
      };

      await fetchChatAPIOnce();
    } catch (error: any) {
      scrollToBottomIfAtBottom();
    } finally {
      loading.value = false;
    }
  }

  watchEffect(async () => {
    if (conversationId.value) {
      await chatStore.getChatByConversationId(conversationId.value);
    }
  });

  onMounted(async () => {
    await chatStore.setActive(conversationId.value);

    if (conversationId.value) {
      await chatStore.getChatByConversationId(conversationId.value);
    }

    scrollToBottom();

    if (inputRef.value) inputRef.value?.focus();
  });
</script>

<template>
  <div class="relative flex h-full overflow-hidden bg-white">
    <div
      class="absolute z-10 flex justify-between w-full lg:py-4 lg:px-6 bg-gradient-to-t from-transparent via-white/50 to-white"
    >
      <div class="flex gap-3">
        <n-button
          v-if="!chatListVisable"
          :bordered="false"
          class="action-button"
          @click="emit('update:chatListVisable', !chatListVisable)"
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
    <div class="flex flex-col justify-center flex-auto overflow-hidden">
      <div id="scrollRef" ref="scrollRef" class="max-h-full overflow-x-hidden">
        <template v-if="!messages.length">
          <div class="mx-auto space-y-4 max-w-[600px]">
            <div class="text-4xl font-semibold text-center text-gray-800">
              你好，我是一个智能对话系统
            </div>
            <div class="text-base text-center text-gray-500">
              作为你的智能伙伴，可以回答问题、查找资料、提供建议和执行简单操作，帮助你更高效地获取所需信息并提供支持。
            </div>
          </div>
        </template>
        <template v-else>
          <MessageComponent
            v-for="(item, index) of messages"
            :key="index"
            :date-time="item.createdAt"
            :text="item.messageText"
            :is-ai="item.sender === 'ai'"
            :loading="item.completed === 0"
          />
          <div class="sticky bottom-0 left-0 flex justify-center">
            <n-button v-if="loading" type="warning" @click="handleStop">
              <template #icon>
                <StopCircleOutline />
              </template>
              停止生成
            </n-button>
          </div>
        </template>
      </div>
      <div
        class="w-full pb-2 border-transparent bg-gradient-to-b from-transparent via-white/50 to-white"
      >
        <div
          class="stretch flex flex-row gap-3 last:mb-3 mx-2 mt-6 md:mx-4 md:last:mb-6 lg:mx-auto lg:max-w-3xl"
        >
          <n-auto-complete v-model:value="prompt">
            <template #default="{ handleInput, handleBlur, handleFocus }">
              <n-input
                ref="inputRef"
                v-model:value="prompt"
                type="textarea"
                rows="1"
                autosize
                round
                class="max-h-72 py-2 h-[52px] resize-none"
                placeholder="输入一条消息或键入“/”以选择提示..."
                @input="handleInput"
                @focus="handleFocus"
                @blur="handleBlur"
                @keypress="handleEnter"
              >
                <template #suffix>
                  <n-button
                    :bordered="false"
                    :loading="loading"
                    style="width: 20px"
                    @click="handleSubmit"
                  >
                    <template #icon>
                      <n-icon size="16">
                        <PaperPlaneOutline />
                      </n-icon>
                    </template>
                  </n-button>
                </template>
              </n-input>
            </template>
          </n-auto-complete>
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
    @apply bg-gray-200 w-10 h-10 hover:opacity-70;
    border-radius: 0;

    &-border-l {
      border-left: #d8e1f0 1px solid;
    }
  }
</style>
