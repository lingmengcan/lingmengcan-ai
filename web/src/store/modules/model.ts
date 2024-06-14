import { defineStore } from 'pinia';
import { store } from '@/store';
import { Model } from '@/models/model';
import { ResultEnum } from '@/constants';
import { getModelListByType } from '@/api/llm/model';

export const useModelStore = defineStore({
  id: 'app-model',
  state: (): Model => ({
    modelId: '',
    modelName: '',
    modelType: '',
    sort: 0,
    status: 0,
  }),

  actions: {
    // 按字典类型获取所有子字典列表
    async getModelListByType(modelType: string) {
      const res = await getModelListByType(modelType);

      if (res && res.code === ResultEnum.SUCCESS) {
        return res.data;
      }
      return [];
    },
  },
});

// Need to be used outside the setup
export function useModel() {
  return useModelStore(store);
}
