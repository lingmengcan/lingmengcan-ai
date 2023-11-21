import { NIcon } from 'naive-ui';
import { Component, h } from 'vue';
import * as Icons from '@vicons/ionicons5';

/**
 * render 图标
 * */
export function renderIcon(icon: Component, size = 20) {
  return () => h(NIcon, { size }, { default: () => h(icon) });
}

/**
 * render 图标
 * */
export function renderIonicons5(icon: string, size = 20) {
  // 按需导入图标组件

  if (Icons[icon]) {
    return renderIcon(Icons[icon], size);
  } else {
    console.error(`Icon "${icon}" not found in @vicons/ionicons5`);
    return '';
  }
}
