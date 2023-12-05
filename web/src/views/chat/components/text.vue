<script lang="ts" setup>
  import { computed, onMounted, onUnmounted, onUpdated, ref } from 'vue';
  import MarkdownIt from 'markdown-it';
  import mdKatex from '@traptitech/markdown-it-katex';
  import mila from 'markdown-it-link-attributes';
  import hljs from 'highlight.js';
  import { copyToClip } from '@/utils';

  interface Props {
    inversion?: boolean;
    error?: boolean;
    text?: string;
    loading?: boolean;
    asRawText?: boolean;
  }

  const props = defineProps<Props>();

  const textRef = ref<HTMLElement>();

  const mdi = new MarkdownIt({
    html: false,
    linkify: true,
    highlight(code, language) {
      const validLang = !!(language && hljs.getLanguage(language));
      if (validLang) {
        const lang = language ?? '';
        return highlightBlock(hljs.highlight(code, { language: lang }).value, lang);
      }
      return highlightBlock(hljs.highlightAuto(code).value, '');
    },
  });

  mdi.use(mila, { attrs: { target: '_blank', rel: 'noopener' } });
  mdi.use(mdKatex, { blockClass: 'katexmath-block rounded-md p-[10px]', errorColor: ' #cc0000' });

  const text = computed(() => {
    const value = props.text ?? '';
    if (!props.asRawText) return mdi.render(value);
    return value;
  });

  function highlightBlock(str: string, lang?: string) {
    return `<pre class="p-0 mb-0"><div class="text-[16px]"><div class="flex items-center justify-between py-1.5 px-4"><span class="text-xs text-white lowercase">${lang}</span><button class="code-block-header__copy">复制代码</button></div><pre class="code-block-content"><code class="${lang}">${str}</code></pre></div></pre>`;
  }

  function addCopyEvents() {
    if (textRef.value) {
      const copyBtn = textRef.value.querySelectorAll('.code-block-header__copy');
      copyBtn.forEach((btn) => {
        btn.addEventListener('click', () => {
          const code = btn.parentElement?.nextElementSibling?.textContent;
          if (code) {
            copyToClip(code).then(() => {
              btn.textContent = '复制成功';
              setTimeout(() => {
                btn.textContent = '复制代码';
              }, 1000);
            });
          }
        });
      });
    }
  }

  function removeCopyEvents() {
    if (textRef.value) {
      const copyBtn = textRef.value.querySelectorAll('.code-block-header__copy');
      copyBtn.forEach((btn) => {
        btn.removeEventListener('click', () => {});
      });
    }
  }

  onMounted(() => {
    addCopyEvents();
  });

  onUpdated(() => {
    addCopyEvents();
  });

  onUnmounted(() => {
    removeCopyEvents();
  });
</script>

<template>
  <div ref="textRef" class="flex-1 w-full max-w-full text-sm prose dark:prose-invert md:text-base">
    <!-- eslint-disable-next-line vue/no-v-html -->
    <div v-if="!asRawText" v-html="text"></div>
    <div v-else v-text="text" />

    <span v-if="loading" class="dark:text-white w-[4px] h-[20px] block animate-blink" />
  </div>
</template>

<style lang="less">
  .code-block-content {
    background: rgb(40, 44, 52);
    color: rgb(171, 178, 191);
    text-shadow: rgba(0, 0, 0, 0.3) 0px 1px;
    font-family: 'Fira Code', 'Fira Mono', Menlo, Consolas, 'DejaVu Sans Mono', monospace;
    direction: ltr;
    text-align: left;
    white-space: pre;
    word-spacing: normal;
    word-break: normal;
    line-height: 1.5;
    tab-size: 2;
    hyphens: none;
    padding: 1em;
    margin: 0px !important;
    overflow: auto;
    border-radius: 0.3em;
  }

  .code-block-header__copy {
    @apply flex;
    @apply gap-1;
    @apply items-center;
    @apply rounded;
    @apply bg-none;
    @apply p-1;
    @apply text-xs;
    @apply text-white;
  }
</style>