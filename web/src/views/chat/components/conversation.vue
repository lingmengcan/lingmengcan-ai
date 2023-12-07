<script lang="ts" setup>
  import { PropType, Ref, computed, onMounted, ref } from 'vue';
  import { useUsingContext } from '../hooks/useUsingContext';
  import { useRoute } from 'vue-router';
  import { useChatStore } from '@/store/modules/chat';
  import { usePromptStore } from '@/store/modules/prompt';
  import { useScroll } from '../hooks/useScroll';
  import { storeToRefs } from 'pinia';
  import { ConversationRequest, Message } from '@/models/chat';
  import { chat, chatfile } from '@/api/chat/chat';
  import {
    ChatbubblesOutline,
    SettingsOutline,
    GridOutline,
    PaperPlaneOutline,
    StopCircleOutline,
  } from '@vicons/ionicons5';
  import { useDialog } from 'naive-ui';
  import MessageComponent from './message.vue';

  defineProps({
    chatListVisable: {
      type: [Boolean] as PropType<boolean>,
      default: true,
    },
  });

  const emit = defineEmits(['update:chatListVisable']);

  const inputRef = ref<Ref | null>(null);
  const dialog = useDialog();
  const route = useRoute();
  const chatStore = useChatStore();

  // 添加PromptStore
  const promptStore = usePromptStore();

  const { dialogId } = route.params as { dialogId: string };

  const dataSources = computed(() => (dialogId ? chatStore.getChatByDialogId(dialogId) : []));

  const conversationList = computed(() =>
    dataSources.value.filter((item) => !item.inversion && !!item.conversationOptions),
  );
  const prompt = ref<string>('');
  const loading = ref<boolean>(false);

  const { usingContext } = useUsingContext();

  const { scrollRef, scrollToBottom, scrollToBottomIfAtBottom } = useScroll();

  // 历史记录相关
  const history: any = ref([]);
  // 使用storeToRefs，保证store修改后，联想部分能够重新渲染
  const { promptList: promptTemplate } = storeToRefs<any>(promptStore);
  // 是否开启知识库问答
  const active = ref<boolean>(false);

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

  // 可优化部分
  // 搜索选项计算，这里使用value作为索引项，所以当出现重复value时渲染异常(多项同时出现选中效果)
  // 理想状态下其实应该是key作为索引项,但官方的renderOption会出现问题，所以就需要value反renderLabel实现
  const searchOptions = computed(() => {
    if (prompt.value.startsWith('/')) {
      return promptTemplate.value
        .filter((item: { key: string }) =>
          item.key.toLowerCase().includes(prompt.value.substring(1).toLowerCase()),
        )
        .map((obj: { value: any }) => {
          return {
            label: obj.value,
            value: obj.value,
          };
        });
    } else {
      return [];
    }
  });

  // value反渲染key
  const renderOption = (option: { label: string }) => {
    for (const i of promptTemplate.value) {
      if (i.value === option.label) return [i.key];
    }
    return [];
  };

  function handleStop() {
    if (loading.value) {
      loading.value = false;
    }
  }

  function handleDelete(message: Message) {
    if (loading.value) return;

    dialog.warning({
      title: '提示',
      content: '是否删除此消息?',
      positiveText: '确定',
      negativeText: '取消',
      onPositiveClick: () => {
        chatStore.deleteChat(message);
      },
    });
  }

  function handleEnter(event: KeyboardEvent) {
    if (event.key === 'Enter' && !event.shiftKey) {
      event.preventDefault();
      handleSubmit();
    }
  }

  function handleSubmit() {
    switch (selectedLlm.value) {
      case 'ChatGLM3':
        onConversation();
        break;
      case 'GPT-3.5':
        break;
    }
  }

  async function onConversation() {
    const message = prompt.value;
    if (usingContext.value) {
      for (let i = 0; i < dataSources.value.length; i = i + 2)
        history.value.push([
          `Human:${dataSources.value[i].messageText}`,
          `Assistant:${dataSources.value[i + 1].messageText.split('\n\n数据来源：\n\n')[0]}`,
        ]);
    } else {
      history.value.length = 0;
    }
    if (!message || message.trim() === '') return;

    chatStore.addChatByDialogId({
      dialogId: dialogId,
      messageText: message,
      sender: 'human',
      status: 0,
    });
    scrollToBottom();

    loading.value = true;
    prompt.value = '';

    let options: ConversationRequest = {};
    const lastContext =
      conversationList.value[conversationList.value.length - 1]?.conversationOptions;

    if (lastContext && usingContext.value) options = { ...lastContext };

    chatStore.addChatByDialogId({
      dialogId: dialogId,
      messageText: '',
      sender: 'ai',
      status: 0,
    });
    scrollToBottom();

    try {
      const lastText = '';
      const fetchChatAPIOnce = async () => {
        const res = active.value
          ? await chatfile({ message, history: history.value })
          : await chat({ message, history: history.value });
        const result = active.value
          ? `${res.data.response.text}\n\n数据来源：\n\n[${
              res.data.url.split('/static/')[1]
            }](http://127.0.0.1:9999${res.data.url})`
          : res.data.text;
        chatStore.updateChatByUuid(+uuid, dataSources.value.length - 1, {
          dateTime: new Date().toLocaleString(),
          text: lastText + (result ?? ''),
          inversion: false,
          error: false,
          loading: false,
          conversationOptions: null,
          requestOptions: { prompt: message, options: { ...options } },
        });
        scrollToBottomIfAtBottom();
        loading.value = false;

        chatStore.updateChatSomeByUuid(+uuid, dataSources.value.length - 1, { loading: false });
      };

      await fetchChatAPIOnce();
    } catch (error: any) {
      const errorMessage = error?.message ?? '好像出错了，请稍后再试。';

      if (error.message === 'canceled') {
        chatStore.updateChatSomeByUuid(+uuid, dataSources.value.length - 1, {
          loading: false,
        });
        scrollToBottomIfAtBottom();
        return;
      }

      const currentChat = chatStore.getChatByUuidAndIndex(+uuid, dataSources.value.length - 1);

      if (currentChat?.text && currentChat.text !== '') {
        chatStore.updateChatSomeByUuid(+uuid, dataSources.value.length - 1, {
          text: `${currentChat.text}\n[${errorMessage}]`,
          error: false,
          loading: false,
        });
        return;
      }

      chatStore.updateChatByUuid(+uuid, dataSources.value.length - 1, {
        dateTime: new Date().toLocaleString(),
        text: errorMessage,
        inversion: false,
        error: true,
        loading: false,
        conversationOptions: null,
        requestOptions: { prompt: message, options: { ...options } },
      });
      scrollToBottomIfAtBottom();
    } finally {
      loading.value = false;
    }
  }

  onMounted(() => {
    scrollToBottom();
    if (inputRef.value) inputRef.value?.focus();
  });

  // onUnmounted(() => {
  //   if (loading.value) controller.abort();
  // });
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
        <template v-if="!dataSources.length">
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
            v-for="(item, index) of dataSources"
            :key="index"
            :date-time="item.createdAt"
            :text="item.messageText"
            :inversion="item.inversion"
            :error="item.error"
            :loading="item.loading"
            @delete="handleDelete(item)"
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
          <n-auto-complete
            v-model:value="prompt"
            :options="searchOptions"
            :render-label="renderOption"
          >
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
                  <n-button :bordered="false" style="width: 20px" @click="handleSubmit">
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
    @apply bg-gray-200;
    @apply w-10;
    @apply h-10;
    @apply hover:opacity-70;
    border-radius: 0;

    &-border-l {
      border-left: #d8e1f0 1px solid;
    }
  }
</style>
