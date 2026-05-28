<script setup lang="ts">
const { data: settings } = await useSiteSettings()

const hero = computed(() => settings.value?.hero_video || {})
const overlay = computed(() => {
  const o = Number(hero.value.overlay_opacity)
  return Number.isFinite(o) ? Math.max(0, Math.min(1, o)) : 0.45
})

const videoEl = ref<HTMLVideoElement | null>(null)
const isMuted = ref(true)

function toggleMute() {
  if (!videoEl.value) return
  videoEl.value.muted = !videoEl.value.muted
  isMuted.value = videoEl.value.muted
}
</script>

<template>
  <section class="relative h-[70vh] min-h-[420px] sm:h-[80vh] lg:h-[90vh] w-full overflow-hidden bg-black">
    <!-- Video background -->
    <video
      v-if="hero.video_url"
      ref="videoEl"
      class="absolute inset-0 h-full w-full object-cover"
      :poster="hero.poster_url || undefined"
      :src="hero.video_url"
      autoplay
      loop
      muted
      playsinline
      preload="metadata"
    />
    <!-- Fallback poster image when no video set -->
    <img
      v-else-if="hero.poster_url"
      :src="hero.poster_url"
      alt=""
      class="absolute inset-0 h-full w-full object-cover"
    >
    <div
      v-else
      class="absolute inset-0 bg-gradient-to-br from-primary/30 via-black to-black"
    />

    <!-- Dark overlay -->
    <div
      class="absolute inset-0 bg-black"
      :style="{ opacity: overlay }"
    />

    <!-- Mute toggle (only if there is a video) -->
    <button
      v-if="hero.video_url"
      type="button"
      class="absolute right-3 top-3 sm:right-6 sm:top-6 z-20 flex h-9 w-9 sm:h-10 sm:w-10 items-center justify-center rounded-full bg-black/40 text-white backdrop-blur-sm transition hover:bg-black/60 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary"
      :aria-label="isMuted ? 'Unmute video' : 'Mute video'"
      @click="toggleMute"
    >
      <UIcon :name="isMuted ? 'i-lucide-volume-x' : 'i-lucide-volume-2'" class="h-4 w-4 sm:h-5 sm:w-5" />
    </button>

    <!-- Content -->
    <div class="relative z-10 flex h-full items-end sm:items-center">
      <div class="container mx-auto px-4 sm:px-6 lg:px-8 pb-12 sm:pb-0">
        <div class="max-w-3xl text-white">
          <p
            v-if="hero.headline"
            class="mb-2 sm:mb-3 text-xs sm:text-sm font-semibold uppercase tracking-widest text-primary"
          >
            {{ hero.headline }}
          </p>
          <h1
            v-if="hero.title"
            class="text-3xl sm:text-5xl lg:text-7xl font-bold leading-tight mb-3 sm:mb-5 animate-fade-in-up"
          >
            {{ hero.title }}
          </h1>
          <p
            v-if="hero.description"
            class="text-sm sm:text-lg lg:text-xl mb-5 sm:mb-7 max-w-xl text-white/85 animate-fade-in-up animation-delay-200"
          >
            {{ hero.description }}
          </p>
          <div
            v-if="hero.button_text"
            class="animate-fade-in-up animation-delay-400"
          >
            <UButton
              :to="hero.button_link || '/contact'"
              size="lg"
              color="primary"
              class="shadow-2xl sm:!text-base"
              trailing-icon="i-lucide-arrow-right"
            >
              {{ hero.button_text }}
            </UButton>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
@keyframes fadeInUp {
  from { opacity: 0; transform: translateY(30px); }
  to   { opacity: 1; transform: translateY(0); }
}
.animate-fade-in-up { animation: fadeInUp 0.8s ease-out forwards; }
.animation-delay-200 { animation-delay: 0.2s; opacity: 0; }
.animation-delay-400 { animation-delay: 0.4s; opacity: 0; }
</style>
