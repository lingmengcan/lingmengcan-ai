<template>
  <n-upload
    ref="uploadRef"
    v-model:file-list="fileList"
    accept=".png,.jpeg,.jpg"
    action="/api/file/upload-image"
    :max="1"
    :show-file-list="false"
    with-credentials
    :headers="{ Authorization: `Bearer ${token}` }"
    @before-upload="beforeUpload"
    @finish="afterUploaded"
  >
    <div v-if="finishUploaded" class="relative w-full h-48 overflow-hidden border group">
      <div class="flex items-center justify-center w-full h-full">
        <img :src="imageUrl" class="object-contain max-w-full max-h-full" />
      </div>
      <div
        class="absolute inset-0 flex items-center justify-center text-white transition-opacity duration-300 bg-opacity-0 opacity-0 bg-slate-400 group-hover:bg-opacity-70 group-hover:opacity-100 text-shadow"
      >
        <n-icon size="48" :depth="3" class="cursor-pointer" @click="removeImage">
          <CloseCircleOutline />
        </n-icon>
      </div>
    </div>

    <n-upload-dragger v-else class="flex flex-col h-48 place-content-center">
      <div class="flex justify-center w-full pb-3">
        <n-icon size="48" :depth="3">
          <ArrowUpCircleOutline />
        </n-icon>
      </div>
      <n-text class="flex justify-center w-full">
        {{ $t('views.draw.stableDiffusion.controlNet.upload') }}
      </n-text>
    </n-upload-dragger>
  </n-upload>
</template>
<script setup lang="ts">
  import { ArrowUpCircleOutline, CloseCircleOutline } from '@vicons/ionicons5';
  import { PropType, ref } from 'vue';
  import storage from '@/utils/storage';
  import { ACCESS_TOKEN } from '@/constants';
  import { useMessage, UploadFileInfo } from 'naive-ui';
  import { fileToBase64 } from '@/utils';

  const props = defineProps({
    base64Image: {
      type: String as PropType<string>,
      default: null,
    },
  });

  const base64ImageRef = ref(props.base64Image);

  const message = useMessage();
  const token = storage.get(ACCESS_TOKEN, '');

  const imageUrl = ref('');
  const finishUploaded = ref(false);
  const fileList = ref<UploadFileInfo[]>([]);

  //上传之前
  function beforeUpload({ file }: { file: UploadFileInfo }) {
    const fileInfo = file.file;

    // 最大2M
    const maxSize = 2 * 1024 * 1024;

    // 设置最大值，则判断
    if (maxSize && fileInfo && fileInfo?.size >= maxSize) {
      message.error(`上传文件最大值不能超过${maxSize / 1024 / 1024}M`);
      return false;
    }

    return true;
  }

  async function afterUploaded({ file, event }: { file: UploadFileInfo; event?: ProgressEvent }) {
    // 定义允许的文件类型数组
    const res = JSON.parse((event?.target as XMLHttpRequest).response);
    if (res?.code === 0) {
      // const filePath = res.data;

      // imageUrl.value = `${import.meta.env.VITE_APP_CDN_BASEURL}${filePath}`;

      base64ImageRef.value = await fileToBase64(file.file as File);
      imageUrl.value = base64ImageRef.value;

      finishUploaded.value = true;
    }
  }

  function removeImage() {
    imageUrl.value = '';
    finishUploaded.value = false;

    // fileList.value.length = 0;

    // 不设置延时会触发上传动作
    setTimeout(() => {
      fileList.value = [];
    }, 1);
  }
</script>
