<script lang="ts" setup>
  import { onMounted, reactive, ref } from 'vue';
  import { useRoute, useRouter } from 'vue-router';
  import { useUserStore } from '@/store/modules/user';
  import { useMessage } from 'naive-ui';
  import { PersonOutline, LockClosedOutline, ShieldOutline } from '@vicons/ionicons5';
  import { PageEnum } from '@/constants/page';
  import { ResultEnum } from '@/constants';
  import { LoginParams } from '@/models/user';
  import { getCaptche } from '@/api/system/user';

  const formRef = ref();
  const message = useMessage();
  const loading = ref(false);
  const autoLogin = ref(true);
  const captchaUrl = ref('');
  const LOGIN_NAME = PageEnum.BASE_LOGIN_NAME;

  const formInline = reactive({
    username: 'admin',
    password: '123456',
    captcha: '',
  });

  const rules = {
    username: { required: true, message: '请输入用户名', trigger: 'blur' },
    password: { required: true, message: '请输入密码', trigger: 'blur' },
    captcha: [{ required: true, message: '请输入验证码', trigger: 'blur' }],
  };

  const userStore = useUserStore();

  const router = useRouter();
  const route = useRoute();

  // 刷新验证码
  const refreshCaptcha = async () => {
    const res = await getCaptche();
    if (res && res.code === 0) {
      captchaUrl.value = `data:image/svg+xml;base64,${res.data}`;
    }
  };

  onMounted(() => {
    refreshCaptcha();
  });

  const handleSubmit = () => {
    formRef.value.validate(async (errors: any) => {
      if (!errors) {
        const { username, password, captcha } = formInline;
        message.loading('登录中...');
        loading.value = true;

        const params: LoginParams = {
          username,
          password,
          captcha,
        };

        try {
          const res = await userStore.login(params);
          message.destroyAll();

          if (res?.code == ResultEnum.SUCCESS) {
            const toPath = decodeURIComponent((route.query?.redirect || '/') as string);
            message.success('登录成功，即将进入系统');
            if (route.name === LOGIN_NAME) {
              router.replace('/');
            } else router.replace(toPath);
          }
        } finally {
          loading.value = false;
        }
      } else {
        message.error('请填写完整信息，并且进行验证码校验');
      }
    });
  };
</script>

<template>
  <div
    class="flex flex-col h-screen overflow-auto bg-cover bg-no-repeat bg-[url('@/assets/images/login_bg.png')] place-items-center justify-center"
  >
    <div class="absolute flex-grow max-w-md px-5 mx-auto bg-white rounded-lg shadowlg">
      <div class="pt-2 pb-5 text-center">
        <div>
          <img src="@/assets/images/full-logo.png" alt="" />
        </div>
        <div class="text-sm text-sky-300">你好，lingmengcan ai解决方案, 欢迎使用</div>
      </div>
      <div>
        <n-form
          ref="formRef"
          label-placement="left"
          size="large"
          :model="formInline"
          :rules="rules"
        >
          <n-form-item path="username">
            <n-input v-model:value="formInline.username" placeholder="请输入用户名">
              <template #prefix>
                <n-icon size="18" color="#808695">
                  <PersonOutline />
                </n-icon>
              </template>
            </n-input>
          </n-form-item>
          <n-form-item path="password">
            <n-input
              v-model:value="formInline.password"
              type="password"
              show-password-on="click"
              placeholder="请输入密码"
            >
              <template #prefix>
                <n-icon size="18" color="#808695">
                  <LockClosedOutline />
                </n-icon>
              </template>
            </n-input>
          </n-form-item>
          <n-form-item path="captcha">
            <n-input v-model:value="formInline.captcha" placeholder="请输入验证码">
              <template #prefix>
                <n-icon size="18" color="#808695">
                  <ShieldOutline />
                </n-icon>
              </template>
            </n-input>
            <img :src="captchaUrl" @click="refreshCaptcha" />
          </n-form-item>
          <n-form-item>
            <div class="flex justify-between">
              <div class="flex-initial">
                <n-checkbox v-model:checked="autoLogin">自动登录</n-checkbox>
              </div>
              <div class="flex-initial order-last">
                <a href="javascript:">忘记密码</a>
              </div>
            </div>
          </n-form-item>
          <n-form-item>
            <n-button type="primary" size="large" :loading="loading" block @click="handleSubmit">
              登录
            </n-button>
          </n-form-item>
        </n-form>
      </div>
    </div>
  </div>
</template>
