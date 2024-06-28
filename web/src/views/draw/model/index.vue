<template>
  <n-card :bordered="false">
    <n-form
      ref="formRef"
      inline
      label-placement="left"
      label-width="auto"
      :model="queryFormData"
      :show-feedback="false"
    >
      <n-grid :cols="24" :x-gap="24">
        <n-form-item-gi :span="5" path="modelName">
          <n-input v-model:value="queryFormData.modelName" placeholder="请输入模型名称" />
        </n-form-item-gi>
        <n-form-item-gi :span="5" path="modelType">
          <selectDict v-model:dict-code="queryFormData.modelType" :multiple="true" dict-type="DIFFUSION_MODEL_TYPE" />
        </n-form-item-gi>
        <n-form-item-gi :span="8">
          <n-space>
            <n-button @click="clearQuery">重置</n-button>
            <n-button v-permission="['llm_model_index']" type="primary" @click="handleQuery">查询</n-button>
          </n-space>
        </n-form-item-gi>
        <n-gi :span="6">
          <div class="float-right">
            <n-button v-permission="['llm_model_index']" type="primary" @click="handleAdd">录入模型</n-button>
          </div>
        </n-gi>
      </n-grid>
    </n-form>
  </n-card>
  <n-grid :x-gap="12" :y-gap="12" cols="4" class="my-3 overflow-auto">
    <n-grid-item v-for="item in modelsData" :key="item.modelId">
      <n-card
        footer-style="padding: 10px;"
        class="w-full h-full"
        :title="item.modelName"
        :segmented="{
          footer: true,
        }"
        hoverable
        @click="handleEdit(item)"
      >
        <div>{{ item.description }}</div>
        <template #footer>
          <div class="text-center">调试</div>
        </template>
      </n-card>
    </n-grid-item>
  </n-grid>
  <n-pagination
    v-model:page="page"
    :page-size="pageSize"
    :item-count="itemCount"
    class="justify-end"
    show-quick-jumper
    show-size-picker
    @update:page="handlePageChange"
  >
    <template #prefix="{}">共 {{ itemCount }} 条数据</template>
  </n-pagination>

  <!-- 新增修改模型 -->
  <n-drawer v-model:show="showDrawer" :width="599">
    <n-drawer-content :title="drawerTitle" closable>
      <n-form
        ref="drawerFormRef"
        label-placement="left"
        label-width="auto"
        :model="drawerFormData"
        :rules="drawerRules"
      >
        <n-form-item label="模型名称" path="modelName">
          <n-input v-model:value="drawerFormData.modelName" placeholder="输入模型名称" />
        </n-form-item>
        <n-form-item label="模型类型" path="modelType">
          <selectDict
            v-model:dict-code="drawerFormData.modelType"
            v-model:dict-name="drawerFormData.modelTypeName"
            dict-type="DIFFUSION_MODEL_TYPE"
          />
        </n-form-item>
        <n-form-item label="所属基础模型" name="BaseModelId">
          <selectModel v-model:model-name="drawerFormData.baseModelId" model-type="DIFFUSION_MODEL" />
        </n-form-item>
        <n-form-item label="模型标签" name="tags">
          <selectDict
            v-model:dict-code="drawerFormData.tags"
            :multiple="true"
            :dict-type="['DIFFUSION_TAGS', 'TOPIC', 'STYLE']"
          />
        </n-form-item>
        <n-form-item label="模型描述" name="description">
          <n-input v-model:value="drawerFormData.description" type="textarea" placeholder="请输入模型描述" />
        </n-form-item>
        <n-form-item label="模型封面" name="modelCover">
          <n-upload
            accept=".png,.jpeg,.jpg"
            action="/api/file/upload-image"
            @finish="afterUploaded"
            :with-credentials="true"
            :headers="{ Authorization: `Bearer ${token}` }"
          >
            <n-upload-dragger>
              <div class="pb-1">
                <n-icon size="30" :depth="3">
                  <AddCircleOutline />
                </n-icon>
              </div>
              <n-text>点击或者拖动文件到该区域来上传</n-text>
            </n-upload-dragger>
          </n-upload>
        </n-form-item>
        <n-form-item label="状态" name="status">
          <selectDict v-model:dict-code="drawerFormData.status" dict-type="SYS_STATUS" />
        </n-form-item>
      </n-form>
      <template #footer>
        <n-space>
          <n-button type="primary" attr-type="button" @click="handleAddandEdit">确定</n-button>
        </n-space>
      </template>
    </n-drawer-content>
  </n-drawer>
