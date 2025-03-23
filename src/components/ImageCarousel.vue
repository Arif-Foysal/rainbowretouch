<script setup>
import { ref, onMounted, onUnmounted } from 'vue';
import sampleImage1 from '@/assets/images/image-4.jpg';
import sampleImage2 from '@/assets/images/image-5.jpg';
// Sample data - replace with your own images and content
const slides = [
  {
    image: sampleImage1,
    alt: 'Beautiful mountain landscape with a lake',
    title: 'Mountain Retreat',
    description: 'Discover the beauty of nature in this serene landscape'
  },
  {
    image: sampleImage2,
    alt: 'Sunset over the ocean',
    title: 'Ocean Sunset',
    description: 'Watch the sun set over the calm waters'
  },
  {
    image: sampleImage1,
    alt: 'Foggy forest with tall trees',
    title: 'Mystic Forest',
    description: 'Explore the mysteries hidden in the ancient woods'
  },
  {
    image: sampleImage2,
    alt: 'Autumn forest with colorful leaves',
    title: 'Autumn Colors',
    description: 'Experience the vibrant colors of fall'
  }
];

// State
const currentSlide = ref(0);
const autoSlideInterval = ref(null);
const touchStartX = ref(0);
const touchEndX = ref(0);

// Methods
const nextSlide = () => {
  currentSlide.value = (currentSlide.value + 1) % slides.length;
};

const prevSlide = () => {
  currentSlide.value = (currentSlide.value - 1 + slides.length) % slides.length;
};

const goToSlide = (index) => {
  currentSlide.value = index;
};

const startAutoSlide = () => {
  autoSlideInterval.value = setInterval(() => {
    nextSlide();
  }, 5000); // Change slide every 5 seconds
};

const pauseAutoSlide = () => {
  if (autoSlideInterval.value) {
    clearInterval(autoSlideInterval.value);
    autoSlideInterval.value = null;
  }
};

const resumeAutoSlide = () => {
  if (!autoSlideInterval.value) {
    startAutoSlide();
  }
};

// Touch events for mobile swipe
const handleTouchStart = (e) => {
  touchStartX.value = e.changedTouches[0].screenX;
};

const handleTouchEnd = (e) => {
  touchEndX.value = e.changedTouches[0].screenX;
  handleSwipe();
};

const handleSwipe = () => {
  // Minimum swipe distance (in pixels)
  const minSwipeDistance = 50;
  
  const distance = touchEndX.value - touchStartX.value;
  
  if (Math.abs(distance) > minSwipeDistance) {
    if (distance > 0) {
      // Swiped right, go to previous slide
      prevSlide();
    } else {
      // Swiped left, go to next slide
      nextSlide();
    }
  }
};

// Lifecycle hooks
onMounted(() => {
  startAutoSlide();
});

onUnmounted(() => {
  pauseAutoSlide();
});
</script>

<template>
    <div class="relative w-full max-w-4xl mx-auto overflow-hidden rounded-lg shadow-lg">
      <!-- Carousel container -->
      <div 
        class="relative h-64 md:h-96"
        @mouseenter="pauseAutoSlide"
        @mouseleave="resumeAutoSlide"
        @touchstart="handleTouchStart"
        @touchend="handleTouchEnd"
      >
        <!-- Slides -->
        <div 
          v-for="(slide, index) in slides" 
          :key="index"
          class="absolute top-0 left-0 w-full h-full transition-opacity duration-500 ease-in-out"
          :class="{ 'opacity-100': currentSlide === index, 'opacity-0': currentSlide !== index }"
        >
          <img 
            :src="slide.image" 
            :alt="slide.alt" 
            class="object-cover w-full h-full"
          />
          <div class="absolute bottom-0 left-0 right-0 p-4 bg-gradient-to-t from-black/70 to-transparent text-white">
            <h3 class="text-xl font-bold">{{ slide.title }}</h3>
            <p class="text-sm">{{ slide.description }}</p>
          </div>
        </div>
  
        <!-- Navigation buttons -->
        <button 
          @click="prevSlide" 
          class="absolute left-2 top-1/2 -translate-y-1/2 bg-white/30 hover:bg-white/50 text-white rounded-full p-2 backdrop-blur-sm transition-all"
          aria-label="Previous slide"
        >
          <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="15 18 9 12 15 6"></polyline>
          </svg>
        </button>
        <button 
          @click="nextSlide" 
          class="absolute right-2 top-1/2 -translate-y-1/2 bg-white/30 hover:bg-white/50 text-white rounded-full p-2 backdrop-blur-sm transition-all"
          aria-label="Next slide"
        >
          <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="9 18 15 12 9 6"></polyline>
          </svg>
        </button>
  
        <!-- Indicators -->
        <div class="absolute bottom-4 left-0 right-0 flex justify-center space-x-2">
          <button 
            v-for="(_, index) in slides" 
            :key="index"
            @click="goToSlide(index)"
            class="w-3 h-3 rounded-full transition-all duration-300 focus:outline-none"
            :class="currentSlide === index ? 'bg-white scale-110' : 'bg-white/50 hover:bg-white/70'"
            :aria-label="`Go to slide ${index + 1}`"
          ></button>
        </div>
      </div>
    </div>
  </template>
  
 