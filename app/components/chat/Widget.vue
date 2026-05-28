<script setup lang="ts">
const {
  session,
  messages,
  ensureVisitor,
  loadMessages,
  subscribe,
  unsubscribe,
  markRead,
  updateVisitorInfo,
} = useChat()

const open = ref(false)
const initializing = ref(false)
const showPrechat = ref(false)
const prechatName = ref('')
const prechatEmail = ref('')

const unread = computed(() => session.value?.unread_for_visitor || 0)

const init = async () => {
  if (session.value || initializing.value) return
  initializing.value = true
  const s = await ensureVisitor()
  if (s) {
    if (!s.visitor_name && !s.visitor_email) showPrechat.value = true
    await loadMessages(s.id)
    subscribe(s.id)
  }
  initializing.value = false
}

const toggle = async () => {
  open.value = !open.value
  if (open.value) {
    await init()
    if (session.value) await markRead(session.value.id, 'visitor')
  }
}

const submitPrechat = async () => {
  if (!session.value) return
  await updateVisitorInfo(session.value.id, {
    visitor_name: prechatName.value.trim() || undefined,
    visitor_email: prechatEmail.value.trim() || undefined,
  })
  showPrechat.value = false
}

onBeforeUnmount(() => unsubscribe())

watch(messages, async () => {
  if (open.value && session.value) {
    await markRead(session.value.id, 'visitor')
  }
})
</script>

<template>
  <div class="relative">
    <Transition
      enter-active-class="transition duration-200 ease-out"
      enter-from-class="opacity-0 translate-y-2"
      enter-to-class="opacity-100 translate-y-0"
      leave-active-class="transition duration-150 ease-in"
      leave-from-class="opacity-100 translate-y-0"
      leave-to-class="opacity-0 translate-y-2"
    >
      <div
        v-if="open"
        class="absolute bottom-16 right-0 w-[92vw] max-w-sm h-[70vh] max-h-[520px] bg-white dark:bg-gray-950 rounded-2xl shadow-2xl border border-gray-200 dark:border-gray-800 flex flex-col overflow-hidden"
      >
        <div class="flex items-center justify-between px-4 py-3 bg-primary-500 text-white">
          <div>
            <div class="font-semibold text-sm">Rainbow Retouch</div>
            <div class="text-xs opacity-80">We usually reply within minutes</div>
          </div>
          <button
            type="button"
            class="p-1 rounded hover:bg-white/10"
            aria-label="Close chat"
            @click="open = false"
          >
            <UIcon name="i-lucide-x" class="w-5 h-5" />
          </button>
        </div>

        <div v-if="showPrechat" class="p-4 space-y-3 bg-gray-50 dark:bg-gray-900 border-b border-gray-200 dark:border-gray-800">
          <p class="text-xs text-gray-600 dark:text-gray-300">Tell us who you are (optional):</p>
          <input
            v-model="prechatName"
            type="text"
            placeholder="Your name"
            class="w-full rounded-lg border border-gray-300 dark:border-gray-700 bg-white dark:bg-gray-950 px-3 py-2 text-sm"
          >
          <input
            v-model="prechatEmail"
            type="email"
            placeholder="Email (so we can follow up)"
            class="w-full rounded-lg border border-gray-300 dark:border-gray-700 bg-white dark:bg-gray-950 px-3 py-2 text-sm"
          >
          <div class="flex justify-end gap-2">
            <button class="text-xs px-3 py-1 text-gray-500" @click="showPrechat = false">Skip</button>
            <button class="text-xs px-3 py-1 rounded bg-primary-500 text-white" @click="submitPrechat">Continue</button>
          </div>
        </div>

        <div v-else-if="initializing && !session" class="flex-1 flex items-center justify-center text-sm text-gray-500">
          Connecting…
        </div>

        <template v-else-if="session">
          <ChatMessageList :messages="messages" self-role="visitor" />
          <ChatComposer :session-id="session.id" />
        </template>
      </div>
    </Transition>

    <button
      type="button"
      class="relative flex items-center justify-center w-12 h-12 sm:w-14 sm:h-14 bg-primary-500 hover:bg-primary-600 text-white rounded-full shadow-lg hover:shadow-xl transition-all duration-300 hover:scale-110"
      :aria-label="open ? 'Close chat' : 'Open chat'"
      @click="toggle"
    >
      <UIcon
        :name="open ? 'i-lucide-x' : 'i-lucide-message-circle'"
        class="w-6 h-6 sm:w-7 sm:h-7"
      />
      <span
        v-if="!open && unread > 0"
        class="absolute -top-1 -right-1 min-w-5 h-5 px-1 rounded-full bg-red-500 text-white text-[10px] font-bold flex items-center justify-center"
      >{{ unread > 9 ? '9+' : unread }}</span>
    </button>
  </div>
</template>
