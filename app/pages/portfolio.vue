<script setup lang="ts">
import { ref, computed } from 'vue'
const { data: page } = await useAsyncData('index', () => queryCollection('index').first())



// Portfolio data
const portfolioItems = [
  { id: 1, image: '/imagePoster/1.png' },
  { id: 3, image: '/imagePoster/3.png' },
  { id: 4, image: '/imagePoster/4.png' },
  { id: 5, image: '/imagePoster/5.png' },
  { id: 6, image: '/imagePoster/6.png' },
  { id: 7, image: '/imagePoster/7.png' },
  { id: 9, image: '/imagePoster/9.png' },
  { id: 10, image: '/imagePoster/10.png' },
  { id: 11, image: '/imagePoster/11.png' },
  { id: 12, image: '/imagePoster/12.png' },
    { id: 13, image: '/imagePoster/13.png' },
    { id: 14, image: '/imagePoster/14.png' },
    { id: 15, image: '/imagePoster/15.png' },
    { id: 16, image: '/imagePoster/16.png' },
    { id: 17, image: '/imagePoster/17.png' },
    { id: 18, image: '/imagePoster/18.png' },
    { id: 19, image: '/imagePoster/19.png' },
    { id: 20, image: '/imagePoster/20.png' },
    { id: 21, image: '/imagePoster/21.png' },
    { id: 22, image: '/imagePoster/22.png' },
    { id: 23, image: '/imagePoster/23.png' },
    { id: 24, image: '/imagePoster/24.png' },
    { id: 26, image: '/imagePoster/26.png' },
    { id: 27, image: '/imagePoster/27.png' },
    { id: 28, image: '/imagePoster/28.png' },
    { id: 29, image: '/imagePoster/29.png' },
    { id: 30, image: '/imagePoster/30.png' },
    { id: 31, image: '/imagePoster/31.png' },
    { id: 32, image: '/imagePoster/32.png' }
]

// State
const selectedImage = ref<typeof portfolioItems[0] | null>(null)
const isLightboxOpen = ref(false)
const displayCount = ref(9)
const itemsPerLoad = 6

// Computed
const visibleItems = computed(() => portfolioItems.slice(0, displayCount.value))
const hasMore = computed(() => displayCount.value < portfolioItems.length)

// Methods
const openLightbox = (item: typeof portfolioItems[0]) => {
  selectedImage.value = item
  isLightboxOpen.value = true
}

const closeLightbox = () => {
  isLightboxOpen.value = false
  selectedImage.value = null
}

const loadMore = () => {
  displayCount.value += itemsPerLoad
}

// SEO
useHead({
  title: 'Portfolio — Rainbow Retouch',
  meta: [
    { name: 'description', content: 'Explore our portfolio of creative design work including branding, web design, app design, and more.' }
  ]
})
</script>

<template>
  <div>
    <!-- Hero Section -->
    <UPageHero
      headline="Our Work"
      title="Portfolio"
      description="Explore our latest projects and creative solutions. From brand identity to digital design, we bring ideas to life with precision and artistry."
      orientation="horizontal"
    />

    <div class="py-12 px-4 sm:px-6 lg:px-16">
      <!-- Portfolio Grid -->
      <UPageGrid class="gap-6">
        <div
          v-for="(item, index) in visibleItems"
          :key="item.id"
          v-motion
          :initial="{ opacity: 0, y: 50 }"
          :visible="{ opacity: 1, y: 0 }"
          :delay="index * 50"
          class="group cursor-pointer overflow-hidden rounded-lg hover:shadow-xl transition-all duration-300"
          @click="openLightbox(item)"
        >
          <div class="overflow-hidden relative">
            <img
              :src="item.image"
              :alt="`Portfolio image ${item.id}`"
              class="w-full h-auto object-contain group-hover:scale-110 transition-transform duration-500"
            />
          </div>
        </div>
      </UPageGrid>

      <!-- Load More Button -->
      <div v-if="hasMore" class="flex justify-center mt-12">
        <UButton
          label="Load More"
          size="lg"
          color="neutral"
          @click="loadMore"
        />
      </div>
    </div>

    <!-- Lightbox Modal -->
    <UModal v-model:open="isLightboxOpen" :close="true" :ui="{ content: 'max-w-7xl' }">
      <template #content>
        <div v-if="selectedImage" class="p-4">
          <img
            :src="selectedImage.image"
            :alt="`Portfolio image ${selectedImage.id}`"
            class="w-full h-auto rounded-lg"
          />
        </div>
      </template>
    </UModal>


    <UPageCTA
      v-bind="page.cta"
      variant="subtle"
      class="overflow-hidden"
    >
      <LazyStarsBg />
    </UPageCTA>
  </div>
</template>
