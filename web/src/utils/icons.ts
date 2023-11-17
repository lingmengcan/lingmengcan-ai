import { NIcon } from 'naive-ui';
import { Component, h } from 'vue';

/**
 * render 图标
 * */
export function renderIcon(icon: Component) {
  return () => h(NIcon, null, { default: () => h(icon) });
}

/**
 * render 图标
 * */
export function renderIconName(icon: string) {
  // 按需导入图标组件
  const icons = import('@vicons/antd');
  return icons[icon];
}
