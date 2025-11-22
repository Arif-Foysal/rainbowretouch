<script setup lang="ts">
const supabase = useSupabaseClient()
const router = useRouter()
const route = useRoute()

// Handle OAuth callback and email confirmation
onMounted(async () => {
  const { error } = await supabase.auth.getSession()
  
  if (error) {
    console.error('Auth error:', error)
    router.push('/login')
  } else {
    // Redirect to dashboard after successful auth
    router.push('/dashboard')
  }
})
</script>

<template>
  <div class="flex items-center justify-center min-h-screen">
    <div class="text-center">
      <UIcon name="i-lucide-loader-2" class="w-8 h-8 animate-spin mx-auto mb-4" />
      <p class="text-muted">Confirming your authentication...</p>
    </div>
  </div>
</template>