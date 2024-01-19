<template>
  <div>
    <h1>Streaming Data</h1>
    <div v-for="(chunk, index) in chunks" :key="index">
      {{ chunk }}
    </div>
  </div>
</template>
<script>
  import { ref } from 'vue';
  import axios from 'axios';

  export default {
    setup() {
      const chunks = ref([]);

      const requestBody = {
        message: 'Message',
        temperature: 0.5,
        llm: 'GPT-3.5',
      };

      const url = 'http://localhost:9999/chat/stream';
      const config = {
        headers: {
          'Content-Type': 'application/json',
        },
        responseType: 'stream',
      };

      fetch(url, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(requestBody),
      })
        .then(async (response) => {
          if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

          const reader = response.body.getReader();
          try {
            while (true) {
              const { done, value } = await reader.read();
              if (done) break;
              chunks.value.push(new TextDecoder().decode(value));
            }
          } catch (error) {
            console.error('Error reading stream:', error);
          } finally {
            reader.releaseLock(); // 确保释放读取器
          }
        })
        .catch((error) => console.error('Fetch error:', error));

      return { chunks };
    },
  };
</script>
