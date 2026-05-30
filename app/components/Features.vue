<script setup lang="ts">
const { data: settings } = await useSiteSettings()
const block = computed<any>(() => settings.value?.service_highlights || {})
const features = computed<any[]>(() => block.value?.items || [])

const colorMap: Record<string, { bg: string, text: string, hover: string }> = {
  blue: { bg: 'bg-blue-500/10', text: 'text-blue-600 dark:text-blue-400', hover: 'group-hover:bg-blue-500/20' },
  purple: { bg: 'bg-purple-500/10', text: 'text-purple-600 dark:text-purple-400', hover: 'group-hover:bg-purple-500/20' },
  green: { bg: 'bg-green-500/10', text: 'text-green-600 dark:text-green-400', hover: 'group-hover:bg-green-500/20' },
  red: { bg: 'bg-red-500/10', text: 'text-red-600 dark:text-red-400', hover: 'group-hover:bg-red-500/20' },
  orange: { bg: 'bg-orange-500/10', text: 'text-orange-600 dark:text-orange-400', hover: 'group-hover:bg-orange-500/20' },
  indigo: { bg: 'bg-indigo-500/10', text: 'text-indigo-600 dark:text-indigo-400', hover: 'group-hover:bg-indigo-500/20' },
  emerald: { bg: 'bg-emerald-500/10', text: 'text-emerald-600 dark:text-emerald-400', hover: 'group-hover:bg-emerald-500/20' },
  pink: { bg: 'bg-pink-500/10', text: 'text-pink-600 dark:text-pink-400', hover: 'group-hover:bg-pink-500/20' },
  cyan: { bg: 'bg-cyan-500/10', text: 'text-cyan-600 dark:text-cyan-400', hover: 'group-hover:bg-cyan-500/20' },
  violet: { bg: 'bg-violet-500/10', text: 'text-violet-600 dark:text-violet-400', hover: 'group-hover:bg-violet-500/20' }
}

const getColorClasses = (color?: string) => colorMap[color || 'blue'] || colorMap.blue
</script>

<template>
  <UPageSection
    v-if="features.length"
    :title="block.title"
    :description="block.description"
  >
    <div class="space-y-12">
      <!-- Hero Image Section -->
      <div v-if="block.hero_image_url" class="relative group">
        <div class="absolute inset-0 bg-gradient-to-r from-primary/20 to-purple-500/20 rounded-3xl blur-3xl group-hover:blur-2xl transition-all duration-500 opacity-50" />
        <UCard variant="outline" class="relative overflow-hidden">
          <div class="aspect-[21/9] relative">
            <NuxtImg
              :src="block.hero_image_url"
              :alt="block.hero_image_title || 'Service highlight'"
              format="webp"
              loading="lazy"
              sizes="100vw md:1200px"
              class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-700 rounded-md"
            />
            <div class="absolute inset-0 bg-gradient-to-t from-black/70 via-black/20 to-transparent flex items-end transform transition-transform duration-700 group-hover:scale-110">
              <div class="p-8 lg:p-12 text-white max-w-2xl">
                <div
                  v-if="block.hero_image_badge"
                  class="inline-block px-4 py-1 bg-primary/90 rounded-full text-sm font-medium mb-4"
                >
                  {{ block.hero_image_badge }}
                </div>
                <h2 v-if="block.hero_image_title" class="text-4xl lg:text-5xl font-bold mb-4">
                  {{ block.hero_image_title }}
                </h2>
                <p v-if="block.hero_image_subtitle" class="text-lg text-gray-200">
                  {{ block.hero_image_subtitle }}
                </p>
              </div>
            </div>
          </div>
        </UCard>
      </div>

      <!-- Features Grid -->
      <UPageGrid>
        <UCard
          v-for="(feature, index) in features"
          :key="index"
          variant="subtle"
          class="group hover:scale-105 hover:shadow-xl transition-all duration-300 ease-out cursor-pointer"
        >
          <div class="flex flex-col items-center text-center space-y-4 p-2">
            <div
              :class="[
                'p-4 rounded-full transition-all duration-300',
                getColorClasses(feature.color).bg,
                getColorClasses(feature.color).hover
              ]"
            >
              <UIcon
                :name="feature.icon"
                :class="['size-7', getColorClasses(feature.color).text]"
              />
            </div>
            <div>
              <h3 class="font-bold text-lg text-gray-900 dark:text-white mb-2 group-hover:text-primary transition-colors">
                {{ feature.title }}
              </h3>
              <p class="text-sm text-gray-600 dark:text-gray-400 leading-relaxed">
                {{ feature.description }}
              </p>
            </div>
          </div>
        </UCard>
      </UPageGrid>
    </div>
  </UPageSection>
</template>
