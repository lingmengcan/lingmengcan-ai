<template>
  <n-card :bordered="false">
    <n-form ref="formRef" inline label-placement="left" label-width="auto" :model="queryFormData">
      <n-form-item label="角色名称" path="roleName">
        <n-input v-model:value="queryFormData.roleName" placeholder="请输入角色名称" />
      </n-form-item>
      <n-form-item label="角色编码" path="roleCode">
        <n-input v-model:value="queryFormData.roleCode" placeholder="请输入角色编码" />
      </n-form-item>
      <n-form-item label="状态" path="status">
        <n-select
          v-model:value="queryFormData.status"
          :options="statusOptions"
          placeholder="请选择角色状态"
        />
      </n-form-item>
      <n-form-item>
        <n-button attr-type="button" @click="handleQuery"> 查询 </n-button>
      </n-form-item>
    </n-form>
  </n-card>
  <n-card :bordered="false" class="mt-4">
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
  </n-card>
</template>

<script lang="ts" setup>
  import { getRoleList } from '@/api/system/role';
  import { Role, RoleParams } from '@/models/role';
  import { DataTableRowKey, FormInst } from 'naive-ui';
  import { RowData } from 'naive-ui/es/data-table/src/interface';
  import { onMounted, ref } from 'vue';
  const formRef = ref<FormInst | null>(null);

  // 条件
  const statusOptions = ref([
    { label: '正常', value: '0' },
    { label: '停用', value: '1' },
  ]);

  const queryFormData = ref({
    roleName: '',
    roleCode: '',
    status: '0',
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
      ellipsis: {
        tooltip: true,
      },
    },
    {
      key: 'roleCode',
      title: '角色编码',
    },
    {
      key: 'sort',
      title: '排序',
    },
    {
      key: 'status',
      title: '状态',
    },
    {
      key: 'createdAt',
      title: '创建时间',
      ellipsis: {
        tooltip: true,
      },
    },
    {
      key: 'operation',
      title: '操作',
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
      console.log(requestData);
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

  const handleQuery = () => {
    query(pagination.value.page, pagination.value.pageSize);
  };

  const handlePageChange = (currentPage: number) => {
    query(currentPage, pagination.value.pageSize);
  };

  const handleCheck = (rowKeys: DataTableRowKey[]) => {
    checkedRowKeysRef.value = rowKeys;
  };

  onMounted(() => {
    query(pagination.value.page, pagination.value.pageSize);
  });
</script>
@/api/system/role
