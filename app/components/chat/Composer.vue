<script setup lang="ts">
const props = defineProps<{
  sessionId: string
  disabled?: boolean
}>()

const emit = defineEmits<{
  (e: 'sent'): void
}>()

const { sendText, sendImage } = useChat()
const text = ref('')
const fileInput = ref<HTMLInputElement | null>(null)
const sending = ref(false)
const error = ref<string | null>(null)

const submit = async () => {
  if (!text.value.trim() || sending.value) return
  sending.value = true
  error.value = null
  try {
    await sendText(props.sessionId, text.value)
    text.value = ''
    emit('sent')
  } finally {
    sending.value = false
  }
}

const onFile = async (e: Event) => {
  const target = e.target as HTMLInputElement
  const file = target.files?.[0]
  if (!file) return
  sending.value = true
  error.value = null
  try {
    await sendImage(props.sessionId, file)
    emit('sent')
  } catch (err: unknown) {
    error.value = (err as Error).message || 'Upload failed'
  } finally {
    sending.value = false
    if (fileInput.value) fileInput.value.value = ''
  }
}

const onKey = (e: KeyboardEvent) => {
  if (e.key === 'Enter' && !e.shiftKey) {
    e.preventDefault()
    submit()
  }
}
</script>

<template>
  <div class="border-t border-gray-200 dark:border-gray-800 bg-white dark:bg-gray-950 p-2">
    <p v-if="error" class="text-xs text-red-500 mb-1 px-1">{{ error }}</p>
    <div class="flex items-end gap-2">
      <button
        type="button"
        class="p-2 text-gray-500 hover:text-primary-500 disabled:opacity-50"
        :disabled="sending || disabled"
        aria-label="Attach image"
        @click="fileInput?.click()"
      >
        <UIcon name="i-lucide-paperclip" class="w-5 h-5" />
      </button>
      <input
        ref="fileInput"
        type="file"
        accept="image/jpeg,image/png,image/webp,image/gif"
        class="hidden"
        @change="onFile"
      >
      <textarea
        v-model="text"
        rows="1"
        placeholder="Type a message…"
        :disabled="sending || disabled"
        class="flex-1 resize-none rounded-lg border border-gray-300 dark:border-gray-700 bg-white dark:bg-gray-900 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500 max-h-32"
        @keydown="onKey"
      />
      <button
        type="button"
        class="p-2 rounded-full bg-primary-500 text-white hover:bg-primary-600 disabled:opacity-50"
        :disabled="sending || disabled || !text.trim()"
        aria-label="Send"
        @click="submit"
      >
        <UIcon name="i-lucide-send" class="w-4 h-4" />
      </button>
    </div>
  </div>
</template>
