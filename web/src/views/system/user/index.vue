<script lang="ts" setup>
  import {
    addUser,
    changeUserStatus,
    editUser,
    getUserList,
    resetPassword,
  } from '@/api/system/user';
  import { User, UserParams } from '@/models/user';
  import { formatDateTime } from '@/utils';
  import { DataTableRowKey, FormInst, NButton, NSwitch, useDialog, useMessage } from 'naive-ui';
  import { h, onMounted, ref } from 'vue';
  import { DeleteOutlined, EditOutlined, PlusOutlined, CiCircleOutlined } from '@vicons/antd';
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
  const userInitData: User = {
    userId: '',
    userName: '',
    nickName: '',
    password: '123456', //初始密码
    email: '',
    phone: '',
    sex: '',
    status: 0,
    description: '',
  };
  const drawerFormData = ref(userInitData);

  const drawerRules = {
    userName: { required: true, message: '用户名称必填', trigger: 'blur' },
    nickName: { required: true, message: '用户名称必填', trigger: 'blur' },
    phone: { required: true, message: '用户昵称必填', trigger: 'blur' },
    email: { required: true, message: 'email必填', trigger: 'blur' },
    sex: { required: true, message: '性别必填', trigger: 'blur' },
    status: { required: true, message: '状态必填', trigger: 'blur' },
  };

  // 状态select options
  const statusOptions = ref([
    { label: '正常', value: 0 },
    { label: '停用', value: 1 },
  ]);

  // sex options
  const sexOptions = ref([
    { label: '男', value: '1' },
    { label: '女', value: '0' },
    { label: '未知', value: '2' },
  ]);

  const queryFormData = ref({
    userName: '',
    nickName: '',
    phone: '',
    status: null,
  });

  const showResetPwdModal = ref(false);
  const resetPwdData = ref({
    userId: '',
    userName: '',
    password: '',
  });

  const columns = [
    {
      key: 'userId',
      title: '用户ID',
      type: 'selection',
    },
    {
      key: 'userName',
      title: '用户名称',
      width: 100,
      ellipsis: {
        tooltip: true,
      },
    },
    {
      key: 'nickName',
      title: '用户昵称',
      width: 100,
      ellipsis: {
        tooltip: true,
      },
    },
    {
      key: 'phone',
      title: '电话',
      width: 100,
      ellipsis: {
        tooltip: true,
      },
    },
    {
      key: 'email',
      title: 'email',
      width: 120,
      ellipsis: {
        tooltip: true,
      },
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
          disabled: !hasPermission('system_user_edit'),
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
        return h('span', formatDateTime(row['createDate']));
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
              disabled: !hasPermission('system_user_edit'),
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
              disabled: !hasPermission('system_user_delete'),
              onClick: () => handleDelete(row),
            },
            {
              default: () => '删除',
              icon: renderIcon(DeleteOutlined),
            },
          ),
          h(
            NButton,
            {
              size: 'small',
              type: 'info',
              style: 'margin-left: 10px;',
              disabled: !hasPermission('system_user_resetpwd'),
              onClick: () => handleResetPassword(row),
            },
            {
              default: () => '重置密码',
              icon: renderIcon(CiCircleOutlined),
            },
          ),
        ];
      },
    },
  ];

  const tableLoading = ref(true);
  const rowKey = (rowData: RowData) => {
    return rowData.userId;
  };
  const checkedRowKeysRef = ref<DataTableRowKey[]>([]);
  const tableData = ref<User[]>([]);
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
      const requestData: UserParams = {
        ...queryFormData.value,
        page: page,
        pageSize,
      };

      const res = await getUserList(requestData);
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
      userName: '',
      nickName: '',
      phone: '',
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

    const user: User = { ...userInitData };
    Object.assign(user, row);

    switch (row.status) {
      case 1:
        text = '启用';
        user.status = 0;
        break;
      case 0:
        text = '停用';
        user.status = 1;
        break;
      case -1:
        text = '删除';
        break;
    }

    dialog.info({
      title: '系统消息',
      content: `确认要"${text}""${row.userName}"用户吗？`,
      positiveText: '确定',
      negativeText: '取消',
      onPositiveClick: async () => {
        const res = await changeUserStatus(user);
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

  // 新增用户
  const handleAdd = async () => {
    drawerTitle.value = '新增用户';
    showDrawer.value = true;
    drawerFormData.value = { ...userInitData };

    console.log(drawerFormData.value.userId);
  };

  // 删除用户 status = -1
  const handleDelete = async (row: RowData) => {
    row.status = -1;
    handleChangeStatus(row);
  };

  // 修改用户
  const handleEdit = async (row: RowData) => {
    drawerTitle.value = '修改用户';
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
        const requestData: User = drawerFormData.value;

        const res = drawerFormData.value.userId
          ? await editUser(requestData)
          : await addUser(requestData);

        if (res?.code === 0) {
          showDrawer.value = false;
          drawerFormData.value = { ...userInitData };
          query(pagination.value.page, pagination.value.pageSize);
        }
      } else {
        console.log(errors);
        message.error('验证不通过');
      }

      messageReactive.destroy();
    });
  };

  // 重置密码
  const handleResetPassword = async (row: RowData) => {
    resetPwdData.value.userName = row.userName;
    resetPwdData.value.userId = row.userId;

    showResetPwdModal.value = true;
  };

  // 提交重置密码
  const onResetPwd = async () => {
    const res = await resetPassword({
      userId: resetPwdData.value.userId,
      password: resetPwdData.value.password,
    });
    if (res?.code === 0) {
      showResetPwdModal.value = false;
      message.success(`重置密码成功`);
    }
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
        <n-form-item-gi :span="6" label="用户名称" path="userName">
          <n-input v-model:value="queryFormData.userName" placeholder="请输入用户名称" />
        </n-form-item-gi>
        <n-form-item-gi :span="6" label="用户昵称" path="userName">
          <n-input v-model:value="queryFormData.nickName" placeholder="请输入用户昵称" />
        </n-form-item-gi>
        <n-form-item-gi :span="6" label="电话" path="userCode">
          <n-input v-model:value="queryFormData.phone" placeholder="请输入电话" />
        </n-form-item-gi>
        <n-form-item-gi :span="6" label="状态" path="status">
          <n-select v-model:value="queryFormData.status" :options="statusOptions" />
        </n-form-item-gi>
        <n-form-item-gi :span="6">
          <n-space>
            <n-button @click="clearQuery">重置</n-button>
            <n-button v-permission="['system_user_query']" type="primary" @click="handleQuery">
              查询
            </n-button>
          </n-space>
        </n-form-item-gi>
      </n-grid>
    </n-form>
  </n-card>
  <n-card :bordered="false" class="mt-4">
    <div class="table-toolbar">
      <!--顶部左侧区域-->
      <div class="flex items-center table-toolbar-left">
        <n-button v-permission="['system_user_add']" type="primary" @click="handleAdd">
          <template #icon>
            <n-icon>
              <PlusOutlined />
            </n-icon>
          </template>
          添加用户
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
        :pagination="pagination"
        :row-key="rowKey"
        @update:checked-row-keys="handleCheck"
        @update:page="handlePageChange"
      />
    </div>
  </n-card>

  <!-- 新增修改用户 -->
  <n-drawer v-model:show="showDrawer" :width="399">
    <n-drawer-content :title="drawerTitle" closable>
      <n-form
        ref="drawerFormRef"
        label-placement="left"
        label-width="auto"
        :model="drawerFormData"
        :rules="drawerRules"
      >
        <n-form-item label="用户名称" path="userName">
          <n-input v-model:value="drawerFormData.userName" placeholder="输入用户名称" />
        </n-form-item>
        <n-form-item v-if="!drawerFormData.userId" label="密码" path="password">
          <n-input
            v-model:value="drawerFormData.password"
            type="password"
            show-password-on="click"
            placeholder="请输入密码"
          ></n-input>
        </n-form-item>
        <n-form-item label="用户昵称" path="nickName">
          <n-input v-model:value="drawerFormData.nickName" placeholder="输入用户昵称" />
        </n-form-item>
        <n-form-item label="email" path="email">
          <n-input v-model:value="drawerFormData.email" placeholder="输入email" />
        </n-form-item>
        <n-form-item label="电话" path="phone">
          <n-input v-model:value="drawerFormData.phone" placeholder="输入电话" />
        </n-form-item>
        <n-form-item label="性别" path="sex">
          <n-radio-group v-model:value="drawerFormData.sex">
            <n-space>
              <n-radio v-for="item in sexOptions" :key="item.value" :value="item.value">
                {{ item.label }}
              </n-radio>
            </n-space>
          </n-radio-group>
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
            placeholder="请输入用户描述"
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

  <!-- 重置密码对话框 -->
  <n-modal v-model:show="showResetPwdModal" :show-icon="false" preset="dialog" title="重置密码">
    <div>
      <div class="flex mb-3">请输入"{{ resetPwdData.userName }}"的新密码</div>
      <n-input
        v-model="resetPwdData.password"
        class="flex mb-3"
        placeholder="请输入密码"
        type="password"
      />
      <n-button type="primary" @click="onResetPwd">提交</n-button>
    </div>
  </n-modal>
</template>
