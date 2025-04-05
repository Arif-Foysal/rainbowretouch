<script setup>
  import 'player.style/tailwind-audio';
</script>

<template>
  <media-theme-tailwind-audio>
    <video
      slot="media"
      src="https://stream.mux.com/fXNzVtmtWuyz00xnSrJg4OJH6PyNo6D02UzmgeKGkP5YQ/low.mp4"
      playsinline
      crossorigin
    ></video>
  </media-theme-tailwind-audio>
</template>