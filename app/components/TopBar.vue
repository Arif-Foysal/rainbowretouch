<script setup lang="ts">
const { data: settings } = await useSiteSettings()
const contactInfo = computed(() => settings.value?.contact || {})

const whatsappUrl = computed(() => {
  const num = (contactInfo.value.whatsapp || '').toString().replace(/\D/g, '')
  return num ? `https://wa.me/${num}` : '#'
})

const isDismissed = ref(false)

onMounted(() => {
  if (typeof localStorage !== 'undefined') {
    isDismissed.value = localStorage.getItem('topBannerDismissed') === 'true'
  }
})

function dismissBanner() {
  isDismissed.value = true
  if (typeof localStorage !== 'undefined') localStorage.setItem('topBannerDismissed', 'true')
}
</script>

<template>
  <div
    v-if="!isDismissed"
    class="bg-muted/30 border-b border-default"
  >
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="flex flex-wrap items-center gap-3 sm:gap-4 py-2 sm:py-3">
        <a
          :href="whatsappUrl"
          target="_blank"
          rel="noopener noreferrer"
          class="flex items-center gap-2 text-xs sm:text-sm font-medium text-default hover:text-green-600 transition-colors"
        >
          <UIcon name="i-simple-icons-whatsapp" class="w-4 h-4 sm:w-5 sm:h-5 text-green-600" />
          <span>{{ contactInfo.phone || 'Chat on WhatsApp' }}</span>
        </a>

        <div class="hidden md:flex flex-1 gap-2 items-center justify-center">
          <p class="text-sm text-default text-center">
            Get a <span class="font-semibold">free photo retouch</span> — just upload your image!
          </p>
          <UButton label="Upload Now" color="neutral" variant="solid" size="sm" to="/contact" />
        </div>

        <div class="flex items-center gap-3 ml-auto">
          <button
            class="flex items-center justify-center w-6 h-6 bg-red-500/80 hover:bg-red-600 text-white rounded transition-colors"
            aria-label="Close banner"
            @click="dismissBanner"
          >
            <UIcon name="i-lucide-x" class="w-4 h-4" />
          </button>
        </div>
      </div>
    </div>
  </div>
</template>
