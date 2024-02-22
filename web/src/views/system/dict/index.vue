<script lang="ts" setup>
  import { addDict, changeDictStatus, editDict, getDictList } from '@/api/system/dict';
  import { Dict, DictParams } from '@/models/dict';
  import { formatDateTime } from '@/utils';
  import { DataTableRowKey, FormInst, NButton, NSwitch, useDialog, useMessage } from 'naive-ui';
  import { h, onMounted, ref } from 'vue';
  import { DeleteOutlined, EditOutlined, PlusOutlined } from '@vicons/antd';
  import { getMenus } from '@/api/system/menu';
  import { handleTree } from '@/utils/menu';
  import { Menu } from '@/models/menu';
  import { RowData } from 'naive-ui/es/data-table/src/interface';
  import { renderIcon } from '@/utils/icons';
  import { hasPermission } from '@/utils/permission';

  const message = useMessage();
  const dialog = useDialog();

  const showDrawer = ref(false);
  const drawerTitle = ref('');

  const treeData = ref<Menu[]>([]);

  const allMenuKeys = ref<string[]>([]);

  const formRef = ref<FormInst | null>(null);
  const drawerFormRef = ref<FormInst | null>(null);

  // 新增/修改弹窗数据初始化
  const dictInitData: Dict = {
    dictId: '',
    dictName: '',
    dictCode: '',
    dictType: '',
    sort: 0,
    status: 0,
    description: '',
  };
  const drawerFormData = ref(dictInitData);

  const drawerRules = {
    dictName: { required: true, message: '字典名称必填', trigger: 'blur' },
    dictCode: { required: true, message: '字典编码必填', trigger: 'blur' },
    dictType: { required: true, message: '字典类型必填', trigger: 'blur' },
    sort: { type: 'number', required: true, message: '排序必填', trigger: 'blur' },
    status: { required: true, message: '状态必填', trigger: 'blur' },
  };

  // 状态select options
  const statusOptions = ref([
    { label: '正常', value: 0 },
    { label: '停用', value: 1 },
  ]);

  const queryFormData = ref({
    dictName: '',
    dictCode: '',
    dictType: '',
    status: null,
  });

  const columns = [
    {
      key: 'dictId',
      title: '字典ID',
      type: 'selection',
    },
    {
      key: 'dictName',
      title: '字典名称',
      width: 100,
      ellipsis: {
        tooltip: true,
      },
    },
    {
      key: 'dictCode',
      title: '字典编码',
      width: 100,
      ellipsis: {
        tooltip: true,
      },
    },
    {
      key: 'dictType',
      title: '字典类型',
      width: 100,
      ellipsis: {
        tooltip: true,
      },
    },
    {
      key: 'sort',
      title: '排序',
      width: 60,
    },
    {
      key: 'status',
      title: '状态',
      width: 60,
      align: 'center',
      fixed: 'left',
      render(row: RowData) {
        return h(NSwitch, {
          size: 'small',
          rubberBand: false,
          value: row['status'] === 0,
          disabled: !hasPermission('system_dict_edit'),
          tableLoading: !!row.changing,
          onUpdateValue: () => handleChangeStatus(row),
        });
      },
    },
    {
      key: 'createdAt',
      title: '创建时间',
      width: 120,
      ellipsis: {
        tooltip: true,
      },
      render(row: RowData) {
        return h('span', formatDateTime(row['createdAt']));
      },
    },
    {
      key: 'actions',
      title: '操作',
      align: 'center',
      fixed: 'right',
      width: 180,
      render(row: RowData) {
        return [
          h(
            NButton,
            {
              size: 'small',
              type: 'primary',
              style: 'margin-left: 10px;',
              disabled: !hasPermission('system_dict_edit'),
              onClick: () => handleEdit(row),
            },
            {
              default: () => '编辑',
              icon: renderIcon(EditOutlined),
            },
          ),

          h(
            NButton,
            {
              size: 'small',
              type: 'error',
              style: 'margin-left: 10px;',
              disabled: !hasPermission('system_dict_delete'),
              onClick: () => handleDelete(row),
            },
            {
              default: () => '删除',
              icon: renderIcon(DeleteOutlined),
            },
          ),
        ];
      },
    },
  ];

  const tableLoading = ref(true);
  const rowKey = (rowData: RowData) => {
    return rowData.dictId;
  };
  const checkedRowKeysRef = ref<DataTableRowKey[]>([]);
  const tableData = ref<Dict[]>([]);
  const pagination = ref({
    page: 1,
    pageSize: 10,
    pageCount: 1,
    showSizePicker: true,
    showQuickJumper: true,
    pageSizes: [3, 5, 7],
    itemCount: 0,
    prefix({ itemCount }) {
      return `共 ${itemCount} 条`;
    },
    onChange: (page: number) => {
      pagination.value.page = page;
    },
    onUpdatePageSize: (pageSize: number) => {
      pagination.value.pageSize = pageSize;
      pagination.value.page = 1;
    },
  });

  // 绑定表格数据
  const query = async (page: number, pageSize = 10) => {
    try {
      tableLoading.value = true;
      const requestData: DictParams = {
        ...queryFormData.value,
        page: page,
        pageSize,
      };

      const res = await getDictList(requestData);
      if (res?.code === 0) {
        tableData.value = res.data?.list;
        pagination.value.page = page;
        pagination.value.pageSize = pageSize;
        pagination.value.itemCount = res.data.count;
      }
    } catch (err) {
      tableData.value = [];
    }
    tableLoading.value = false;
  };

  // 查询菜单下拉树结构
  const getMenuTree = () => {
    getMenus().then((response) => {
      const menus = handleTree<Menu>(response.data, 'menuId');
      allMenuKeys.value = response.data.map((item) => item.menuId);
      treeData.value = menus;
    });
  };

  const handleQuery = () => {
    query(pagination.value.page, pagination.value.pageSize);
  };

  const clearQuery = () => {
    queryFormData.value = {
      dictName: '',
      dictCode: '',
      dictType: '',
      status: null,
    };
    query(1, pagination.value.pageSize);
  };

  const handlePageChange = (currentPage: number) => {
    query(currentPage, pagination.value.pageSize);
  };

  const handleCheck = (rowKeys: DataTableRowKey[]) => {
    checkedRowKeysRef.value = rowKeys;
  };

  // 改变状态
  const handleChangeStatus = (row: RowData) => {
    row.changing = true;
    let text = '停用';

    const dict: Dict = { ...dictInitData };
    Object.assign(dict, row);

    switch (row.status) {
      case 1:
        text = '启用';
        dict.status = 0;
        break;
      case 0:
        text = '停用';
        dict.status = 1;
        break;
      case -1:
        text = '删除';
        break;
    }

    dialog.info({
      title: '系统消息',
      content: `确认要"${text}""${row.dictName}"字典吗？`,
      positiveText: '确定',
      negativeText: '取消',
      onPositiveClick: async () => {
        const res = await changeDictStatus(dict);
        if (res?.code === 0) {
          message.success(`${text}成功`);
        }
        row.changing = false;
        await query(pagination.value.page, pagination.value.pageSize);
      },
      onNegativeClick: () => {
        row.changing = false;
      },
    });
  };

  // 新增字典
  const handleAdd = async () => {
    drawerTitle.value = '新增字典';
    showDrawer.value = true;

    drawerFormData.value = { ...dictInitData };
  };

  // 删除字典 status = -1
  const handleDelete = async (row: RowData) => {
    row.status = -1;
    handleChangeStatus(row);
  };

  // 修改字典
  const handleEdit = async (row: RowData) => {
    drawerTitle.value = '修改字典';
    showDrawer.value = true;

    // 赋值
    Object.assign(drawerFormData.value, row);
  };

  const handleAddandEdit = (e: MouseEvent) => {
    e.preventDefault();
    const messageReactive = message.loading('处理中', {
      duration: 0,
    });
    drawerFormRef.value?.validate(async (errors) => {
      if (!errors) {
        const requestData: Dict = drawerFormData.value;

        const res = drawerFormData.value.dictId
          ? await editDict(requestData)
          : await addDict(requestData);

        if (res?.code === 0) {
          showDrawer.value = false;
          drawerFormData.value = { ...dictInitData };
          query(pagination.value.page, pagination.value.pageSize);
        }
      } else {
        console.log(errors);
        message.error('验证不通过');
      }

      messageReactive.destroy();
    });
  };

  onMounted(async () => {
    getMenuTree();

    query(pagination.value.page, pagination.value.pageSize);
  });
