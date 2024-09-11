<template>
  <n-card :bordered="false">
    <n-form ref="formRef" inline label-placement="left" label-width="auto" :model="queryFormData">
      <n-grid :cols="24" :x-gap="24">
        <n-form-item-gi :span="6" :label="$t('views.system.menu.menuName')" path="menuName">
          <n-input v-model:value="queryFormData.menuName" :placeholder="$t('views.system.menu.placeholder.menuName')" />
        </n-form-item-gi>
        <n-form-item-gi :span="6" :label="$t('common.status')" path="status">
          <selectStatus v-model:status="queryFormData.status" />
        </n-form-item-gi>
        <n-form-item-gi :span="6">
          <n-space>
            <n-button @click="clearQuery">{{ $t('common.reset') }}</n-button>
            <n-button v-permission="['system_menu_query']" type="primary" @click="handleQuery">
              {{ $t('common.query') }}
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
        <n-button v-permission="['system_menu_add']" type="primary" @click="handleAdd">
          <template #icon>
            <n-icon>
              <PlusOutlined />
            </n-icon>
          </template>
          {{ $t('views.system.menu.add') }}
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
          <n-form-item-gi :span="24" :label="$t('views.system.menu.parentMenu')" path="parentId">
            <n-tree-select
              v-model:value="drawerFormData.parentId"
              :options="treeMenus"
              label-field="menuName"
              key-field="menuId"
            />
          </n-form-item-gi>
          <n-form-item-gi :span="24" :label="$t('views.system.menu.menuType')" path="menuType">
            <n-radio-group v-model:value="drawerFormData.menuType">
              <n-space>
                <n-radio v-for="item in typeOptions" :key="item.value" :value="item.value">
                  {{ item.label }}
                </n-radio>
              </n-space>
            </n-radio-group>
          </n-form-item-gi>
          <n-form-item-gi :span="24" :label="$t('views.system.menu.icon')" path="icon">
            <SelectIcon v-model:value="drawerFormData.icon" @selected="onSelectedIcon" />
          </n-form-item-gi>
          <n-form-item-gi :span="12" :label="$t('views.system.menu.menuName')" path="menuName">
            <n-input
              v-model:value="drawerFormData.menuName"
              :placeholder="$t('views.system.menu.placeholder.menuName')"
            />
          </n-form-item-gi>
          <n-form-item-gi :span="12" :label="$t('views.system.menu.menuCode')" path="menuCode">
            <n-input
              v-model:value="drawerFormData.menuCode"
              :placeholder="$t('views.system.menu.placeholder.menuCode')"
            />
          </n-form-item-gi>
          <n-form-item-gi :span="12" :label="$t('views.system.menu.sort')" path="sort">
            <n-input-number v-model:value="drawerFormData.sort" :min="0" />
          </n-form-item-gi>
          <n-form-item-gi :span="12" :label="$t('common.status')" path="status">
            <selectStatus v-model:status="drawerFormData.status" />
          </n-form-item-gi>
          <n-form-item-gi
            v-if="drawerFormData.menuType !== 'action'"
            :span="12"
            :label="$t('views.system.menu.path')"
            path="path"
          >
            <n-input v-model:value="drawerFormData.path" :placeholder="$t('views.system.menu.placeholder.path')" />
          </n-form-item-gi>
          <n-form-item-gi
            v-if="drawerFormData.menuType === 'contents'"
            :span="12"
            :label="$t('views.system.menu.redirect')"
            path="redirect"
          >
            <n-input
              v-model:value="drawerFormData.redirect"
              :placeholder="$t('views.system.menu.placeholder.redirect')"
            />
          </n-form-item-gi>
          <n-form-item-gi
            v-if="drawerFormData.menuType === 'button'"
            :span="12"
            :label="$t('views.system.menu.query')"
            path="query"
          >
            <n-input v-model:value="drawerFormData.query" :placeholder="$t('views.system.menu.placeholder.query')" />
          </n-form-item-gi>
          <n-form-item-gi
            v-if="drawerFormData.menuType !== 'button'"
            :span="12"
            :label="$t('views.system.menu.component')"
            path="component"
          >
            <n-input
              v-model:value="drawerFormData.component"
              :placeholder="$t('views.system.menu.placeholder.component')"
            />
          </n-form-item-gi>
          <n-form-item-gi
            v-if="drawerFormData.menuType !== 'button'"
            :span="12"
            :label="$t('views.system.menu.permissions')"
            path="permissions"
          >
            <n-input
              v-model:value="drawerFormData.permissions"
              :placeholder="$t('views.system.menu.placeholder.permissions')"
            />
          </n-form-item-gi>
          <n-form-item-gi :span="12" :label="$t('views.system.menu.cached')" path="cached">
            <n-switch v-model:value="drawerFormData.cached" />
          </n-form-item-gi>
          <n-form-item-gi :span="12" :label="$t('views.system.menu.hidden')" path="hidden">
            <n-switch v-model:value="drawerFormData.hidden" />
          </n-form-item-gi>

          <n-form-item-gi :label="$t('views.system.menu.description')" :span="24">
            <n-input
              v-model:value="drawerFormData.description"
              type="textarea"
              :placeholder="$t('views.system.menu.placeholder.description')"
            />
          </n-form-item-gi>
        </n-grid>
      </n-form>
      <template #footer>
        <n-space>
          <n-button type="primary" attr-type="button" @click="handleAddandEdit">{{ $t('common.submit') }}</n-button>
        </n-space>
      </template>
    </n-drawer-content>
  </n-drawer>
