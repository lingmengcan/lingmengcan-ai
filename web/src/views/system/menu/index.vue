<template>
  <div>
    <n-form
      ref="drawerFormRef"
      label-placement="left"
      label-width="auto"
      :model="drawerFormData"
      :rules="drawerRules"
    >
      <n-form-item label="角色名称" path="roleName">
        <n-input v-model:value="drawerFormData.roleName" placeholder="输入姓名" />
      </n-form-item>
      <n-form-item label="角色编码" path="roleCode">
        <n-input v-model:value="drawerFormData.roleCode" placeholder="输入年龄" />
      </n-form-item>
      <n-form-item label="电话号码" path="sort">
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
          placeholder="请输入角色描述"
        />
      </n-form-item>
      <n-form-item>
        <n-button type="primary" attr-type="button" @click="handleValidateClick"> 验证 </n-button>
      </n-form-item>
    </n-form>
  </div>
</template>

<script lang="ts" setup>
  import { FormInst, useMessage } from 'naive-ui';
  import { ref } from 'vue';
  const message = useMessage();

  const drawerFormRef = ref<FormInst | null>(null);

  // 状态select options
  const statusOptions = ref([
    { label: '正常', value: 0 },
    { label: '停用', value: 1 },
  ]);

  const handleValidateClick = (e: MouseEvent) => {
    e.preventDefault();
    drawerFormRef.value?.validate((errors) => {
      if (!errors) {
        message.success('Valid');
      } else {
        console.log(errors);
        message.error('Invalid');
      }
    });
  };

  const drawerRules = {
    roleName: {
      required: true,
      message: '请输入角色名称',
      trigger: 'blur',
    },
    roleCode: {
      required: true,
      message: '请输入年龄',
      trigger: 'blur',
    },
    sort: {
      required: true,
      message: '请输入排序',
      trigger: 'blur',
    },
  };

  const drawerFormData = ref({
    roleId: '',
    roleName: '',
    roleCode: '',
    status: 0,
    sort: 0,
    description: '',
  });
</script>
