import './styles/tailwind.css';

import { createApp } from 'vue';
import { setupNaive } from '@/plugins';
import { createPinia } from 'pinia';

import App from './App.vue';
import router from './router';

const app = createApp(App);

// 注册全局常用的 naive-ui 组件
setupNaive(app);

app.use(createPinia());
app.use(router);

app.mount('#app');
