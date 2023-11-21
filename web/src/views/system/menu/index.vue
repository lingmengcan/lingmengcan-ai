<template>
  <n-card :bordered="false">
    <n-form ref="formRef" inline label-placement="left" label-width="auto" :model="queryFormData">
      <n-grid :cols="24" :x-gap="24">
        <n-form-item-gi :span="6" label="菜单名称" path="menuName">
          <n-input v-model:value="queryFormData.menuName" placeholder="请输入菜单名称" />
        </n-form-item-gi>
        <n-form-item-gi :span="6" label="状态" path="status">
          <SelectStatus v-model:status="queryFormData.status" />
        </n-form-item-gi>
        <n-form-item-gi :span="6">
          <n-space>
            <n-button @click="clearQuery"> 重置 </n-button>
            <n-button type="primary" @click="handleQuery"> 查询 </n-button>
          </n-space>
        </n-form-item-gi>
      </n-grid>
    </n-form>
  </n-card>

  <n-card :bordered="false" class="mt-4">
    <div class="table-toolbar">
      <!--顶部左侧区域-->
      <div class="flex items-center table-toolbar-left">
        <n-button type="primary" @click="handleAdd">
          <template #icon>
            <n-icon>
              <PlusOutlined />
            </n-icon>
          </template>
          添加菜单
        </n-button>
      </div>
    </div>
    <div class="s-table">
      <n-data-table
        ref="table"
        remote
        :columns="columns"
        :data="tableData"
        :loading="tableLoading"
        :row-key="rowKey"
        @update:checked-row-keys="handleCheck"
      />
    </div>
  </n-card>

  <!-- 新增修改菜单 -->
  <n-drawer v-model:show="showDrawer" :width="600">
    <n-drawer-content :title="drawerTitle" closable>
      <n-form
        ref="drawerFormRef"
        label-placement="left"
        label-width="auto"
        :model="drawerFormData"
        :rules="drawerRules"
      >
        <n-grid :cols="24" :x-gap="24">
          <n-form-item-gi :span="24" label="上级菜单" path="parentId">
            <n-tree-select
              v-model:value="drawerFormData.parentId"
              :options="treeMenus"
              label-field="menuName"
              key-field="menuId"
            />
          </n-form-item-gi>
          <n-form-item-gi :span="24" label="菜单类型" path="menuType">
            <n-radio-group v-model:value="drawerFormData.menuType">
              <n-space>
                <n-radio v-for="item in typeOptions" :key="item.value" :value="item.value">
                  {{ item.label }}
                </n-radio>
              </n-space>
            </n-radio-group>
          </n-form-item-gi>
          <n-form-item-gi :span="24" label="菜单图标" path="icon">
            <SelectIcon v-model:value="drawerFormData.icon" @selected="onSelectedIcon" />
          </n-form-item-gi>
          <n-form-item-gi :span="12" label="菜单名称" path="menuName">
            <n-input v-model:value="drawerFormData.menuName" placeholder="请输入菜单名称" />
          </n-form-item-gi>
          <n-form-item-gi :span="12" label="菜单代码" path="menuCode">
            <n-input v-model:value="drawerFormData.menuCode" placeholder="请输入菜单代码" />
          </n-form-item-gi>
          <n-form-item-gi :span="12" label="排序" path="sort">
            <n-input-number v-model:value="drawerFormData.sort" :min="0" />
          </n-form-item-gi>
          <n-form-item-gi :span="12" label="状态" path="status">
            <SelectStatus v-model:status="drawerFormData.status" />
          </n-form-item-gi>
          <n-form-item-gi
            v-if="drawerFormData.menuType !== 'action'"
            :span="12"
            label="路由地址"
            path="path"
          >
            <n-input v-model:value="drawerFormData.path" placeholder="请输入路由地址" />
          </n-form-item-gi>
          <n-form-item-gi
            v-if="drawerFormData.menuType === 'contents'"
            :span="12"
            label="重定向"
            path="redirect"
          >
            <n-input v-model:value="drawerFormData.redirect" placeholder="请输入重定向地址" />
          </n-form-item-gi>
          <n-form-item-gi
            v-if="drawerFormData.menuType === 'button'"
            :span="12"
            label="路由参数"
            path="query"
          >
            <n-input v-model:value="drawerFormData.query" placeholder="请输入路由参数" />
          </n-form-item-gi>
          <n-form-item-gi
            v-if="drawerFormData.menuType !== 'button'"
            :span="12"
            label="组件路径"
            path="component"
          >
            <n-input v-model:value="drawerFormData.component" placeholder="请输入组件路径" />
          </n-form-item-gi>
          <n-form-item-gi
            v-if="drawerFormData.menuType !== 'button'"
            :span="12"
            label="权限标识"
            path="permissions"
          >
            <n-input v-model:value="drawerFormData.permissions" placeholder="请输入权限标识" />
          </n-form-item-gi>
          <n-form-item-gi :span="12" label="是否缓存" path="cached">
            <n-switch v-model:value="drawerFormData.cached" />
          </n-form-item-gi>
          <n-form-item-gi :span="12" label="是否隐藏" path="hidden">
            <n-switch v-model:value="drawerFormData.hidden" />
          </n-form-item-gi>

          <n-form-item-gi label="描述" :span="24">
            <n-input
              v-model:value="drawerFormData.description"
              type="textarea"
              placeholder="请输入菜单描述"
            />
          </n-form-item-gi>
        </n-grid>
      </n-form>
      <template #footer>
        <n-space>
          <n-button type="primary" attr-type="button" @click="handleAddandEdit">确定</n-button>
        </n-space>
      </template>
    </n-drawer-content>
  </n-drawer>
