import {
  addDialog,
  addMessage,
  changeDialogStatus,
  changeMessageStatus,
  deleteMessagesByDialogId,
  editDialog,
  editMessage,
  getMessagesByDialogId,
} from '@/api/chat/chat';
import { Message, Dialog } from '@/models/chat';
import router from '@/router';
import { defineStore } from 'pinia';

export interface ChatState {
  activeId: string | undefined;
  usingContext: boolean;
  dialogList: Dialog[];
  messages: { dialogId: string | undefined; data: Message[] }[];
}

export const useChatStore = defineStore('chat-store', {
  state: (): ChatState => ({
    activeId: '',
    usingContext: false,
    dialogList: [],
    messages: [{ dialogId: '', data: [] }],
  }),

  getters: {
    getChatHistoryByCurrentActive(state: ChatState) {
      const index = state.dialogList.findIndex((item) => item.dialogId === state.activeId);
      if (index !== -1) return state.dialogList[index];
      return null;
    },

    getChatByDialogId(state: ChatState) {
      return (dialogId?: string) => {
        if (dialogId) return state.messages.find((item) => item.dialogId === dialogId)?.data ?? [];
        return state.messages.find((item) => item.dialogId === state.activeId)?.data ?? [];
      };
    },
  },

  actions: {
    async addDialog() {
      const defaultDialog = {
        dialogName: '新建对话',
        userName: '',
        status: 0,
      };
      const res = await addDialog(defaultDialog);

      if (res?.code === 0) {
        const dialog = res.data;
        this.dialogList.unshift(dialog);
        this.messages.unshift({ dialogId: dialog.dialogId, data: [] });
        this.activeId = dialog.dialogId;
        this.reloadRoute(dialog.dialogId);
      }
    },

    async updateDialog(dialog: Dialog) {
      const res = await editDialog(dialog);

      if (res?.code === 0) {
        this.recordState();
      }
    },

    async deleteDialog(dialog: Dialog) {
      const res = await changeDialogStatus(dialog);

      if (res?.code === 0) {
        this.recordState();
      }
    },

    setUsingContext(context: boolean) {
      this.usingContext = context;
      this.recordState();
    },

    async setActive(dialogId?: string) {
      this.activeId = dialogId;
      return await this.reloadRoute(dialogId);
    },

    async getChatByDialogId(dialogId: string) {
      const res = await getMessagesByDialogId(dialogId);

      if (res?.code === 0) {
        return res.data;
      }
      return null;
    },

    async addChatByDialogId(message: Message) {
      const res = await addMessage(message);

      if (res?.code === 0) {
        this.recordState();
      }
    },

    async updateChatByDialogId(message: Message) {
      const res = await editMessage(message);

      if (res?.code === 0) {
        this.recordState();
      }
    },

    // async updateChatSomeyDialogId(messages: Partial<Message>) {},

    async deleteChat(message: Message) {
      const res = await changeMessageStatus(message);

      if (res?.code === 0) {
        this.recordState();
      }
    },

    async clearChatByDialogId(dialogId: string) {
      const res = await deleteMessagesByDialogId(dialogId);

      if (res?.code === 0) {
        this.recordState();
      }
    },

    async reloadRoute(dialogId?: string | undefined) {
      this.recordState();

      await router.push({ name: 'chat', params: { dialogId } });
    },

    recordState() {},
  },
});
