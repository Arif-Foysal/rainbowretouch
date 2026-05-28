<script setup lang="ts">
import type { ChatMessage } from '~/composables/useChat'

const props = defineProps<{
  messages: ChatMessage[]
  selfRole: 'visitor' | 'admin'
}>()

const scrollEl = ref<HTMLElement | null>(null)

const scrollToBottom = () => {
  nextTick(() => {
    if (scrollEl.value) scrollEl.value.scrollTop = scrollEl.value.scrollHeight
  })
}

watch(() => props.messages.length, scrollToBottom)
onMounted(scrollToBottom)

const formatTime = (iso: string) => {
  const d = new Date(iso)
  return d.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
}

const downloadImage = async (url: string) => {
  try {
    const res = await fetch(url)
    const blob = await res.blob()
    const objectUrl = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = objectUrl
    a.download = url.split('/').pop()?.split('?')[0] || 'chat-image'
    document.body.appendChild(a)
    a.click()
    a.remove()
    setTimeout(() => URL.revokeObjectURL(objectUrl), 1000)
  } catch (e) {
    console.error('Download failed:', e)
    window.open(url, '_blank')
  }
}
</script>

<template>
  <div ref="scrollEl" class="flex-1 overflow-y-auto px-3 py-3 space-y-2 bg-gray-50 dark:bg-gray-900">
    <div v-if="!messages.length" class="text-center text-sm text-gray-500 pt-8">
      Say hi to start the conversation
    </div>
    <div
      v-for="m in messages"
      :key="m.id"
      class="flex"
      :class="m.sender_role === selfRole ? 'justify-end' : 'justify-start'"
    >
      <div
        class="max-w-[75%] rounded-2xl px-3 py-2 text-sm shadow-sm"
        :class="m.sender_role === selfRole
          ? 'bg-primary-500 text-white rounded-br-sm'
          : 'bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100 rounded-bl-sm'"
      >
        <div v-if="m.image_url" class="relative group mb-1">
          <a :href="m.image_url" target="_blank" rel="noopener noreferrer">
            <img
              :src="m.image_url"
              alt="attachment"
              class="rounded-lg max-h-60 object-cover cursor-zoom-in"
            >
          </a>
          <button
            type="button"
            class="absolute top-1.5 right-1.5 p-1.5 rounded-full bg-black/55 hover:bg-black/75 text-white opacity-0 group-hover:opacity-100 focus:opacity-100 transition-opacity"
            aria-label="Download image"
            @click.stop="downloadImage(m.image_url)"
          >
            <UIcon name="i-lucide-download" class="w-3.5 h-3.5" />
          </button>
        </div>
        <div v-if="m.body" class="whitespace-pre-wrap break-words">{{ m.body }}</div>
        <div
          class="text-[10px] mt-1 opacity-70"
          :class="m.sender_role === selfRole ? 'text-white/80' : 'text-gray-500'"
        >
          {{ formatTime(m.created_at) }}
        </div>
      </div>
    </div>
  </div>
</template>
