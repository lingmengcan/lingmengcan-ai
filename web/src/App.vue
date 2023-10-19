<script lang="ts" setup>
  import { computed } from 'vue';
  import { zhCN, dateZhCN } from 'naive-ui';
  import { lighten } from '@/utils/common';
  import { NDialogProvider, NNotificationProvider, NMessageProvider } from 'naive-ui';

  /**
   * @type import('naive-ui').GlobalThemeOverrides
   */
  const getThemeOverrides = computed(() => {
    const appTheme = '#2d8cf0';
    const lightenStr = lighten(appTheme, 6);
    return {
      common: {
        primaryColor: appTheme,
        primaryColorHover: lightenStr,
        primaryColorPressed: lightenStr,
        primaryColorSuppl: appTheme,
      },
      LoadingBar: {
        colorLoading: appTheme,
      },
    };
  });

  const getDarkTheme = computed(() => undefined);
</script>

<template>
  <NConfigProvider
    :locale="zhCN"
    :theme="getDarkTheme"
    :theme-overrides="getThemeOverrides"
    :date-locale="dateZhCN"
  >
    <n-dialog-provider>
      <n-notification-provider>
        <n-message-provider>
          <slot name="default"><RouterView /></slot>
        </n-message-provider>
      </n-notification-provider>
    </n-dialog-provider>
  </NConfigProvider>
</template>

<style lang="less">
  @import 'styles/index.less';
</style>
