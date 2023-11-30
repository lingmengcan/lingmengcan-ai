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
  import { computed, ref } from 'vue';
  import List from './components/list.vue';
  import { useChatStore } from '@/store/modules/chat';
  import { useRoute } from 'vue-router';
  import { useUsingContext } from './hooks/useUsingContext';
  import { useChat } from './hooks/useChat';
  import { useScroll } from './hooks/useScroll';
  import { ConversationRequest } from '@/models/chat';
  import { chat, chatfile } from '@/api/chat/chat';
  import { storeToRefs } from 'pinia';
  import { usePromptStore } from '@/store/modules/prompt';

  const route = useRoute();
  const chatStore = useChatStore();
  // 添加PromptStore
  const promptStore = usePromptStore();

  const chatListVisable = ref(true);

  const { uuid } = route.params as { uuid: string };
  const dataSources = computed(() => chatStore.getChatByUuid(+uuid));
  const conversationList = computed(() =>
    dataSources.value.filter((item) => !item.inversion && !!item.conversationOptions),
  );
  const prompt = ref<string>('');
  const loading = ref<boolean>(false);

  const { usingContext } = useUsingContext();
  const { addChat, updateChat, updateChatSome, getChatByUuidAndIndex } = useChat();
  const { scrollToBottom, scrollToBottomIfAtBottom } = useScroll();

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

  function handleAdd() {
    chatStore.addHistory({ title: '新的对话', uuid: Date.now(), isEdit: false });
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
          `Human:${dataSources.value[i].text}`,
          `Assistant:${dataSources.value[i + 1].text.split('\n\n数据来源：\n\n')[0]}`,
        ]);
    } else {
      history.value.length = 0;
    }
    if (!message || message.trim() === '') return;

    addChat(+uuid, {
      dateTime: new Date().toLocaleString(),
      text: message,
      inversion: true,
      error: false,
      conversationOptions: null,
      requestOptions: { prompt: message, options: null },
    });
    scrollToBottom();

    loading.value = true;
    prompt.value = '';

    let options: ConversationRequest = {};
    const lastContext =
      conversationList.value[conversationList.value.length - 1]?.conversationOptions;

    if (lastContext && usingContext.value) options = { ...lastContext };

    addChat(+uuid, {
      dateTime: new Date().toLocaleString(),
      text: '',
      loading: true,
      inversion: false,
      error: false,
      conversationOptions: null,
      requestOptions: { prompt: message, options: { ...options } },
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
        updateChat(+uuid, dataSources.value.length - 1, {
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

        updateChatSome(+uuid, dataSources.value.length - 1, { loading: false });
      };

      await fetchChatAPIOnce();
    } catch (error: any) {
      const errorMessage = error?.message ?? '好像出错了，请稍后再试。';

      if (error.message === 'canceled') {
        updateChatSome(+uuid, dataSources.value.length - 1, {
          loading: false,
        });
        scrollToBottomIfAtBottom();
        return;
      }

      const currentChat = getChatByUuidAndIndex(+uuid, dataSources.value.length - 1);

      if (currentChat?.text && currentChat.text !== '') {
        updateChatSome(+uuid, dataSources.value.length - 1, {
          text: `${currentChat.text}\n[${errorMessage}]`,
          error: false,
          loading: false,
        });
        return;
      }

      updateChat(+uuid, dataSources.value.length - 1, {
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
          <n-button dashed class="new-chat-button" @click="handleAdd">
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
              <n-auto-complete
                v-model:value="prompt"
                :options="searchOptions"
                :render-label="renderOption"
              >
                <template #default="{ handleInput, handleBlur, handleFocus }">
                  <n-input
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
