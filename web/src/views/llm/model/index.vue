<template>
  <n-card :bordered="false">
    <n-form ref="formRef" inline label-placement="left" label-width="auto" :model="queryFormData">
      <n-grid :cols="24" :x-gap="24">
        <n-form-item-gi :span="5" path="modelName">
          <n-input v-model:value="modelName" placeholder="请输入模型名称" />
        </n-form-item-gi>
        <n-form-item-gi :span="5" path="modelCategory">
          <n-select
            v-model:value="modelCategory"
            :options="categoryOptions"
            placeholder="请选择模型分类"
          />
        </n-form-item-gi>
        <n-form-item-gi :span="6">
          <n-space>
            <n-button @click="clearQuery">重置</n-button>
            <n-button v-permission="['system_dict_query']" type="primary" @click="handleQuery">
              查询
            </n-button>
          </n-space>
        </n-form-item-gi>
      </n-grid>
    </n-form>
  </n-card>
  <n-grid :x-gap="12" :y-gap="12" cols="4" class="my-3 overflow-auto">
    <n-grid-item v-for="model in models" :key="model.name">
      <n-card
        class="w-full h-full mb-4"
        :title="model.name"
        :segmented="{
          footer: true,
        }"
        hoverable
      >
        <div>{{ model.description }}</div>
        <template #footer>
          <div class="text-center">调试</div>
        </template>
      </n-card>
    </n-grid-item>
  </n-grid>
  <n-pagination
    v-model:page="page"
    class="justify-end"
    :page-count="pageCount"
    show-quick-jumper
    show-size-picker
  >
    <template #prefix="{ itemCount }">共 {{ itemCount }} 条数据</template>
  </n-pagination>
</template>

<script setup lang="ts">
  import { ref } from 'vue';

  interface Model {
    name: string;
    description: string;
  }

  const modelName = ref<string>('');
  const modelCategory = ref<number | null>(null);
  const categoryOptions = ref<{ label: string; value: number }[]>([
    { label: 'Category 1', value: 1 },
    { label: 'Category 2', value: 2 },
  ]);

  const models = ref<Model[]>([
    {
      name: 'Baichuan3-Turbo-128k',
      description: '百川智能: 针对企业高频场景优化，效果大幅提升。上下文长度128K',
    },
    {
      name: 'Baichuan3-Turbo',
      description: '百川智能: 针对企业高频场景优化，效果大幅提升。上下文长度32K',
    },
    {
      name: 'Baichuan4',
      description: '百川智能大模型：SuperCLUE评测，模型能力国内第一。上下文长度：32K',
    },
    {
      name: 'deepseek-chat',
      description: '中国的深度求索（DeepSeek）公司开发的人工智能助手DeepSeek Chat',
    },
    {
      name: 'aspire-acge-large',
      description:
        'aspire-acge-large-zh-online是一个由知己站（AcFun）和GecePie Lab开发的大型中文预训练语言模型，用于中文自然语言处理任务的性能和效果。',
    },
    {
      name: 'moonshot-v1-128k',
      description:
        'MoonshotAI，一个多功能的人工智能助手，旨在提供信息查询、日常对话、翻译、日程管理等服务。',
    },
    {
      name: 'moonshot-v1-32k',
      description:
        '由Moonshot Corp开发的人工智能助手，可以执行多种任务，比如信息查询、生活建议、新闻更新、商业咨询等，旨在提供一般性的帮助和信息。',
    },
    {
      name: 'moonshot-v1-8k',
      description: '由Moonshot Corp开发的人工智能助手，以帮助用户回答问题，提供建议和解决问题。',
    },
    {
      name: 'HY-Fin-70-v2.2.2',
      description: '混元金融大模型，一个由腾讯云和腾讯讯飞IT开发的智能金融助手。',
    },
    {
      name: 'wenxinyiyan4',
      description:
        '文心一言模型，可以完成的任务包括知识问答、文本创作、知识推理、数学计算、代码理解与编写、作文、翻译等。',
    },
    {
      name: 'hunyuan-13B',
      description:
        '腾讯公司开发的大型语言模型混元大模型（Hunyuan），主要功能是通过丰富的语义理解和计算能力，为用户提供高质量的服务。',
    },
    {
      name: 'hunyuan',
      description:
        '基于腾讯目前的最大型语言模型-混元大模型（Hunyuan），可以回答各种类型的问题，也可以处理多种金融任务。',
    },
    {
      name: 'gpt-35-turbo',
      description: '由OpenAI开发的，基于GPT-3的模型。设计来帮助用户回答问题，提供建议和解决问题。',
    },
    {
      name: 'gpt-4',
      description: 'GPT-4（Generative Pretrained Transformer 4）是一种自然语言处理（NLP）AI模型。',
    },
    { name: 'baichuan13b', description: '由百川智能的工程师们开发和维护的。' },
  ]);

  const page = ref<number>(1);
  const pageCount = ref<number>(2);

  const handleQuery = () => {
    console.log('Searching for:', modelName.value, modelCategory.value);
  };

  const clearQuery = () => {
    modelName.value = '';
    modelCategory.value = null;
  };
</script>

<style scoped>
  /* Add any necessary styling here */
</style>
