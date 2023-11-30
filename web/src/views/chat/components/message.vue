<script setup lang="ts">
  import { computed, ref } from 'vue';
  import { useMessage } from 'naive-ui';
  import { copyToClip } from '@/utils';
  import Text from './text.vue';

  interface Props {
    dateTime?: string;
    text?: string;
    inversion?: boolean;
    error?: boolean;
    loading?: boolean;
  }

  interface Emit {
    (ev: 'regenerate'): void;
    (ev: 'delete'): void;
  }

  const props = defineProps<Props>();

  const emit = defineEmits<Emit>();

  const message = useMessage();
  const textRef = ref<HTMLElement>();

  const asRawText = ref(props.inversion);

  const messageRef = ref<HTMLElement>();

  const options = computed(() => {
    const common = [
      {
        label: 'copy',
        key: 'copyText',
      },
      {
        label: 'delete',
        key: 'delete',
      },
    ];

    if (!props.inversion) {
      common.unshift({
        label: asRawText.value ? 'chat.preview' : 'chat.showRawText',
        key: 'toggleRenderType',
      });
    }

    return common;
  });

  function handleSelect(key: 'copyText' | 'delete' | 'toggleRenderType') {
    switch (key) {
      case 'copyText':
        handleCopy();
        return;
      case 'toggleRenderType':
        asRawText.value = !asRawText.value;
        return;
      case 'delete':
        emit('delete');
    }
  }

  function handleRegenerate() {
    messageRef.value?.scrollIntoView();
    emit('regenerate');
  }

  async function handleCopy() {
    try {
      await copyToClip(props.text || '');
      message.success('复制成功');
    } catch {
      message.error('复制失败');
    }
  }
</script>

<template>
  <div
    ref="messageRef"
    class="flex w-full mb-6 overflow-hidden"
    :class="[{ 'flex-row-reverse': inversion }]"
  >
    <div
      class="flex items-center justify-center flex-shrink-0 h-8 overflow-hidden rounded-full basis-8"
      :class="[inversion ? 'ml-2' : 'mr-2']"
    >
      <!-- <AvatarComponent :image="inversion" /> -->
    </div>
    <div class="overflow-hidden text-sm" :class="[inversion ? 'items-end' : 'items-start']">
      <p class="text-xs text-[#b4bbc4]" :class="[inversion ? 'text-right' : 'text-left']">
        {{ dateTime }}
      </p>
      <div class="flex items-end gap-1 mt-2" :class="[inversion ? 'flex-row-reverse' : 'flex-row']">
        <Text
          ref="textRef"
          :inversion="inversion"
          :error="error"
          :text="text"
          :loading="loading"
          :as-raw-text="asRawText"
        />
        <div class="flex flex-col">
          <button
            v-if="!inversion"
            class="mb-2 transition text-neutral-300 hover:text-neutral-800 dark:hover:text-neutral-300"
            @click="handleRegenerate"
          >
            abc
          </button>
          <NDropdown
            trigger="hover"
            :placement="!inversion ? 'right' : 'left'"
            :options="options"
            @select="handleSelect"
          >
            <button
              class="transition text-neutral-300 hover:text-neutral-800 dark:hover:text-neutral-200"
            >
              efg
            </button>
          </NDropdown>
        </div>
      </div>
    </div>
  </div>
</template>
