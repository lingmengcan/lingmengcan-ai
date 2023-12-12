import {
  addConversation,
  addMessage,
  changeConversationStatus,
  changeMessageStatus,
  deleteMessagesByConversationId,
  editConversation,
  editMessage,
  getMessagesByConversationId,
} from '@/api/chat/chat';
import { Message, Conversation } from '@/models/chat';
import router from '@/router';
import { defineStore } from 'pinia';

export interface ChatState {
  activeId: string | undefined;
  usingContext: boolean;
  conversationList: Conversation[];
  messages: { conversationId: string | undefined; data: Message[] }[];
}

export const useChatStore = defineStore('chat-store', {
  state: (): ChatState => ({
    activeId: '',
    usingContext: false,
    conversationList: [],
    messages: [{ conversationId: '', data: [] }],
  }),

  getters: {
    getChatHistoryByCurrentActive(state: ChatState) {
      const index = state.conversationList.findIndex(
        (item) => item.conversationId === state.activeId,
      );
      if (index !== -1) return state.conversationList[index];
      return null;
    },

    getChatByConversationId(state: ChatState) {
      return (conversationId?: string) => {
        if (conversationId)
          return state.messages.find((item) => item.conversationId === conversationId)?.data ?? [];
        return state.messages.find((item) => item.conversationId === state.activeId)?.data ?? [];
      };
    },
  },

  actions: {
    async addConversation() {
      const defaultConversation = {
        conversationName: '新建对话',
        userName: '',
        status: 0,
      };
      const res = await addConversation(defaultConversation);

      if (res?.code === 0) {
        const conversation = res.data;
        this.conversationList.unshift(conversation);
        this.messages.unshift({ conversationId: conversation.conversationId, data: [] });
        this.activeId = conversation.conversationId;
        this.reloadRoute(conversation.conversationId);
      }
    },

    async updateConversation(conversation: Conversation) {
      const res = await editConversation(conversation);

      if (res?.code === 0) {
        this.recordState();
      }
    },

    async deleteConversation(conversation: Conversation) {
      const res = await changeConversationStatus(conversation);

      if (res?.code === 0) {
        this.recordState();
      }
    },

    setUsingContext(context: boolean) {
      this.usingContext = context;
      this.recordState();
    },

    async setActive(conversationId?: string) {
      this.activeId = conversationId;
      return await this.reloadRoute(conversationId);
    },

    async getChatByConversationId(conversationId: string) {
      const res = await getMessagesByConversationId(conversationId);

      if (res?.code === 0) {
        return res.data;
      }
      return null;
    },

    async addChatByConversationId(message: Message) {
      const res = await addMessage(message);

      if (res?.code === 0) {
        this.recordState();
      }
    },

    async updateChatByConversationId(message: Message) {
      const res = await editMessage(message);

      if (res?.code === 0) {
        this.recordState();
      }
    },

    // async updateChatSomeyConversationId(messages: Partial<Message>) {},

    async deleteChat(message: Message) {
      const res = await changeMessageStatus(message);

      if (res?.code === 0) {
        this.recordState();
      }
    },

    async clearChatByConversationId(conversationId: string) {
      const res = await deleteMessagesByConversationId(conversationId);

      if (res?.code === 0) {
        this.recordState();
      }
    },

    async reloadRoute(conversationId?: string | undefined) {
      this.recordState();

      await router.push({ name: 'chat', params: { conversationId } });
    },

    recordState() {},
  },
});
