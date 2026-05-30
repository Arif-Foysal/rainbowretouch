<script setup lang="ts">
import * as z from 'zod'
import type { FormSubmitEvent } from '@nuxt/ui'

definePageMeta({ layout: 'auth' })

useSeoMeta({
  title: 'Reset password',
  description: 'Choose a new password'
})

const supabase = useSupabaseClient()
const user = useSupabaseUser()
const toast = useToast()

const fields = [{
  name: 'password',
  type: 'password' as const,
  label: 'New password',
  placeholder: 'At least 8 characters',
  required: true
}, {
  name: 'confirm',
  type: 'password' as const,
  label: 'Confirm password',
  placeholder: 'Re-enter the same password',
  required: true
}]

const schema = z.object({
  password: z.string().min(8, 'Must be at least 8 characters'),
  confirm: z.string()
}).refine(d => d.password === d.confirm, {
  message: 'Passwords do not match',
  path: ['confirm']
})
type Schema = z.output<typeof schema>

const loading = ref(false)
const recovered = ref(false)

// When Supabase redirects back from the reset email, it puts a recovery
// session in place. Detect it so we can show a useful error if someone
// lands here directly without a valid link.
onMounted(() => {
  supabase.auth.onAuthStateChange((event) => {
    if (event === 'PASSWORD_RECOVERY' || event === 'SIGNED_IN') {
      recovered.value = true
    }
  })
  // Also accept an already-active session (e.g. user reloaded the page).
  if (user.value) recovered.value = true
})

async function onSubmit(payload: FormSubmitEvent<Schema>) {
  loading.value = true
  const { error } = await supabase.auth.updateUser({ password: payload.data.password })
  loading.value = false
  if (error) {
    toast.add({ title: 'Could not update password', description: error.message, color: 'error' })
    return
  }
  toast.add({ title: 'Password updated', description: 'You can now log in with your new password.', color: 'success' })

  const { data: profile } = await supabase
    .from('profiles')
    .select('role')
    .eq('id', user.value?.id || '')
    .maybeSingle()
  const role = (profile as { role?: string } | null)?.role
  await navigateTo(role === 'admin' ? '/admin' : '/dashboard', { replace: true })
}
</script>

<template>
  <UAuthForm
    :fields="fields"
    :schema="schema"
    title="Choose a new password"
    :description="recovered
      ? 'Pick a strong password you don\'t use anywhere else.'
      : 'If you arrived here without clicking the email link, request a new reset link.'"
    icon="i-lucide-shield-check"
    :loading="loading"
    :submit="{ label: 'Update password', disabled: !recovered }"
    @submit="onSubmit"
  >
    <template #footer>
      <ULink to="/forgot-password" class="text-primary font-medium">Resend reset link</ULink>
      &nbsp;·&nbsp;
      <ULink to="/login" class="text-primary font-medium">Back to login</ULink>
    </template>
  </UAuthForm>
</template>
