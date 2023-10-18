import { NIcon } from 'naive-ui';
import { h } from 'vue';

/**
 * render 图标
 * */
export function renderIcon(icon) {
  return () => h(NIcon, null, { default: () => h(icon) });
}
