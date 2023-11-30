import storage from '@/utils/storage';
import { defineStore } from 'pinia';

export const usePromptStore = defineStore('prompt-store', {
  state: (): PromptStore => getLocalPromptList(),

  actions: {
    updatePromptList(promptList: []) {
      this.$patch({ promptList });
      setLocalPromptList({ promptList });
    },
    getPromptList() {
      return this.$state;
    },
  },
});

export type PromptList = [];

export interface PromptStore {
  promptList: PromptList;
}

export function getLocalPromptList(): PromptStore {
  const promptStore: PromptStore | undefined = storage.get('promptStore');
  return promptStore ?? { promptList: [] };
}

export function setLocalPromptList(promptStore: PromptStore): void {
  storage.set('promptStore', promptStore);
}
