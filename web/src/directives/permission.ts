import { ObjectDirective } from 'vue';
import { hasPermissionOr } from '@/utils/permission';

export const permission: ObjectDirective = {
  mounted(el: HTMLButtonElement, binding) {
    if (binding.value == undefined) return;
    const { value } = binding;
    if (value && value instanceof Array && value.length > 0) {
      if (!hasPermissionOr(value)) {
        el.parentNode && el.parentNode.removeChild(el);
      }
    }
  },
};
