<script setup lang="ts">
const [{ data: settings }, { data: items }] = await Promise.all([
  useSiteSettings(),
  usePortfolioItems()
])

const cta = computed(() => settings.value?.cta || {})
const ctaLinks = computed(() => {
  const links: any[] = []
  if (cta.value.primary_label) links.push({ label: cta.value.primary_label, to: cta.value.primary_link || '/contact', trailingIcon: 'i-lucide-arrow-right' })
  if (cta.value.secondary_label) links.push({ label: cta.value.secondary_label, to: cta.value.secondary_link || '/portfolio', variant: 'subtle' })
  return links
})

const selectedImage = ref<any | null>(null)
const isLightboxOpen = ref(false)
const displayCount = ref(9)
const itemsPerLoad = 6

const visibleItems = computed(() => items.value.slice(0, displayCount.value))
const hasMore = computed(() => displayCount.value < items.value.length)

const openLightbox = (item: any) => {
  selectedImage.value = item
  isLightboxOpen.value = true
}

const loadMore = () => {
  displayCount.value += itemsPerLoad
}

useHead({
  title: 'Portfolio — Rainbow Retouch',
  meta: [{ name: 'description', content: 'Explore our portfolio of professional photo editing work.' }]
})
</script>

<template>
  <div>
    <UPageHero
      headline="Our Work"
      title="Portfolio"
      description="Explore our latest projects and creative solutions."
      orientation="horizontal"
    />

    <div class="py-12 px-4 sm:px-6 lg:px-16">
      <UEmpty
        v-if="!items.length"
        icon="i-lucide-image-off"
        title="No portfolio items yet"
        description="Portfolio items will appear here once added in admin."
      />
      <UPageGrid v-else class="gap-4 sm:gap-6">
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
          <div class="overflow-hidden relative aspect-square sm:aspect-auto">
            <NuxtImg
              :src="item.image_url"
              :alt="item.title || `Portfolio image ${item.id}`"
              format="webp"
              loading="lazy"
              sizes="50vw md:33vw lg:25vw"
              class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500"
            />
          </div>
          <div v-if="item.title" class="p-3 text-sm font-medium text-highlighted">
            {{ item.title }}
          </div>
        </div>
      </UPageGrid>

      <div v-if="hasMore" class="flex justify-center mt-10 sm:mt-12">
        <UButton
          label="Load More"
          size="lg"
          color="neutral"
          @click="loadMore"
        />
      </div>
    </div>

    <UModal v-model:open="isLightboxOpen" :close="true" :ui="{ content: 'max-w-7xl' }">
      <template #content>
        <div v-if="selectedImage" class="p-3 sm:p-4">
          <NuxtImg
            :src="selectedImage.image_url"
            :alt="selectedImage.title || ''"
            format="webp"
            sizes="100vw md:1400px"
            class="w-full h-auto rounded-lg"
          />
          <p v-if="selectedImage.title" class="mt-3 text-center font-medium">
            {{ selectedImage.title }}
          </p>
        </div>
      </template>
    </UModal>

    <UPageCTA
      v-if="cta.title"
      :title="cta.title"
      :description="cta.description"
      :links="ctaLinks"
      variant="subtle"
      class="overflow-hidden"
    >
      <LazyStarsBg />
    </UPageCTA>
  </div>
</template>
