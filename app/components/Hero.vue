<template>
  <div class="relative h-[90vh] w-full overflow-hidden">
    <UCarousel
      ref="carousel"
      v-slot="{ item }"
      :items="slides"
      :autoplay="{ delay: 5000 }"
      loop
      fade
      arrows
      dots
      :ui="{
        root: 'h-full',
        viewport: 'h-full',
        container: 'h-full',
        item: 'h-full',
        arrows: 'px-8',
        prev: '!start-8 !top-1/2 -translate-y-1/2 backdrop-blur-sm bg-black/30 hover:bg-black/50 text-white border-0',
        next: '!end-8 !top-1/2 -translate-y-1/2 backdrop-blur-sm bg-black/30 hover:bg-black/50 text-white border-0',
        dots: '!bottom-12 z-20',
        dot: 'w-12 h-1.5 bg-white/50 hover:bg-white/80 data-[state=active]:bg-white transition-all duration-300'
      }"
      class="h-full"
      @select="onSlideChange"
    >
      <!-- Image Background -->
      <div class="relative h-full w-full">
        <img 
          :src="item.image" 
          :alt="item.title"
          class="absolute inset-0 h-full w-full object-contain"
        />
        
        <!-- Gradient Overlay -->
        <!-- <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-black/60 to-transparent" /> -->
        
        <!-- Content (bottom-left) -->
        <div class="absolute inset-0 flex items-end">
          <div class="container mx-auto px-4 sm:px-6 lg:px-8 pb-40">
            <div class="max-w-2xl text-left">
              <!-- Animated Title -->
              <h1 
                :key="`title-${activeIndex}`"
                class="text-4xl sm:text-5xl lg:text-6xl font-bold mb-4 animate-fade-in-up"
              >
                {{ item.title }}
              </h1>
              
              <!-- Animated Description -->
              <p 
                :key="`desc-${activeIndex}`"
                class="text-base sm:text-lg lg:text-xl mb-6 animate-fade-in-up animation-delay-200"
              >
                {{ item.description }}
              </p>
              
              <!-- Call to Action Button (optional) -->
              <div 
                :key="`cta-${activeIndex}`"
                class="animate-fade-in-up animation-delay-400"
              >
                <UButton 
                  v-if="item.buttonText"
                  :to="item.buttonLink"
                  size="xl"
                  color="primary"
                  variant="solid"
                  class="shadow-2xl"
                >
                  {{ item.buttonText }}
                </UButton>
              </div>
            </div>
          </div>
        </div>
      </div>
    </UCarousel>
  </div>
</template>

<script setup lang="ts">
const carousel = useTemplateRef('carousel')
const activeIndex = ref(0)

// Define your slides with images, titles, and descriptions
const slides = [
  {
    image: '/imagePoster/12.png',
    title: 'Explore the Mountains',
    description: 'Discover breathtaking views and unforgettable adventures in nature\'s paradise',
    buttonText: 'Start Exploring',
    buttonLink: '/explore'
  },
  {
    image: '/imagePoster/13.png',
    title: 'Find Your Peace',
    description: 'Experience tranquility and serenity in the most beautiful landscapes',
    buttonText: 'Learn More',
    buttonLink: '/about'
  },
  {
    image: '/imagePoster/14.png',
    title: 'Adventure Awaits',
    description: 'Embark on a journey that will change your perspective forever',
    buttonText: 'Get Started',
    buttonLink: '/start'
  },
  {
    image: '/imagePoster/15.png',
    title: 'Capture the Moment',
    description: 'Every sunset brings the promise of a new dawn and endless possibilities',
    buttonText: 'View Gallery',
    buttonLink: '/gallery'
  }
]

function onSlideChange(index: number) {
  activeIndex.value = index
}
</script>

<style scoped>
/* Fade in up animation */
@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.animate-fade-in-up {
  animation: fadeInUp 0.8s ease-out forwards;
}

.animation-delay-200 {
  animation-delay: 0.2s;
  opacity: 0;
}

.animation-delay-400 {
  animation-delay: 0.4s;
  opacity: 0;
}
</style>
