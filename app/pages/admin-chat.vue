<script setup lang="ts">
import type { ChatSession } from '~/composables/useChat'

definePageMeta({ middleware: 'admin', layout: 'admin' })

const {
  sessions,
  messages,
  loadSessions,
  subscribeInbox,
  unsubscribeInbox,
  loadMessages,
  subscribe,
  unsubscribe,
  markRead,
} = useChat()

const activeId = ref<string | null>(null)
const active = computed<ChatSession | null>(
  () => sessions.value.find(s => s.id === activeId.value) || null
)

const formatTime = (iso: string) => {
  const d = new Date(iso)
  const now = new Date()
  if (d.toDateString() === now.toDateString()) {
    return d.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
  }
  return d.toLocaleDateString([], { month: 'short', day: 'numeric' })
}

const selectSession = async (s: ChatSession) => {
  activeId.value = s.id
  await loadMessages(s.id)
  subscribe(s.id)
  await markRead(s.id, 'admin')
}

onMounted(async () => {
  await loadSessions()
  subscribeInbox()
  if (sessions.value[0]) await selectSession(sessions.value[0]!)
})

onBeforeUnmount(() => {
  unsubscribe()
  unsubscribeInbox()
})

watch(messages, async () => {
  if (activeId.value) await markRead(activeId.value, 'admin')
})
</script>

<template>
  <div class="h-dvh flex flex-col">
    <header class="border-b border-default bg-background px-4 sm:px-6 py-3 flex items-center gap-3">
      <NuxtLink to="/admin" class="text-sm text-muted hover:text-highlighted flex items-center gap-1">
        <UIcon name="i-lucide-arrow-left" class="w-4 h-4" /> Back to admin
      </NuxtLink>
      <h1 class="text-base font-semibold ml-2">Live Chat</h1>
    </header>

    <div class="flex-1 flex min-h-0">
      <aside class="w-72 border-r border-default bg-muted/10 overflow-y-auto">
        <div v-if="!sessions.length" class="p-6 text-sm text-muted text-center">
          No conversations yet.
        </div>
        <ul>
          <li
            v-for="s in sessions"
            :key="s.id"
            class="border-b border-default cursor-pointer hover:bg-muted/30 transition-colors"
            :class="activeId === s.id ? 'bg-primary/5' : ''"
            @click="selectSession(s)"
          >
            <div class="px-4 py-3 flex items-start gap-2">
              <div class="flex-1 min-w-0">
                <div class="flex items-center justify-between gap-2">
                  <p class="text-sm font-medium truncate">
                    {{ s.visitor_name || s.visitor_email || 'Anonymous visitor' }}
                  </p>
                  <span class="text-[10px] text-muted shrink-0">{{ formatTime(s.last_message_at) }}</span>
                </div>
                <p v-if="s.visitor_email && s.visitor_name" class="text-xs text-muted truncate">{{ s.visitor_email }}</p>
                <p class="text-xs text-muted truncate mt-1">{{ s.last_message_preview || '—' }}</p>
              </div>
              <span
                v-if="s.unread_for_admin > 0"
                class="min-w-5 h-5 px-1 rounded-full bg-red-500 text-white text-[10px] font-bold flex items-center justify-center"
              >{{ s.unread_for_admin > 9 ? '9+' : s.unread_for_admin }}</span>
            </div>
          </li>
        </ul>
      </aside>

      <section class="flex-1 flex flex-col bg-background min-w-0">
        <template v-if="active">
          <div class="border-b border-default px-4 py-3">
            <p class="text-sm font-semibold">{{ active.visitor_name || 'Anonymous visitor' }}</p>
            <p v-if="active.visitor_email" class="text-xs text-muted">{{ active.visitor_email }}</p>
          </div>
          <ChatMessageList :messages="messages" self-role="admin" />
          <ChatComposer :session-id="active.id" />
        </template>
        <div v-else class="flex-1 flex items-center justify-center text-sm text-muted">
          Select a conversation to start replying.
        </div>
      </section>
    </div>
  </div>
</template>
