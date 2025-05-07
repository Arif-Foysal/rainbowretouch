<script setup>
import MarqueeText from 'vue-marquee-text-component'

</script>

<template>
  <MarqueeText 
    :duration="30" 
    class="text-xl font-bold text-white bg-gray-800 p-2 rounded shadow-sm"
    :paused="false"
  >
    🚨 Big Sale Alert! Up to 50% OFF on all items! 🛍️ Hurry, limited time only! 🚀 Don't miss out on this amazing opportunity to grab your favorite products at unbeatable prices. Shop now and save big before it's too late! 🎉
  </MarqueeText>
</template>
