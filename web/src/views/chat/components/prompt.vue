<script lang="ts" setup>
  import { ref } from 'vue';
  import { ChevronBackOutline } from '@vicons/ionicons5';
  import { FormInst, useMessage } from 'naive-ui';
  import { Prompt } from '@/models/chat';
  import { addPrompt, editPrompt } from '@/api/chat/prompt';

  const message = useMessage();
  const promptFormRef = ref<FormInst | null>(null);
  const isAdd = ref(false);

  // 新增/修改数据初始化
  const promptInitData = {
    promptId: '',
    title: '',
    content: '',
    userName: '',
    status: 0,
  };

  const promptFormData = ref(promptInitData);
  const promptRules = {
    title: { required: true, message: '标题必填', trigger: 'blur' },
    content: { required: true, message: '内容必填', trigger: 'blur' },
  };

  function handleAdd() {
    isAdd.value = !isAdd.value;
  }

  function handleBack() {
    isAdd.value = false;
  }

  const handleSave = (e: MouseEvent) => {
    e.preventDefault();
    const messageReactive = message.loading('处理中', {
      duration: 0,
    });

    promptFormRef.value?.validate(async (errors) => {
      if (!errors) {
        const requestData: Prompt = {
          ...promptFormData.value,
        };

        const res = promptFormData.value.promptId
          ? await editPrompt(requestData)
          : await addPrompt(requestData);

        if (res?.code === 0) {
          //   showDrawer.value = false;
          promptFormData.value = promptInitData;
        }
      } else {
        console.log(errors);
        message.error('验证不通过');
      }

      messageReactive.destroy();
    });
  };
</script>

<template>
  <div class="flex flex-col h-full gap-2">
    <template v-if="isAdd">
      <div class="w-full px-4 py-2 text-base font-bold border-b">
        <n-button text @click="handleBack">
          <n-icon>
            <ChevronBackOutline />
          </n-icon>
          新建提示词
        </n-button>
      </div>
      <div class="px-4">
        <n-form ref="promptFormRef" label-width="auto" :model="promptFormData" :rules="promptRules">
          <n-form-item path="title" label="标题">
            <n-input v-model:value="promptFormData.title" placeholder="请输入标题" />
          </n-form-item>
          <n-form-item path="content" label="内容">
            <n-input
              v-model:value="promptFormData.content"
              type="textarea"
              placeholder="请输入内容"
            />
          </n-form-item>
          <n-form-item>
            <n-button secondary class="setting-button" @click="handleSave">保存</n-button>
          </n-form-item>
        </n-form>
      </div>
    </template>
    <template v-else>
      <div class="w-full px-4 py-2 text-base font-bold border-b">提示词</div>
      <div class="px-4">
        <n-button class="setting-button" :dashed="true" @click="handleAdd">新建提示词</n-button>
      </div>
      <div class="list">
        <div class="list-content">abc</div>
      </div>
      <div class="list">
        <div class="list-content">abc</div>
      </div>
    </template>
  </div>
</template>

<style lang="less" scoped>
  .list {
    @apply flex items-center cursor-pointer rounded-md bg-gray-200 border border-[#EBECF0] h-10 hover:opacity-70  px-4 gap-3 flex-shrink-0 flex-grow-0;

    &-content {
      @apply flex-1 pr-3 overflow-hidden break-all text-ellipsis whitespace-nowrap;
    }
  }

  .action-button {
    @apply bg-gray-200 w-10 h-10 hover:opacity-70;
    border-radius: 0;

    &-border-l {
      border-left: #d8e1f0 1px solid;
    }
  }

  .setting-button {
    @apply w-full px-4 py-2 border rounded-lg shadow border-neutral-500 text-neutral-900 hover:bg-neutral-100 focus:outline-none;
  }
</style>
