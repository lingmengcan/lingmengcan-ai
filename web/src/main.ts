import './styles/tailwind.css';

import { createApp } from 'vue';
import { setupNaive } from '@/plugins';

import App from './App.vue';
import router from './router';
import { setupStore } from '@/store';

async function bootstrap() {
  const app = createApp(App);

  // 挂载状态管理
  setupStore(app);

  // 注册全局常用的 naive-ui 组件
  setupNaive(app);

  // 挂载路由
  setupRouter(app);

  // 路由准备就绪后挂载 APP 实例
  // https://router.vuejs.org/api/interfaces/router.html#isready
  await router.isReady();

  app.mount('#app');
}

void bootstrap();
