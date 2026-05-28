<script setup lang="ts">
const { sessions, loadSessions, subscribeInbox, unsubscribeInbox } = useChat()

const totalUnread = computed(() =>
  sessions.value.reduce((sum, s) => sum + (s.unread_for_admin || 0), 0)
)

onMounted(async () => {
  await loadSessions()
  subscribeInbox()
})

onBeforeUnmount(() => unsubscribeInbox())
</script>

<template>
  <NuxtLink
    to="/admin-chat"
    class="relative flex items-center justify-center w-12 h-12 sm:w-14 sm:h-14 bg-primary-500 hover:bg-primary-600 text-white rounded-full shadow-lg hover:shadow-xl transition-all duration-300 hover:scale-110"
    aria-label="Open chat inbox"
  >
    <UIcon name="i-lucide-message-circle" class="w-6 h-6 sm:w-7 sm:h-7" />
    <span
      v-if="totalUnread > 0"
      class="absolute -top-1 -right-1 min-w-5 h-5 px-1 rounded-full bg-red-500 text-white text-[10px] font-bold flex items-center justify-center"
    >{{ totalUnread > 9 ? '9+' : totalUnread }}</span>
  </NuxtLink>
</template>
