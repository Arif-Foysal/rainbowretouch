<script setup>
import 'vue3-carousel/carousel.css'
import { Carousel, Slide, Pagination, Navigation } from 'vue3-carousel'
import { ref, onMounted, onBeforeUnmount } from 'vue'

// Import images from assets
import image1 from '@/assets/images/image-4.jpg'
import image2 from '@/assets/images/image-5.jpg'
import image3 from '@/assets/images/image-4.jpg'
import image4 from '@/assets/images/image-5.jpg'
import image5 from '@/assets/images/image-4.jpg'
import image6 from '@/assets/images/image-5.jpg'
import image7 from '@/assets/images/image-4.jpg'
import image8 from '@/assets/images/image-5.jpg'
import image9 from '@/assets/images/image-4.jpg'
import image10 from '@/assets/images/image-5.jpg'

const carouselConfig = ref({
  itemsToShow: 3.5,
  wrapAround: true,
  gap: 15,
  autoplay: 4000,
  touchDrag: true,
  // mouseDrag: true,
})

const slides = [
  { image: image1, text: 'Overlay Text 1' },
  { image: image2, text: 'Overlay Text 2' },
  { image: image3, text: 'Overlay Text 3' },
  { image: image4, text: 'Overlay Text 4' },
  { image: image5, text: 'Overlay Text 5' },
  { image: image6, text: 'Overlay Text 6' },
  { image: image7, text: 'Overlay Text 7' },
  { image: image8, text: 'Overlay Text 8' },
  { image: image9, text: 'Overlay Text 9' },
  { image: image10, text: 'Overlay Text 10' }
]

const updateItemsToShow = () => {
  const width = window.innerWidth
  if (width < 600) {
    carouselConfig.value.itemsToShow = 1
  } else if (width < 900) {
    carouselConfig.value.itemsToShow = 2
  } else {
    carouselConfig.value.itemsToShow = 3.5
  }
}

onMounted(() => {
  updateItemsToShow()
  window.addEventListener('resize', updateItemsToShow)
})

onBeforeUnmount(() => {
  window.removeEventListener('resize', updateItemsToShow)
})
</script>

<template>
  <div class=" py-8 bg-blue-50 rounded-md">
    <p class="text-red-500 p-4 text-xl font-semibold tracking-wide mb-2">STUNNING QUALITY</p>
    <h1 class="text-5xl p-4 font-bold mb-4">Carousel with Overlay Text

    </h1>

    <Carousel v-bind="carouselConfig">
      <Slide v-for="(slide, index) in slides" :key="index">
        <div class="carousel__item">
          <img :src="slide.image" :alt="'Slide ' + (index + 1)" />
          <div class="overlay">
            <p class="text-2xl font-semibold">{{ slide.text }}</p>
          </div>
        </div>
      </Slide>
      
      <template #addons>
        <br>
        <Pagination />
      </template>
    </Carousel>
    
  </div>

</template>
<style scoped>
.carousel__item {
  position: relative;
}

.carousel__item img {
  width: 100%;
  height: 50vh; /* Make the height responsive */
  object-fit: cover; /* Ensure the image covers the area */
  border-radius: 2%;
}

.overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  color: white;
  display: flex;
  justify-content: center;
  align-items: flex-end; /* Align text to the bottom */
  padding-bottom: 10px; /* Add padding to the bottom */
  opacity: 0;
  transition: opacity 0.3s ease;
  border-radius:  2%; /* Adjust border-radius for bottom corners */
}

.carousel__item:hover .overlay {
  opacity: 1;
  cursor: pointer;
}
</style>
