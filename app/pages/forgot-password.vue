<script setup lang="ts">
import * as z from 'zod'
import type { FormSubmitEvent } from '@nuxt/ui'

definePageMeta({ layout: 'auth' })

useSeoMeta({
  title: 'Forgot password',
  description: 'Reset your password by email'
})

const supabase = useSupabaseClient()
const toast = useToast()

const fields = [{
  name: 'email',
  type: 'text' as const,
  label: 'Email',
  placeholder: 'you@example.com',
  required: true
}]

const schema = z.object({
  email: z.string().email('Invalid email')
})
type Schema = z.output<typeof schema>

const loading = ref(false)
const sent = ref(false)
const sentTo = ref('')

async function onSubmit(payload: FormSubmitEvent<Schema>) {
  loading.value = true
  const redirectTo = `${window.location.origin}/reset-password`
  const { error } = await supabase.auth.resetPasswordForEmail(payload.data.email, { redirectTo })
  loading.value = false
  if (error) {
    toast.add({ title: 'Could not send reset email', description: error.message, color: 'error' })
    return
  }
  sentTo.value = payload.data.email
  sent.value = true
  toast.add({ title: 'Email sent', description: 'Check your inbox for the reset link.', color: 'success' })
}
</script>

<template>
  <div>
    <div v-if="sent" class="max-w-md mx-auto p-6 text-center space-y-4">
      <UIcon name="i-lucide-mail-check" class="w-12 h-12 text-primary mx-auto" />
      <h1 class="text-xl font-semibold">Check your email</h1>
      <p class="text-sm text-muted">
        We sent a password reset link to <strong>{{ sentTo }}</strong>. Click the link to set a new password.
        If you don't see it, check spam.
      </p>
      <UButton to="/login" variant="subtle" color="neutral">Back to login</UButton>
    </div>

    <UAuthForm
      v-else
      :fields="fields"
      :schema="schema"
      title="Forgot your password?"
      description="Enter your email and we'll send you a link to reset it."
      icon="i-lucide-key-round"
      :loading="loading"
      :submit="{ label: 'Send reset link' }"
      @submit="onSubmit"
    >
      <template #footer>
        Remembered it? <ULink to="/login" class="text-primary font-medium">Back to login</ULink>.
      </template>
    </UAuthForm>
  </div>
</template>
