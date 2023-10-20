import { lighten } from '@/utils';
import * as NaiveUI from 'naive-ui';
import { computed } from 'vue';

/**
 * 挂载 Naive-ui 脱离上下文的 API
 * 如果你想在 setup 外使用 useDialog、useMessage、useNotification、useLoadingBar，可以通过 createDiscreteApi 来构建对应的 API。
 * https://www.naiveui.com/zh-CN/dark/components/discrete
 */

export function setupNaiveDiscreteApi() {
  const appTheme = '#2d8cf0';
  const configProviderPropsRef = computed(() => ({
    theme: undefined, //NaiveUI.darkTheme,
    themeOverrides: {
      common: {
        primaryColor: appTheme,
        primaryColorHover: lighten(appTheme, 6),
        primaryColorPressed: lighten(appTheme, 6),
      },
      LoadingBar: {
        colorLoading: appTheme,
      },
    },
  }));
  const { message, dialog, notification, loadingBar } = NaiveUI.createDiscreteApi(
    ['message', 'dialog', 'notification', 'loadingBar'],
    {
      configProviderProps: configProviderPropsRef,
    },
  );

  window['$message'] = message;
  window['$dialog'] = dialog;
  window['$notification'] = notification;
  window['$loading'] = loadingBar;
}
