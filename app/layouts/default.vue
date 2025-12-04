<template>
  <div>
    <AppHeader />

    <UMain>
      <slot />
    </UMain>

    <AppFooter />

    <!-- WhatsApp Floating Button -->
    <a
      href="https://wa.me/101743987"
      target="_blank"
      rel="noopener noreferrer"
      class="fixed bottom-6 right-6 z-50 flex items-center justify-center w-14 h-14 bg-[#25D366] hover:bg-[#20BA5A] text-white rounded-full shadow-lg hover:shadow-xl transition-all duration-300 hover:scale-110"
      aria-label="Chat on WhatsApp"
    >
      <UIcon name="i-simple-icons-whatsapp" class="w-7 h-7" />
    </a>
  </div>
</template>
