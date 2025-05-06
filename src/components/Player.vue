<script setup>
  import 'player.style/tailwind-audio';
</script>

<template>
  <media-theme-tailwind-audio>
    <video
      slot="media"
      src="/audio.mp3"
      playsinline
      crossorigin
    ></video>
  </media-theme-tailwind-audio>
</template>