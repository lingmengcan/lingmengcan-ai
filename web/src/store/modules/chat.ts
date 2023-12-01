import { Chat, ChatHistory, ChatState } from '@/models/chat';
import router from '@/router';
import storage from '@/utils/storage';
import { defineStore } from 'pinia';

export const useChatStore = defineStore('chat-store', {
  state: (): ChatState => getLocalState(),

  getters: {
    getChatHistoryByCurrentActive(state: ChatState) {
      const index = state.history.findIndex((item) => item.uuid === state.active);
      if (index !== -1) return state.history[index];
      return null;
    },

    getChatByUuid(state: ChatState) {
      return (uuid?: number) => {
        if (uuid) return state.chat.find((item) => item.uuid === uuid)?.data ?? [];
        return state.chat.find((item) => item.uuid === state.active)?.data ?? [];
      };
    },
  },

  actions: {
    setUsingContext(context: boolean) {
      this.usingContext = context;
      this.recordState();
    },

    addHistory(history: ChatHistory, chatData: Chat[] = []) {
      this.history.unshift(history);
      this.chat.unshift({ uuid: history.uuid, data: chatData });
      this.active = history.uuid;
      this.reloadRoute(history.uuid);
    },

    updateHistory(uuid: number, edit: Partial<ChatHistory>) {
      const index = this.history.findIndex((item) => item.uuid === uuid);
      if (index !== -1) {
        this.history[index] = { ...this.history[index], ...edit };
        this.recordState();
      }
    },

    async deleteHistory(index: number) {
      this.history.splice(index, 1);
      this.chat.splice(index, 1);

      if (this.history.length === 0) {
        this.active = null;
        this.reloadRoute();
        return;
      }

      if (index > 0 && index <= this.history.length) {
        const uuid = this.history[index - 1].uuid;
        this.active = uuid;
        this.reloadRoute(uuid);
        return;
      }

      if (index === 0) {
        if (this.history.length > 0) {
          const uuid = this.history[0].uuid;
          this.active = uuid;
          this.reloadRoute(uuid);
        }
      }

      if (index > this.history.length) {
        const uuid = this.history[this.history.length - 1].uuid;
        this.active = uuid;
        this.reloadRoute(uuid);
      }
    },

    async setActive(uuid: number) {
      this.active = uuid;
      return await this.reloadRoute(uuid);
    },

    getChatByUuidAndIndex(uuid: number, index: number) {
      if (!uuid || uuid === 0) {
        if (this.chat.length) return this.chat[0].data[index];
        return null;
      }
      const chatIndex = this.chat.findIndex((item) => item.uuid === uuid);
      if (chatIndex !== -1) return this.chat[chatIndex].data[index];
      return null;
    },

    addChatByUuid(uuid: number, chat: Chat) {
      if (!uuid || uuid === 0) {
        if (this.history.length === 0) {
          const uuid = Date.now();
          this.history.push({ uuid, title: chat.text, isEdit: false });
          this.chat.push({ uuid, data: [chat] });
          this.active = uuid;
          this.recordState();
        } else {
          this.chat[0].data.push(chat);
          if (this.history[0].title === 'New Chat') this.history[0].title = chat.text;
          this.recordState();
        }
      }

      const index = this.chat.findIndex((item) => item.uuid === uuid);
      if (index !== -1) {
        this.chat[index].data.push(chat);
        if (this.history[index].title === 'New Chat') this.history[index].title = chat.text;
        this.recordState();
      }
    },

    updateChatByUuid(uuid: number, index: number, chat: Chat) {
      if (!uuid || uuid === 0) {
        if (this.chat.length) {
          this.chat[0].data[index] = chat;
          this.recordState();
        }
        return;
      }

      const chatIndex = this.chat.findIndex((item) => item.uuid === uuid);
      if (chatIndex !== -1) {
        this.chat[chatIndex].data[index] = chat;
        this.recordState();
      }
    },

    updateChatSomeByUuid(uuid: number, index: number, chat: Partial<Chat>) {
      if (!uuid || uuid === 0) {
        if (this.chat.length) {
          this.chat[0].data[index] = { ...this.chat[0].data[index], ...chat };
          this.recordState();
        }
        return;
      }

      const chatIndex = this.chat.findIndex((item) => item.uuid === uuid);
      if (chatIndex !== -1) {
        this.chat[chatIndex].data[index] = { ...this.chat[chatIndex].data[index], ...chat };
        this.recordState();
      }
    },

    deleteChatByUuid(uuid: number, index: number) {
      if (!uuid || uuid === 0) {
        if (this.chat.length) {
          this.chat[0].data.splice(index, 1);
          this.recordState();
        }
        return;
      }

      const chatIndex = this.chat.findIndex((item) => item.uuid === uuid);
      if (chatIndex !== -1) {
        this.chat[chatIndex].data.splice(index, 1);
        this.recordState();
      }
    },

    clearChatByUuid(uuid: number) {
      if (!uuid || uuid === 0) {
        if (this.chat.length) {
          this.chat[0].data = [];
          this.recordState();
        }
        return;
      }

      const index = this.chat.findIndex((item) => item.uuid === uuid);
      if (index !== -1) {
        this.chat[index].data = [];
        this.recordState();
      }
    },

    async reloadRoute(uuid?: number) {
      this.recordState();

      await router.push({ name: 'chat', params: { uuid } });
    },

    recordState() {
      setLocalState(this.$state);
    },
  },
});

function getLocalState(): ChatState {
  const uuid = 10005;
  const defaultState = {
    active: uuid,
    usingContext: true,
    history: [{ uuid, title: '新的对话', isEdit: false }],
    chat: [{ uuid, data: [] }],
  };

  const localState = storage.get('chatStorage');

  return { ...defaultState, ...localState };
}

function setLocalState(state: ChatState) {
  storage.set('chatStorage', state);
}