</template>

<script lang="ts" setup>
  import { h, onMounted, ref } from 'vue';
  import SelectStatus from '@/components/select/select-status.vue';
  import SelectIcon from '@/components/select/select-icon.vue';
  import { DataTableRowKey, FormInst, NButton, NIcon, NTag, useDialog, useMessage } from 'naive-ui';
  import { RowData } from 'naive-ui/es/data-table/src/interface';
  import { DeleteOutlined, EditOutlined, FolderAddOutlined, PlusOutlined } from '@vicons/antd';
  import { formatDateTime } from '@/utils';
  import { Menu, MenuParams } from '@/models/menu';
  import { addMenu, deleteMenu, editMenu, getMenuList, getMenus } from '@/api/system/menu';
  import { handleTree } from '@/utils/menu';
  import { renderIcon, renderIonicons5 } from '@/utils/icons';

  const message = useMessage();
  const dialog = useDialog();

  const showDrawer = ref(false);
  const drawerTitle = ref('');

  const formRef = ref<FormInst | null>(null);
  const drawerFormRef = ref<FormInst | null>(null);

  const queryFormData = ref({
    menuName: '',
    status: null,
  });

  const columns = [
    {
      key: 'menuId',
      type: 'selection',
    },
    {
      key: 'menuName',
      title: '菜单名称',
      width: 120,
    },
    {
      key: 'icon',
      title: '图标',
      width: 50,
      render(row: RowData) {
        return row.icon ? h(renderIonicons5(row.icon, 20)) : null;
      },
    },
    {
      key: 'sort',
      title: '排序',
      width: 50,
    },
    {
      key: 'permissions',
      title: '权限标识',
      width: 120,
      ellipsis: {
        tooltip: true,
      },
    },
    {
      key: 'component',
      title: '组件路径',
      width: 120,
      ellipsis: {
        tooltip: true,
      },
    },
    {
      key: 'status',
      title: '状态',
      width: 50,
      align: 'center',
      fixed: 'left',
      render(row: RowData) {
        return h(
          NTag,
          {
            type: 'info',
            bordered: false,
          },
          {
            default: () => (row['status'] === 0 ? '正常' : '停用'),
          },
        );
      },
    },
    {
      key: 'createdAt',
      title: '创建时间',
      width: 120,
      render(row: RowData) {
        return h('span', formatDateTime(row['createDate']));
      },
    },
    {
      key: 'actions',
      title: '操作',
      align: 'center',
      fixed: 'right',
      width: 240,
      render(row: RowData) {
        return [
          h(
            NButton,
            {
              size: 'small',
              type: 'info',
              tertiary: true,
              style: 'margin-left: 10px;',
              onClick: () => handleSubAdd(row.menuId),
            },
            { default: () => '新增子菜单', icon: renderIcon(FolderAddOutlined) },
          ),
          h(
            NButton,
            {
              size: 'small',
              type: 'primary',
              style: 'margin-left: 10px;',
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
    return rowData.menuId;
  };
  const checkedRowKeysRef = ref<DataTableRowKey[]>([]);
  const tableData = ref<Menu[]>([]);

  // 新增/修改弹窗数据初始化
  const menuInitData = {
    menuId: '',
    parentId: '',
    menuType: 'contents',
    menuName: '',
    menuCode: '',
    icon: '',
    status: 0,
    hidden: false,
    cached: false,
    sort: 0,
    permissions: '',
    path: '',
    query: '',
    redirect: '',
    component: '',
    description: '',
  };

  const drawerFormData = ref(menuInitData);
  const drawerRules = {
    menuName: { required: true, message: '菜单名称必填', trigger: 'blur' },
    sort: { type: 'number', required: true, message: '排序必填', trigger: 'blur' },
  };

  // 状态 type options
  const typeOptions = ref([
    { label: '目录', value: 'contents' },
    { label: '菜单', value: 'menu' },
    { label: '动作', value: 'action' },
  ]);

  const treeMenus = ref<Menu[]>([]);

  // 查询菜单下拉树结构
  const getTreeselect = () => {
    getMenus().then((response) => {
      treeMenus.value = [];
      const menu: Menu = { menuId: '0', menuName: '根菜单', children: [] };
      menu.children = handleTree(response.data, 'menuId');
      treeMenus.value.push(menu);
    });
  };

  function onSelectedIcon(item: string) {
    drawerFormData.value.icon = item;
  }

  // 绑定表格数据
  const query = async () => {
    try {
      tableLoading.value = true;
      const requestData: MenuParams = {
        ...queryFormData.value,
      };

      const res = await getMenuList(requestData);

      if (res?.code === 0) {
        tableData.value = handleTree(res.data, 'menuId');
      }
    } catch (err) {
      tableData.value = [];
    }
    tableLoading.value = false;
  };

  const handleQuery = () => {
    query();
  };

  const clearQuery = () => {
    queryFormData.value = {
      menuName: '',
      status: null,
    };
    query();
  };

  const handleCheck = (rowKeys: DataTableRowKey[]) => {
    checkedRowKeysRef.value = rowKeys;
  };

  // 新增菜单
  const handleAdd = async () => {
    getTreeselect();

    drawerTitle.value = '新增菜单';
    showDrawer.value = true;
    drawerFormData.value = menuInitData;
  };

  // 新增菜单
  const handleSubAdd = async (menuId: string) => {
    getTreeselect();

    drawerTitle.value = '新增菜单';
    showDrawer.value = true;
    drawerFormData.value = menuInitData;
    drawerFormData.value.parentId = menuId;
  };

  // 删除菜单 statu = -1
  const handleDelete = async (row: RowData) => {
    dialog.info({
      title: '系统消息',
      content: `确认要删除"${row.menuName}"菜单吗？`,
      positiveText: '确定',
      negativeText: '取消',
      onPositiveClick: async () => {
        const res = await deleteMenu(row.menuId);
        if (res?.code === 0) {
          message.success(`删除成功`);
        } else {
          message.warning(res.message);
        }
        row.changing = false;
        await query();
      },
      onNegativeClick: () => {
        row.changing = false;
      },
    });
  };

  // 修改菜单
  const handleEdit = async (row: RowData) => {
    getTreeselect();

    drawerTitle.value = '修改菜单';
    showDrawer.value = true;
    drawerFormData.value = {
      menuId: row.menuId,
      parentId: row.parentId,
      menuType: row.menuType,
      menuName: row.menuName,
      menuCode: row.menuCode,
      icon: row.icon,
      hidden: row.hidden === 1,
      cached: row.cached === 1,
      permissions: row.permissions,
      path: row.path,
      query: row.query,
      redirect: row.redirect,
      component: row.component,
      status: row.status,
      sort: row.sort,
      description: row.description,
    };
  };

  const handleAddandEdit = (e: MouseEvent) => {
    e.preventDefault();
    const messageReactive = message.loading('处理中', {
      duration: 0,
    });

    drawerFormRef.value?.validate(async (errors) => {
      if (!errors) {
        const requestData: Menu = {
          ...drawerFormData.value,
        };

        const res = drawerFormData.value.menuId
          ? await editMenu(requestData)
          : await addMenu(requestData);

        if (res?.code === 0) {
          showDrawer.value = false;
          drawerFormData.value = menuInitData;
          query();
        }
      } else {
        console.log(errors);
        message.error('验证不通过');
      }

      messageReactive.destroy();
    });
  };

  onMounted(async () => {
    await query();
  });
</script>