</template>

<script setup lang="ts">
  import { onMounted, ref } from 'vue';
  import { AddCircleOutline } from '@vicons/ionicons5';
  import selectDict from '@/components/select/select-dict.vue';
  import { addDiffusionModel, editDiffusionModel, getDiffusionModelList } from '@/api/draw/model';
  import { DiffusionModel } from '@/models/diffusion-model';
  import { FormInst, useMessage, UploadFileInfo } from 'naive-ui';
  import selectModel from '@/components/select/select-model.vue';
  import storage from '@/utils/storage';
  import { ACCESS_TOKEN } from '@/constants';

  const message = useMessage();

  const token = storage.get(ACCESS_TOKEN, '');

  const queryFormData = ref({
    modelName: '',
    modelType: '',
  });

  const modelsData = ref<DiffusionModel[]>([]);
  const page = ref<number>(1);
  const pageSize = ref<number>(10);
  const itemCount = ref(0);

  const showDrawer = ref(false);
  const drawerTitle = ref('');

  const formRef = ref<FormInst | null>(null);
  const drawerFormRef = ref<FormInst | null>(null);

  // 新增/修改弹窗数据初始化
  const modelInitData: DiffusionModel = {
    modelId: '',
    baseModelId: '',
    modelName: '',
    modelType: undefined,
    modelTypeName: '',
    modelCover: '',
    status: '0',
    description: '',
    tags: [],
  };
  const drawerFormData = ref(modelInitData);

  const drawerRules = {
    modelName: { required: true, message: '模型名称必填', trigger: 'blur' },
    description: { required: true, message: '模型描述必填', trigger: 'blur' },
    modelType: { required: true, message: '模型类型必填', trigger: 'blur' },
    sort: { type: 'number', required: true, message: '排序必填', trigger: 'blur' },
    status: { required: true, message: '状态必填', trigger: 'blur' },
  };

  // 绑定表格数据
  const query = async (currentPage: number, currentPageSize = 10) => {
    try {
      const requestData = {
        ...queryFormData.value,
        page: currentPage,
        pageSize: currentPageSize,
      };

      const res = await getDiffusionModelList(requestData);
      if (res?.code === 0) {
        modelsData.value = res.data?.list;
        page.value = currentPage;
        pageSize.value = currentPageSize;
        itemCount.value = res.data.count;
      }
    } catch (err) {
      modelsData.value = [];
    }
  };

  const handleQuery = () => {
    query(page.value, pageSize.value);
  };

  const clearQuery = () => {
    queryFormData.value = {
      modelName: '',
      modelType: '',
    };
    query(page.value, pageSize.value);
  };

  const handlePageChange = (currentPage: number) => {
    query(currentPage, pageSize.value);
  };

  // 新增
  const handleAdd = async () => {
    drawerTitle.value = '录入模型';
    showDrawer.value = true;

    drawerFormData.value = { ...modelInitData };
  };

  // 修改字典
  const handleEdit = async (item: DiffusionModel) => {
    drawerTitle.value = '修改模型';
    showDrawer.value = true;

    // 赋值
    // 创建一个新的对象，包含 modelInitData 的属性和 item 的属性
    drawerFormData.value = { ...modelInitData, ...item, status: item.status.toString() };
  };

  function afterUploaded({ file, event }: { file: UploadFileInfo; event?: ProgressEvent }) {
    // 定义允许的文件类型数组
    const res = JSON.parse((event?.target as XMLHttpRequest).response);
    if (res?.code === 0) {
      const filePath = res.data;
      console.log(file.name, filePath);
    }
  }

  const handleAddandEdit = (e: MouseEvent) => {
    e.preventDefault();
    const messageReactive = message.loading('处理中', {
      duration: 0,
    });
    drawerFormRef.value?.validate(async (errors) => {
      if (!errors) {
        const requestData: DiffusionModel = drawerFormData.value;

        const res = drawerFormData.value.modelId
          ? await editDiffusionModel(requestData)
          : await addDiffusionModel(requestData);

        if (res?.code === 0) {
          showDrawer.value = false;
          drawerFormData.value = { ...modelInitData };
          query(page.value, pageSize.value);
        }
      } else {
        console.log(errors);
        message.error('验证不通过');
      }

      messageReactive.destroy();
    });
  };

  onMounted(async () => {
    query(page.value, pageSize.value);
  });
</script>

<style scoped>
  /* Add any necessary styling here */
</style>
