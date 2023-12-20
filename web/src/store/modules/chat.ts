import {
  addConversation,
  addMessage,
  changeConversationStatus,
  changeMessageStatus,
  clearConversationList,
  deleteMessagesByConversationId,
  editConversation,
  editMessage,
  getConversationList,
  getMessagesByConversationId,
} from '@/api/chat/chat';
import { Message, Conversation } from '@/models/chat';
import router from '@/router';
import { defineStore } from 'pinia';

export interface ChatState {
  activeId: string | undefined;
  messages: Message[];
  usingContext: boolean;
  conversationList: Conversation[];
}

export const useChatStore = defineStore('chat-store', {
  state: (): ChatState => ({
    activeId: '',
    messages: [],
    usingContext: false,
    conversationList: [],
  }),

  getters: {
    // getChatHistoryByCurrentActive(state: ChatState) {
    //   const index = state.conversationList.findIndex(
    //     (item) => item.conversationId === state.activeId,
    //   );
    //   if (index !== -1) return state.conversationList[index];
    //   return null;
    // },
    // getChatByConversationId(state: ChatState) {
    //   return (conversationId?: string) => {
    //     if (conversationId)
    //       return state.messages.find((item) => item.conversationId === conversationId)?.data ?? [];
    //     return state.messages.find((item) => item.conversationId === state.activeId)?.data ?? [];
    //   };
    // },
  },

  actions: {
    async getConversationList() {
      const res = await getConversationList();

      if (res?.code === 0) {
        this.conversationList = res.data;
      }
    },

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
        this.activeId = conversation.conversationId;
        this.reloadRoute(conversation.conversationId);
      }
    },

    async updateConversation(conversation: Conversation) {
      const res = await editConversation(conversation);

      if (res?.code === 0) {
        this.getConversationList();
      }
    },

    async deleteConversation(conversation: Conversation) {
      conversation.status = 1; // 软删除
      const res = await changeConversationStatus(conversation);

      if (res?.code === 0) {
        return await this.reloadRoute();
      }
    },

    async clearConversationList() {
      const res = await clearConversationList();

      if (res?.code === 0) {
        return await this.reloadRoute();
      }
    },

    setUsingContext(context: boolean) {
      this.usingContext = context;
      this.getConversationList();
    },

    async setActive(conversationId?: string) {
      this.activeId = conversationId;
      return await this.reloadRoute(conversationId);
    },

    async getChatByConversationId(conversationId: string) {
      const res = await getMessagesByConversationId(conversationId);

      if (res?.code === 0) {
        this.messages = res.data;
      }

      return this.messages;
    },

    async addChatByConversationId(message: Message) {
      const res = await addMessage(message);

      if (res?.code === 0) {
        // 更新messages
        await this.getChatByConversationId(message.conversationId);
        return res.data;
      }
    },

    async updateChatByConversationId(message: Message) {
      const res = await editMessage(message);

      if (res?.code === 0) {
        // 更新messages
        this.getChatByConversationId(message.conversationId);
      }
    },

    async deleteChat(message: Message) {
      const res = await changeMessageStatus(message);

      if (res?.code === 0) {
        // 更新messages
        this.getChatByConversationId(message.conversationId);
      }
    },

    async clearChatByConversationId(conversationId: string) {
      const res = await deleteMessagesByConversationId(conversationId);

      if (res?.code === 0) {
        // 更新messages
        this.getChatByConversationId(conversationId);
      }
    },

    async reloadRoute(conversationId?: string | undefined) {
      this.getConversationList();

      await router.push({ name: 'chat', params: { conversationId } });
    },
  },
});
