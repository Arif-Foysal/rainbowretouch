<script setup lang="ts">
const items = [
  '/imagePoster/1.png',
  // '/imagePoster/2.png',
  '/imagePoster/3.png',
  '/imagePoster/4.png',
  '/imagePoster/5.png',
  '/imagePoster/6.png',
  '/imagePoster/7.png',
  // '/imagePoster/8.png',
  // '/imagePoster/9.png',
  '/imagePoster/10.png',
  '/imagePoster/11.png'
]
</script>

<template>
  <UCarousel
    v-slot="{ item }"
    loop
    arrows
    dots
    :autoplay="{ delay: 2000 }"
    :items="items"
    :ui="{ item: 'basis-1/2 md:basis-1/3' }"
  >
    <img :src="item" width="600" height="600" class="rounded-lg">
  </UCarousel>
</template>
