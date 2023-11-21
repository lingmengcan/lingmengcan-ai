<template>
  <n-popover ref="popoverRef" trigger="click" placement="bottom-start" width="500">
    <template #trigger>
      <n-button>
        <template v-if="selectItem" #icon>
          <component :is="vicons[selectItem]" />
        </template>
        {{ selectItem }}
      </n-button>
    </template>
    <n-grid :cols="4" x-gap="1">
      <n-grid-item v-for="item of icons" :key="item" style="height: 60px">
        <div
          class="flex flex-col items-center justify-center p-2 icon-wrapper"
          @click="onIconClick(item)"
        >
          <n-icon size="30" color="#0e7a0d">
            <component :is="vicons[item]" />
          </n-icon>
          <n-ellipsis :line-clamp="1" style="font-size: 12px">{{ item }}</n-ellipsis>
        </div>
      </n-grid-item>
    </n-grid>
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
  import * as vicons from '@vicons/ionicons5';
  import { PopoverInst } from 'naive-ui';

  // const antdIcons = import('@vicons/antd');
  const iconNames = Object.keys(vicons);

  const props = defineProps({
    value: {
      type: String,
      required: true,
    },
  });
  const emit = defineEmits(['updated:value', 'selected']);

  const popoverRef = ref<PopoverInst | null>(null);
  const pageSize = 20;
  const icons = shallowReactive(iconNames.slice(0, 20));
  const currentPage = ref(1);
  const itemCount = computed(() => iconNames.length);
  const selectItem = ref(props.value || '选择图标');

  //监控父组件变化
  // watchEffect(() => {
  //   selectItem.value = props.value || '选择图标';
  // });

  function onUpdatePage(page: number) {
    currentPage.value = page;
    icons.length = 0;
    const start = (currentPage.value - 1) * pageSize;
    icons.push(...iconNames.slice(start, start + pageSize));
  }

  function onIconClick(item: string) {
    selectItem.value = item;

    emit('updated:value', item);
    emit('selected', item);
    popoverRef.value?.setShow(false);
  }
</script>

<style lang="less" scoped>
  .icon-wrapper {
    cursor: pointer;
    border: 1px solid #f5f5f5;
  }
</style>
