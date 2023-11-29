<template>
  <div>
    <n-select v-model="selectedOption" class="custom-select" :options="options" />
  </div>
  <div
    class="n-base-selection n-base-selection--active n-base-selection--selected n-base-selection--focus"
  >
    <div class="n-base-selection-label" tabindex="0">
      <div class="n-base-selection-input" title="ChatGLM3">
        <div class="n-base-selection-input__content">ChatGLM3</div>
      </div>
      <div class="n-base-loading n-base-suffix" role="img" aria-label="loading">
        <div class="n-base-loading__placeholder">
          <div class="n-base-clear">
            <div class="n-base-clear__placeholder">
              <i class="n-base-icon n-base-suffix__arrow">
                <svg viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <path
                    d="M3.14645 5.64645C3.34171 5.45118 3.65829 5.45118 3.85355 5.64645L8 9.79289L12.1464 5.64645C12.3417 5.45118 12.6583 5.45118 12.8536 5.64645C13.0488 5.84171 13.0488 6.15829 12.8536 6.35355L8.35355 10.8536C8.15829 11.0488 7.84171 11.0488 7.64645 10.8536L3.14645 6.35355C2.95118 6.15829 2.95118 5.84171 3.14645 5.64645Z"
                    fill="currentColor"
                  ></path>
                </svg>
              </i>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="n-base-selection__border"></div>
    <div class="n-base-selection__state-border"></div>
  </div>
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
