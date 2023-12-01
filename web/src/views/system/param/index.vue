<template>
  <div class="flex flex-col flex-auto overflow-y-auto"></div>
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
