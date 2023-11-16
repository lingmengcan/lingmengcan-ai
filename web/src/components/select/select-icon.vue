<template>
  <n-popover trigger="click" placement="bottom-start" width="400">
    <template #trigger>
      <n-button>
        <template v-if="selectItem.name" #icon>
          <n-icon>
            <component :is="selectItem.name" />
          </n-icon>
        </template>
        {{ selectItem.name }}
      </n-button>
    </template>
    <n-scrollbar class="grid-wrapper">
      <n-grid :cols="4" style="height: 300px">
        <n-grid-item v-for="item of icons" :key="item">
          <div
            class="flex flex-col items-center justify-center p-2 icon-wrapper"
            @click="onIconClick(item)"
          >
            <n-icon>
              <component :is="selectItem.name" />
            </n-icon>
            <n-ellipsis :line-clamp="1" style="font-size: 12px">{{ item }}</n-ellipsis>
          </div>
        </n-grid-item>
      </n-grid>
    </n-scrollbar>
    <div class="flex justify-end mt-2 mb-2">
      <n-pagination
        :page="currentPage"
        :page-size="pageSize"
        :page-slot="5"
        :item-count="itemCount"
        @update-page="onUpdatePage"
      />
    </div>
  </n-popover>
</template>

<script setup lang="ts">
  import { computed, ref, shallowReactive } from 'vue';
  import * as AntdIcons from '@vicons/antd';

  // const antdIcons = import('@vicons/antd');
  const iconNames = Object.keys(AntdIcons);

  const props = defineProps({
    defaultIcon: {
      type: String,
      required: true,
    },
  });
  const emit = defineEmits(['selected']);

  const defaultIcon = ref(props.defaultIcon);
  const pageSize = 40;
  const icons = shallowReactive(iconNames.slice(0, 40));
  const currentPage = ref(1);
  const itemCount = computed(() => iconNames.length);
  const selectItem = ref({ name: defaultIcon.value || '选择图标' });

  function onUpdatePage(page: number) {
    currentPage.value = page;
    icons.length = 0;
    const start = (currentPage.value - 1) * pageSize;
    icons.push(...iconNames.slice(start, start + pageSize));
  }

  function onIconClick(item: any) {
    selectItem.value.name = item;

    emit('selected', item);
  }
</script>

<style lang="less" scoped>
  .grid-wrapper {
    .icon-wrapper {
      cursor: pointer;
      border: 1px solid #f5f5f5;
    }
  }
</style>
