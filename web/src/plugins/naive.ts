import type { App } from 'vue';
import {
  create,
  NMessageProvider,
  NDialogProvider,
  NConfigProvider,
  NInput,
  NButton,
  NForm,
  NFormItem,
  NFormItemGi,
  NCheckboxGroup,
  NCheckbox,
  NIcon,
  NLayout,
  NLayoutHeader,
  NLayoutContent,
  NLayoutFooter,
  NLayoutSider,
  NMenu,
  NBreadcrumb,
  NBreadcrumbItem,
  NDropdown,
  NSpace,
  NTooltip,
  NAvatar,
  NTabs,
  NTabPane,
  NCard,
  NSwitch,
  NAlert,
  NModal,
  NDrawer,
  NDrawerContent,
  NElement,
  NTag,
  NNotificationProvider,
  NProgress,
  NDatePicker,
  NGrid,
  NGridItem,
  NList,
  NListItem,
  NDataTable,
  NPagination,
  NSelect,
  NRadioGroup,
  NRadio,
  NInputGroup,
  NTable,
  NInputNumber,
  NLoadingBarProvider,
  NUpload,
  NTree,
  NTreeSelect,
  NSpin,
  NTimePicker,
  NBackTop,
  NSkeleton,
  NCascader,
  NEllipsis,
  NScrollbar,
  NPopconfirm,
  NAutoComplete,
  NPopover,
  NSlider,
} from 'naive-ui';

// https://www.naiveui.com/en-US/os-theme/docs/import-on-demand
const naive = create({
  components: [
    NMessageProvider,
    NDialogProvider,
    NConfigProvider,
    NInput,
    NButton,
    NEllipsis,
    NForm,
    NFormItem,
    NFormItemGi,
    NCheckboxGroup,
    NCheckbox,
    NIcon,
    NLayout,
    NLayoutHeader,
    NLayoutContent,
    NLayoutFooter,
    NLayoutSider,
    NMenu,
    NBreadcrumb,
    NBreadcrumbItem,
    NDropdown,
    NSpace,
    NTooltip,
    NAvatar,
    NTabs,
    NTabPane,
    NCard,
    NSwitch,
    NAlert,
    NModal,
    NDrawer,
    NDrawerContent,
    NElement,
    NTag,
    NNotificationProvider,
    NProgress,
    NDatePicker,
    NGrid,
    NGridItem,
    NList,
    NListItem,
    NDataTable,
    NPagination,
    NSelect,
    NRadioGroup,
    NRadio,
    NInputGroup,
    NTable,
    NInputNumber,
    NLoadingBarProvider,
    NUpload,
    NTree,
    NTreeSelect,
    NSpin,
    NTimePicker,
    NBackTop,
    NSkeleton,
    NCascader,
    NScrollbar,
    NPopconfirm,
    NAutoComplete,
    NPopover,
    NSlider,
  ],
});

export function setupNaive(app: App<Element>) {
  app.use(naive);
}
