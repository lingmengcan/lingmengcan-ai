import { useLocalStorage, usePreferredLanguages } from '@vueuse/core';
import { DropdownOption } from 'naive-ui';
import { computed } from 'vue';
import { createI18n, useI18n } from 'vue-i18n';
import { enUS, zhCN } from 'naive-ui';

// 导入语言文件
const langModules = import.meta.glob('./lang/*/index.ts', { eager: true }) as Record<string, { default: any }>;

// 存储语言模块和语言代码
const langModuleMap = new Map<string, Object>();
export const langCode: Array<string> = [];
export const localeConfigKey = 'lingmengcan-ai-locale';

// 获取浏览器默认语言环境
const languages = usePreferredLanguages();

// 生成语言模块列表
const generateLangModuleMap = () => {
  Object.keys(langModules).forEach((fullPath) => {
    const code = fullPath.replace('./lang/', '').split('/')[0];
    langCode.push(code);
    langModuleMap.set(code, langModules[fullPath]);
  });
};

// 导出 Message
const importMessages = computed(() => {
  generateLangModuleMap();

  const message: Recordable = {};
  langModuleMap.forEach((value: any, key) => {
    message[key] = value.default;
  });
  return message;
});

// 创建 i18n 实例
export const i18n = createI18n({
  legacy: false,
  locale: useLocalStorage(localeConfigKey, 'zh-CN').value || languages.value[0] || 'zh-CN',
  fallbackLocale: 'zh-CN',
  messages: importMessages.value,
  globalInjection: true,
});

// 拉取目前有的语言
export const langList = computed(() => {
  if (langModuleMap.size === 0) generateLangModuleMap();

  const list: DropdownOption[] = [];
  langModuleMap.forEach((value: any, key) => {
    list.push({
      label: value.default.lang,
      key,
    });
  });

  return list;
});

export function useLocale() {
  const { locale } = useI18n({ useScope: 'global' });
  function changeLocale(lang: string) {
    // 如果切换的语言不在对应语言文件里则默认为简体中文
    if (!langCode.includes(lang)) {
      lang = 'zh-CN';
    }

    locale.value = lang;
    useLocalStorage(localeConfigKey, 'zh-CN').value = lang;
  }

  const getComponentsLocale = computed(() => {
    switch (locale.value) {
      case 'en-US':
        return enUS;
      case 'zh-CN':
        return zhCN;
      default:
        return zhCN;
    }
  });

  return {
    changeLocale,
    getComponentsLocale,
    locale,
  };
}

export default i18n;
