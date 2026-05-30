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
  <!--
    MOBILE (<sm): stacked layout — video shown in its native 16:9 ratio at the top
    (no cropping), text content lives in a black band below. No awkward side-crop.
    DESKTOP (sm+): immersive full-bleed hero with text overlaid on the video.
  -->
  <section class="relative w-full overflow-hidden bg-black sm:h-[78vh] lg:h-[88vh]">
    <!-- Media -->
    <div class="relative w-full aspect-video sm:absolute sm:inset-0 sm:aspect-auto sm:h-full">
      <video
        v-if="hero.video_url"
        ref="videoEl"
        class="absolute inset-0 h-full w-full object-contain sm:object-cover object-center"
        :poster="hero.poster_url || undefined"
        :src="hero.video_url"
        autoplay
        loop
        muted
        playsinline
        preload="metadata"
      />
      <NuxtImg
        v-else-if="hero.poster_url"
        :src="hero.poster_url"
        alt=""
        format="webp"
        loading="eager"
        fetchpriority="high"
        sizes="100vw"
        class="absolute inset-0 h-full w-full object-contain sm:object-cover object-center"
      />
      <div
        v-else
        class="absolute inset-0 bg-gradient-to-br from-primary/30 via-black to-black"
      />

      <!-- Flat dark overlay (desktop only — would hide a contained mobile video) -->
      <div
        class="absolute inset-0 bg-black hidden sm:block"
        :style="{ opacity: overlay }"
      />
      <!-- Bottom-darkening gradient on desktop only -->
      <div class="pointer-events-none hidden sm:block absolute inset-x-0 bottom-0 h-1/2 bg-gradient-to-t from-black/85 via-black/40 to-transparent" />

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
    </div>

    <!-- Content: stacks below video on mobile, overlays on desktop -->
    <div class="relative z-10 sm:absolute sm:inset-0 flex sm:items-center bg-black sm:bg-transparent">
      <div class="container mx-auto px-5 sm:px-6 lg:px-8 py-8 sm:py-0">
        <div class="max-w-3xl text-white">
          <p
            v-if="hero.headline"
            class="mb-2 sm:mb-3 text-[11px] sm:text-sm font-semibold uppercase tracking-widest text-primary"
          >
            {{ hero.headline }}
          </p>
          <h1
            v-if="hero.title"
            class="text-[clamp(1.75rem,7vw,2.5rem)] sm:text-5xl lg:text-7xl font-bold leading-[1.1] mb-3 sm:mb-5 animate-fade-in-up text-balance"
          >
            {{ hero.title }}
          </h1>
          <p
            v-if="hero.description"
            class="text-sm sm:text-lg lg:text-xl mb-5 sm:mb-7 max-w-xl text-white/85 line-clamp-3 sm:line-clamp-none animate-fade-in-up animation-delay-200"
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
              class="w-full justify-center sm:w-auto shadow-2xl sm:!text-base"
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
