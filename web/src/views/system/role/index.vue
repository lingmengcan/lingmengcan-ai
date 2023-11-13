<template>
  <n-card :bordered="false">
    <n-form ref="formRef" inline label-placement="left" label-width="auto" :model="queryFormData">
      <n-grid :cols="24" :x-gap="24">
        <n-form-item-gi :span="6" label="角色名称" path="roleName">
          <n-input v-model:value="queryFormData.roleName" placeholder="请输入角色名称" />
        </n-form-item-gi>
        <n-form-item-gi :span="6" label="角色编码" path="roleCode">
          <n-input v-model:value="queryFormData.roleCode" placeholder="请输入角色编码" />
        </n-form-item-gi>
        <n-form-item-gi :span="6" label="状态" path="status">
          <n-select v-model:value="queryFormData.status" :options="statusOptions" />
        </n-form-item-gi>
        <n-form-item-gi :span="6">
          <n-button type="primary" @click="handleQuery"> 查询 </n-button>
        </n-form-item-gi>
      </n-grid>
    </n-form>
  </n-card>
  <n-card :bordered="false" class="mt-4">
    <div class="table-toolbar">
      <!--顶部左侧区域-->
      <div class="flex items-center table-toolbar-left">
        <n-button type="primary">
          <template #icon>
            <n-icon>
              <PlusOutlined />
            </n-icon>
          </template>
          添加角色
        </n-button>
      </div>
    </div>
    <div class="s-table">
      <n-data-table
        ref="table"
        remote
        :columns="columns"
        :data="data"
        :loading="loading"
        :pagination="pagination"
        :row-key="rowKey"
        @update:checked-row-keys="handleCheck"
        @update:page="handlePageChange"
      />
    </div>
  </n-card>

  //菜单权限管理
  <n-modal v-model:show="showMenuModal" :show-icon="false" preset="dialog" :title="editRoleTitle">
    <div class="py-3 menu-list">
      <n-tree
        block-line
        cascade
        checkable
        :virtual-scroll="true"
        :data="treeData"
        key-field="menuId"
        label-field="menuName"
        :expanded-keys="expandedKeys"
        :checked-keys="checkedKeys"
        style="max-height: 950px; overflow: hidden"
        @update:checked-keys="checkedTree"
        @update:expanded-keys="onExpandedKeys"
      />
    </div>
    <template #action>
      <n-space>
        <n-button type="info" ghost icon-placement="left" @click="packHandle">
          全部{{ expandedKeys.length ? '收起' : '展开' }}
        </n-button>

        <n-button type="info" ghost icon-placement="left" @click="checkedAllHandle">
          全部{{ checkedAll ? '取消' : '选择' }}
        </n-button>
        <n-button type="primary" :loading="formBtnLoading" @click="confirmMenuForm">提交</n-button>
      </n-space>
    </template>
  </n-modal>
</template>

