<template>
  <RouterView v-slot="{ Component, route }">
    <component :is="Component" :key="route.fullPath" />
  </RouterView>
</template>
