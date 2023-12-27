import { changePromptStatus, getPromptList } from '@/api/chat/prompt';
import { Prompt } from '@/models/chat';
import { defineStore } from 'pinia';

export interface PromptState {
  promptList: Prompt[];
}

export const usePromptStore = defineStore('prompt-store', {
  state: (): PromptState => ({
    promptList: [],
  }),

  actions: {
    async getPromptList() {
      const res = await getPromptList();
      if (res?.code === 0) {
        this.promptList = res.data;

        return this.promptList;
      }
    },

    async deletePrompt(conversation: Prompt) {
      conversation.status = 1; // 软删除
      const res = await changePromptStatus(conversation);

      if (res?.code === 0) {
        await this.getPromptList();
      }
    },
  },
});
