<script lang="ts" setup>
  import { PropType, computed } from 'vue';
  import { useUserStore } from '@/store/modules/user';
  import defaultAvatar from '@/assets/images/avatar.jpg';
  import logo from '@/assets/images/logo.png';

  const props = defineProps({
    inversion: {
      type: [Boolean, undefined] as PropType<boolean | undefined>,
      required: true,
    },
  });

  const userStore = useUserStore();

  const avatar = computed(() => {
    const avatar = props.inversion ? userStore.userInfo.avatar : logo;

    return avatar || defaultAvatar;
  });
</script>

<template>
  <n-avatar :src="avatar" />
</template>
