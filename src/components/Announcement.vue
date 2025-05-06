<script setup>
import { ref, onMounted } from 'vue'

const announcement = ref(null)

onMounted(() => {
  const element = announcement.value
  const textWidth = element.scrollWidth
  const containerWidth = element.clientWidth
  const offset = textWidth - containerWidth
  let currentOffset = 0

  function loop() {
    currentOffset = (currentOffset + 1) % offset
    element.style.transform = `translateX(-${currentOffset}px)`
    requestAnimationFrame(loop)
  }

  loop()
})
</script>
<template>
    <div ref="announcement" class="py-8 bg-green-400 whitespace-nowrap overflow-hidden">
Lorem ipsum dolor sit amet consectetur adipisicing elit. Provident, perferendis? Ea libero exercitationem corporis quia? In nihil minima, recusandae fugiat beatae eos necessitatibus eveniet quos distinctio error modi dolores, quam maxime laboriosam nulla voluptatibus doloremque! Labore esse expedita ipsum magni odio, iure omnis molestiae et nam facere aut sit deserunt sapiente, temporibus dolores quidem, aliquam voluptate fugiat eius deleniti ratione nihil! Facere id officiis magnam ut praesentium commodi soluta consectetur veniam, sint fuga! Architecto quo facilis neque quae quod vero porro esse sequi amet nesciunt? Corrupti minima facilis expedita quam tempore labore reiciendis, unde corporis architecto omnis. Fugit, qui enim!
</div>
</template>