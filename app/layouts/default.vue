<script setup lang="ts">
const { data: settings } = await useSiteSettings()
const contactInfo = computed(() => settings.value?.contact || {})
const whatsappUrl = computed(() => {
  const num = (contactInfo.value.whatsapp || '').toString().replace(/\D/g, '')
  return num ? `https://wa.me/${num}` : ''
})
</script>

<template>
  <div>
    <AppHeader />

    <UMain>
      <slot />
    </UMain>

    <AppFooter />

    <a
      v-if="whatsappUrl"
      :href="whatsappUrl"
      target="_blank"
      rel="noopener noreferrer"
      class="fixed bottom-4 right-4 sm:bottom-6 sm:right-6 z-50 flex items-center justify-center w-12 h-12 sm:w-14 sm:h-14 bg-[#25D366] hover:bg-[#20BA5A] text-white rounded-full shadow-lg hover:shadow-xl transition-all duration-300 hover:scale-110"
      aria-label="Chat on WhatsApp"
    >
      <UIcon name="i-simple-icons-whatsapp" class="w-6 h-6 sm:w-7 sm:h-7" />
    </a>
  </div>
</template>