<script lang="ts" setup>
  import { changeRoleStatus, getRoleList, getRoleMenuIds } from '@/api/system/role';
  import { Role, RoleParams } from '@/models/role';
  import { formatDateTime, getTreeAll, renderIcon } from '@/utils';
  import { DataTableRowKey, FormInst, NButton, NSwitch, useDialog, useMessage } from 'naive-ui';
  import { RowData } from 'naive-ui/es/data-table/src/interface';
  import { h, onMounted, ref } from 'vue';
  import { useRouter } from 'vue-router';
  import {
    UserSwitchOutlined,
    DeleteOutlined,
    EditOutlined,
    PlusOutlined,
    MenuOutlined,
  } from '@vicons/antd';
  import { getMenus } from '@/api/system/menu';
  import { handleTree } from '@/utils/menu';
  import { Menu } from '@/models/menu';

  const message = useMessage();
  const dialog = useDialog();
  const router = useRouter();

  const showMenuModal = ref(false);
  const formBtnLoading = ref(false);
  const checkedAll = ref(false);
  const editRoleTitle = ref('');
  const treeData = ref<Menu[]>([]);
  const expandedKeys = ref(['']);
  const checkedKeys = ref<string[]>([]);

  const formRef = ref<FormInst | null>(null);

  // 状态select options
  const statusOptions = ref([
    { label: '正常', value: '0' },
    { label: '停用', value: '1' },
  ]);
  const queryFormData = ref({
    roleName: '',
    roleCode: '',
    status: undefined,
  });

  const columns = [
    {
      key: 'roleId',
      title: '角色ID',
      type: 'selection',
    },
    {
      key: 'roleName',
      title: '角色名称',
      width: 120,
      ellipsis: {
        tooltip: true,
      },
    },
    {
      key: 'roleCode',
      title: '角色编码',
      width: 120,
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
          loading: !!row.changing,
          onUpdateValue: () => handleChangeStatus(row),
        });
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
      width: 320,
      render(row: RowData) {
        return [
          h(
            NButton,
            {
              size: 'small',
              type: 'primary',
              secondary: true,
              onClick: () => handleMenu(row),
            },
            { default: () => '菜单权限', icon: renderIcon(MenuOutlined) },
          ),
          h(
            NButton,
            {
              size: 'small',
              type: 'info',
              tertiary: true,
              style: 'margin-left: 15px;',
              onClick: () => handleUser(row),
            },
            { default: () => '分配用户', icon: renderIcon(UserSwitchOutlined) },
          ),
          h(
            NButton,
            {
              size: 'small',
              type: 'primary',
              style: 'margin-left: 15px;',
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
              style: 'margin-left: 15px;',
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

  const loading = ref(true);
  const rowKey = (rowData: RowData) => {
    return rowData.roleId;
  };
  const checkedRowKeysRef = ref<DataTableRowKey[]>([]);
  const data = ref<Role[]>([]);
  const pagination = ref({
    page: 1,
    pageSize: 5,
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
      loading.value = true;
      const requestData: RoleParams = {
        ...queryFormData.value,
        page: page,
        pageSize,
      };

      const res = await getRoleList(requestData);
      if (res?.code === 0) {
        data.value = res.data?.list;
        pagination.value.page = page;
        pagination.value.pageSize = pageSize;
        pagination.value.itemCount = res.data.count;
      }
    } catch (err) {
      data.value = [];
    }
    loading.value = false;
  };

  // 查询菜单下拉树结构
  const getMenuTree = () => {
    getMenus().then((response) => {
      const menus = handleTree<Menu>(response.data, 'menuId');
      treeData.value = menus;
    });
  };

  const handleQuery = () => {
    query(pagination.value.page, pagination.value.pageSize);
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

    const role: Role = { roleId: '', roleName: '', roleCode: '', sort: 0, status: 0 };
    Object.assign(role, row);

    switch (row.status) {
      case 1:
        text = '启用';
        role.status = 0;
        break;
      case 0:
        text = '停用';
        role.status = 1;
        break;
      case -1:
        text = '删除';
        break;
    }

    dialog.info({
      title: '系统消息',
      content: `确认要"${text}""${row.roleName}"角色吗？`,
      positiveText: '确定',
      negativeText: '取消',
      onPositiveClick: async () => {
        const res = await changeRoleStatus(role);
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

  // 删除角色 statu = -1
  const handleDelete = async (row: RowData) => {
    row.status = -1;
    handleChangeStatus(row);
  };

  // 修改角色
  const handleEdit = async (row: RowData) => {
    // dialogTitle.value = '修改角色';
    // dialogVisible.value = true;
    // dialogFormData.value = { ...row };
    // const res = await getRoleMenuIds(dialogFormData.value.roleId);
    // if (res?.code === 0 && res?.data) {
    //   menusChecked.value = res?.data;
    // }
  };

  // 分配菜单
  const handleMenu = async (row: RowData) => {
    editRoleTitle.value = `分配 ${row.roleName} 的菜单权限`;

    const res = await getRoleMenuIds(row.roleId);
    if (res?.code === 0 && res?.data) {
      checkedKeys.value = res?.data;
    }
    showMenuModal.value = true;
  };

  function checkedTree(keys) {
    checkedKeys.value = [checkedKeys.value, ...keys];
  }

  function onExpandedKeys(keys) {
    expandedKeys.value = keys;
  }

  function packHandle() {
    if (expandedKeys.value.length) {
      expandedKeys.value = [];
    } else {
      expandedKeys.value = treeData.value.map((item: any) => item.key) as [];
    }
  }

  function checkedAllHandle() {
    if (!checkedAll.value) {
      checkedKeys.value = getTreeAll(treeData.value);
      checkedAll.value = true;
    } else {
      checkedKeys.value = [];
      checkedAll.value = false;
    }
  }

  function confirmMenuForm() {
    formBtnLoading.value = true;
    setTimeout(() => {
      showMenuModal.value = false;
      message.success('提交成功');
      query(pagination.value.page, pagination.value.pageSize);
      formBtnLoading.value = false;
    }, 200);
  }

  // 分配用户
  const handleUser = async (row: RowData) => {
    router.push({
      path: '/right/role/user/',
      query: { id: row.roleId },
    });
  };

  onMounted(async () => {
    getMenuTree();

    query(pagination.value.page, pagination.value.pageSize);
  });
</script>
