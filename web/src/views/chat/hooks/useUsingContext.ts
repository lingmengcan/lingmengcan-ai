import { computed } from 'vue';
import { useMessage } from 'naive-ui';
import { useChatStore } from '@/store/modules/chat';

export function useUsingContext() {
  const message = useMessage();
  const chatStore = useChatStore();
  const usingContext = computed<boolean>(() => chatStore.usingContext);

  function toggleUsingContext() {
    chatStore.setUsingContext(!usingContext.value);
    if (usingContext.value) message.success('当前模式下, 发送消息会携带之前的聊天记录');
    else message.warning('当前模式下, 发送消息不会携带之前的聊天记录');
  }

  return {
    usingContext,
    toggleUsingContext,
  };
}
