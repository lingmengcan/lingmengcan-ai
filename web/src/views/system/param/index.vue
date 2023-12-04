<template>
  <pre><div class="codeblock relative font-sans text-[16px]"><div class="flex items-center justify-between py-1.5 px-4"><span class="text-xs text-white lowercase">javascript</span><div class="flex items-center"><button class="flex gap-1.5 items-center rounded bg-none p-1 text-xs text-white"><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="tabler-icon tabler-icon-clipboard"><path d="M9 5h-2a2 2 0 0 0 -2 2v12a2 2 0 0 0 2 2h10a2 2 0 0 0 2 -2v-12a2 2 0 0 0 -2 -2h-2"></path><path d="M9 3m0 2a2 2 0 0 1 2 -2h2a2 2 0 0 1 2 2v0a2 2 0 0 1 -2 2h-2a2 2 0 0 1 -2 -2z"></path></svg>复制代码</button><button class="flex items-center p-1 text-xs text-white rounded bg-none"><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="tabler-icon tabler-icon-download"><path d="M4 17v2a2 2 0 0 0 2 2h12a2 2 0 0 0 2 -2v-2"></path><path d="M7 11l5 5l5 -5"></path><path d="M12 4l0 12"></path></svg></button></div></div><pre style="background: rgb(40, 44, 52); color: rgb(171, 178, 191); text-shadow: rgba(0, 0, 0, 0.3) 0px 1px; font-family: &quot;Fira Code&quot;, &quot;Fira Mono&quot;, Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace; direction: ltr; text-align: left; white-space: pre; word-spacing: normal; word-break: normal; line-height: 1.5; tab-size: 2; hyphens: none; padding: 1em; margin: 0px; overflow: auto; border-radius: 0.3em;"><code class="language-javascript" style="background: rgb(40, 44, 52); color: rgb(171, 178, 191); text-shadow: rgba(0, 0, 0, 0.3) 0px 1px; font-family: &quot;Fira Code&quot;, &quot;Fira Mono&quot;, Menlo, Consolas, &quot;DejaVu Sans Mono&quot;, monospace; direction: ltr; text-align: left; white-space: pre; word-spacing: normal; word-break: normal; line-height: 1.5; tab-size: 2; hyphens: none;"><span class="token" style="color: rgb(92, 99, 112); font-style: italic;">// 获取当前日期</span><span>
</span><span></span><span class="token" style="color: rgb(198, 120, 221);">const</span><span> currentDate </span><span class="token" style="color: rgb(97, 175, 239);">=</span><span> </span><span class="token" style="color: rgb(198, 120, 221);">new</span><span> </span><span class="token" style="color: rgb(209, 154, 102);">Date</span><span class="token" style="color: rgb(171, 178, 191);">(</span><span class="token" style="color: rgb(171, 178, 191);">)</span><span class="token" style="color: rgb(171, 178, 191);">;</span><span>
</span>
<span></span><span class="token" style="color: rgb(92, 99, 112); font-style: italic;">// 在控制台中显示当前日期</span><span>
</span><span></span><span class="token console" style="color: rgb(209, 154, 102);">console</span><span class="token" style="color: rgb(171, 178, 191);">.</span><span class="token method property-access" style="color: rgb(97, 175, 239);">log</span><span class="token" style="color: rgb(171, 178, 191);">(</span><span class="token" style="color: rgb(152, 195, 121);">"当前日期为: "</span><span> </span><span class="token" style="color: rgb(97, 175, 239);">+</span><span> currentDate</span><span class="token" style="color: rgb(171, 178, 191);">)</span><span class="token" style="color: rgb(171, 178, 191);">;</span></code></pre></div></pre>
</template>

<script>
  export default {
    name: 'App',
    data() {
      return {
        options: [
          { label: 'Option 1', value: 'option1' },
          { label: 'Option 2', value: 'option2' },
          { label: 'Option 3', value: 'option3' },
        ],
        selectedOption: '',
      };
    },
  };
</script>

<style scoped>
  .custom-select::v-deep .n-base-selection-label {
    height: 40px !important;
    line-height: 40px !important;
  }
</style>
