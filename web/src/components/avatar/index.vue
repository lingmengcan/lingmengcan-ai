<script lang="ts" setup>
  import { computed } from 'vue';
  import { useUserStore } from '@/store/modules/user';
  import defaultAvatar from '@/assets/images/avatar.jpg';
  import logo from '@/assets/images/logo.png';

  const props = defineProps({
    inversion: {
      type: Boolean,
      required: true,
    },
  });

  const userStore = useUserStore();

  const avatar = computed(() => (props.inversion ? userStore.userInfo.avatar : logo));
</script>

<template>
  <n-avatar
    :src="avatar && avatar?.length > 0 ? avatar : defaultAvatar"
    :fallback-src="defaultAvatar"
  />
</template>
