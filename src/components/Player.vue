<script setup>
  import { ref } from 'vue';
  import 'player.style/tailwind-audio';

  const isVisible = ref(true);

  const closePlayer = () => {
    isVisible.value = false;
  };
</script>

<template>
  <div v-if="isVisible" class="relative flex ">
    <media-theme-tailwind-audio class="relative">
      <video
      slot="media"
      src="/audio.mp3"
      playsinline
      crossorigin
      ></video>
    </media-theme-tailwind-audio>
    <button 
      @click="closePlayer"
      class="p-2  bg-red-500 hover:bg-red-600 text-gray-800 transition-colors shadow-lg border-2 border-white"
      aria-label="Close player"
      style="z-index: 9999;"
    >
      ✕
    </button>
  </div>
</template>