</template>

<script lang="ts" setup>
  import { h, onMounted, ref } from 'vue';
  import selectStatus from '@/components/select/select-status.vue';
  import SelectIcon from '@/components/select/select-icon.vue';
  import { DataTableRowKey, FormInst, NButton, NIcon, NTag, useDialog, useMessage } from 'naive-ui';
  import { RowData } from 'naive-ui/es/data-table/src/interface';
  import { DeleteOutlined, EditOutlined, FolderAddOutlined, PlusOutlined } from '@vicons/antd';
  import { formatDateTime } from '@/utils';
  import { Menu, MenuParams } from '@/models/menu';
  import { addMenu, deleteMenu, editMenu, getMenuList, getMenus } from '@/api/system/menu';
  import { handleTree } from '@/utils/menu';
  import { renderIcon, renderIonicons5 } from '@/utils/icons';
  import { hasPermission } from '@/utils/permission';
  import { useI18n } from 'vue-i18n';

  const { t } = useI18n();

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
      title: t('views.system.menu.menuName'),
      width: 120,
    },
    {
      key: 'icon',
      title: t('views.system.menu.icon'),
      width: 50,
      render(row: RowData) {
        return row.icon ? h(renderIonicons5(row.icon, 20)) : null;
      },
    },
    {
      key: 'sort',
      title: t('views.system.menu.sort'),
      width: 50,
    },
    {
      key: 'permissions',
      title: t('views.system.menu.permissions'),
      width: 120,
      ellipsis: {
        tooltip: true,
      },
    },
    {
      key: 'component',
      title: t('views.system.menu.component'),
      width: 120,
      ellipsis: {
        tooltip: true,
      },
    },
    {
      key: 'status',
      title: t('common.status'),
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
            default: () => (row['status'] === 0 ? t('common.enable') : t('common.disable')),
          },
        );
      },
    },
    {
      key: 'createdAt',
      title: t('views.system.menu.createdAt'),
      width: 120,
      render(row: RowData) {
        return h('span', formatDateTime(row['createdAt']));
      },
    },
    {
      key: 'actions',
      title: t('common.table.actions'),
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
              disabled: !hasPermission('system_menu_add'),
              onClick: () => handleSubAdd(row.menuId),
            },
            { default: () => t('views.system.menu.newSubMenu'), icon: renderIcon(FolderAddOutlined) },
          ),
          h(
            NButton,
            {
              size: 'small',
              type: 'primary',
              style: 'margin-left: 10px;',
              disabled: !hasPermission('system_menu_edit'),
              onClick: () => handleEdit(row),
            },
            {
              default: () => t('common.edit'),
              icon: renderIcon(EditOutlined),
            },
          ),

          h(
            NButton,
            {
              size: 'small',
              type: 'error',
              style: 'margin-left: 10px;',
              disabled: !hasPermission('system_menu_delete'),
              onClick: () => handleDelete(row),
            },
            {
              default: () => t('common.delete'),
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
    menuName: { required: true, message: t('views.system.menu.placeholder.menuName'), trigger: 'blur' },
    sort: { type: 'number', required: true, message: t('views.system.menu.placeholder.sort'), trigger: 'blur' },
  };

  // 状态 type options
  const typeOptions = ref([
    { label: t('views.system.menu.contents'), value: 'contents' },
    { label: t('views.system.menu.menu'), value: 'menu' },
    { label: t('views.system.menu.action'), value: 'action' },
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

    drawerTitle.value = t('views.system.menu.add');
    showDrawer.value = true;
    drawerFormData.value = { ...menuInitData };
  };

  // 新增子菜单
  const handleSubAdd = async (menuId: string) => {
    getTreeselect();

    drawerTitle.value = t('views.system.menu.add');
    showDrawer.value = true;
    drawerFormData.value = { ...menuInitData };
    drawerFormData.value.parentId = menuId;
  };

  // 删除菜单 statu = -1
  const handleDelete = async (row: RowData) => {
    dialog.info({
      title: t('common.info'),
      content: t('views.system.menu.confirmMessage', { menu: row.roleName }),
      positiveText: t('common.confirm'),
      negativeText: t('common.cancel'),
      onPositiveClick: async () => {
        const res = await deleteMenu(row.menuId);
        if (res?.code === 0) {
          message.success(`${t('common.delete')}${t('common.success')}`);
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

    drawerTitle.value = `${t('common.edit')}${t('views.system.menu.index')}`;
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
    const messageReactive = message.loading('loading', {
      duration: 0,
    });

    drawerFormRef.value?.validate(async (errors) => {
      if (!errors) {
        const requestData: Menu = {
          ...drawerFormData.value,
        };

        const res = drawerFormData.value.menuId ? await editMenu(requestData) : await addMenu(requestData);

        if (res?.code === 0) {
          showDrawer.value = false;
          drawerFormData.value = { ...menuInitData };
          query();
        }
      } else {
        console.log(errors);
        message.error(t('common.validationFailed'));
      }

      messageReactive.destroy();
    });
  };

  onMounted(async () => {
    await query();
  });
</script>
