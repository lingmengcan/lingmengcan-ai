import { defineStore } from 'pinia';
import { store } from '@/store';
import { Llm } from '@/models/llm';
import { ResultEnum } from '@/constants';
import { getLlmListByType } from '@/api/llm/model';

export const useLlmStore = defineStore({
  id: 'app-model',
  state: (): Llm => ({
    modelId: '',
    modelName: '',
    modelType: '',
    status: '0',
  }),

  actions: {
    // 按字典类型获取所有子字典列表
    async getLlmListByType(modelType: string) {
      const res = await getLlmListByType(modelType);

      if (res && res.code === ResultEnum.SUCCESS) {
        return res.data;
      }
      return [];
    },
  },
});

// Need to be used outside the setup
export function useLlm() {
  return useLlmStore(store);
}
