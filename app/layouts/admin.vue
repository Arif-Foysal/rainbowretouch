<script setup lang="ts">
const route = useRoute()
const showBadge = computed(() => route.path !== '/admin-chat' && route.path !== '/admin-seo')
</script>

<template>
  <div class="min-h-dvh bg-muted/20 text-default">
    <slot />
    <div
      v-if="showBadge"
      class="fixed bottom-4 right-4 sm:bottom-6 sm:right-6 z-50"
    >
      <ChatAdminBadge />
    </div>
  </div>
</template>