</script>

<template>
  <n-card :bordered="false">
    <n-form ref="formRef" inline label-placement="left" label-width="auto" :model="queryFormData">
      <n-grid :cols="24" :x-gap="24">
        <n-form-item-gi :span="6" label="字典名称" path="dictName">
          <n-input v-model:value="queryFormData.dictName" placeholder="请输入字典名称" />
        </n-form-item-gi>
        <n-form-item-gi :span="6" label="字典编码" path="dictCode">
          <n-input v-model:value="queryFormData.dictCode" placeholder="请输入字典编码" />
        </n-form-item-gi>
        <n-form-item-gi :span="6" label="字典类型" path="dictType">
          <n-input v-model:value="queryFormData.dictType" placeholder="请输入字典类型" />
        </n-form-item-gi>
        <n-form-item-gi :span="6" label="状态" path="status">
          <n-select v-model:value="queryFormData.status" :options="statusOptions" />
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
  <n-card :bordered="false" class="mt-2">
    <div class="mb-2">
      <!--顶部左侧区域-->
      <div class="flex items-center">
        <n-button v-permission="['system_dict_add']" type="primary" @click="handleAdd">
          <template #icon>
            <n-icon>
              <PlusOutlined />
            </n-icon>
          </template>
          添加字典
        </n-button>
      </div>
    </div>
    <div>
      <n-data-table
        ref="table"
        remote
        :columns="columns"
        :data="tableData"
        :loading="tableLoading"
        :pagination="pagination"
        :row-key="rowKey"
        @update:checked-row-keys="handleCheck"
        @update:page="handlePageChange"
      />
    </div>
  </n-card>

  <!-- 新增修改字典 -->
  <n-drawer v-model:show="showDrawer" :width="399">
    <n-drawer-content :title="drawerTitle" closable>
      <n-form
        ref="drawerFormRef"
        label-placement="left"
        label-width="auto"
        :model="drawerFormData"
        :rules="drawerRules"
      >
        <n-form-item label="字典名称" path="dictName">
          <n-input v-model:value="drawerFormData.dictName" placeholder="输入字典名称" />
        </n-form-item>
        <n-form-item label="字典编码" path="dictCode">
          <n-input v-model:value="drawerFormData.dictCode" placeholder="输入字典编码" />
        </n-form-item>
        <n-form-item label="字典类型" path="dictType">
          <n-input v-model:value="drawerFormData.dictType" placeholder="输入字典类型" />
        </n-form-item>
        <n-form-item label="排序" path="sort">
          <n-input-number v-model:value="drawerFormData.sort" :min="0" />
        </n-form-item>
        <n-form-item label="状态" name="status">
          <n-radio-group v-model:value="drawerFormData.status">
            <n-space>
              <n-radio v-for="item in statusOptions" :key="item.value" :value="item.value">
                {{ item.label }}
              </n-radio>
            </n-space>
          </n-radio-group>
        </n-form-item>
        <n-form-item label="描述" name="description">
          <n-input
            v-model:value="drawerFormData.description"
            type="textarea"
            placeholder="请输入字典描述"
          />
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
