<script setup lang="ts">
// Protect this route - require authentication
definePageMeta({
  auth: true
})

const supabase = useSupabaseClient()
const user = useSupabaseUser()
const router = useRouter()

const signOut = async () => {
  const { error } = await supabase.auth.signOut()
  if (error) {
    console.error('Error signing out:', error)
  } else {
    await router.push('/login')
  }
}
</script>

<template>
  <div class="min-h-screen bg-gray-50 dark:bg-gray-900">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <div class="mb-8">
        <div class="flex justify-between items-center">
          <div>
            <h1 class="text-3xl font-bold text-gray-900 dark:text-white">Dashboard</h1>
            <p class="text-gray-600 dark:text-gray-400">Welcome back, {{ user?.user_metadata?.name || user?.email }}!</p>
          </div>
          <UButton
            color="red"
            variant="outline"
            @click="signOut"
            icon="i-lucide-log-out"
          >
            Sign Out
          </UButton>
        </div>
      </div>

      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <!-- User Info Card -->
        <UCard>
          <template #header>
            <h3 class="text-lg font-semibold">Profile Information</h3>
          </template>
          
          <div class="space-y-3">
            <div>
              <label class="text-sm font-medium text-gray-500">Email</label>
              <p class="text-gray-900 dark:text-white">{{ user?.email }}</p>
            </div>
            <div v-if="user?.user_metadata?.name">
              <label class="text-sm font-medium text-gray-500">Name</label>
              <p class="text-gray-900 dark:text-white">{{ user.user_metadata.name }}</p>
            </div>
            <div>
              <label class="text-sm font-medium text-gray-500">User ID</label>
              <p class="text-gray-900 dark:text-white text-xs font-mono">{{ user?.id }}</p>
            </div>
            <div>
              <label class="text-sm font-medium text-gray-500">Signed up</label>
              <p class="text-gray-900 dark:text-white">{{ new Date(user?.created_at || '').toLocaleDateString() }}</p>
            </div>
            <div>
              <label class="text-sm font-medium text-gray-500">Email Confirmed</label>
              <UBadge 
                :color="user?.email_confirmed_at ? 'green' : 'yellow'"
                :label="user?.email_confirmed_at ? 'Verified' : 'Pending'"
              />
            </div>
          </div>
        </UCard>

        <!-- Quick Actions Card -->
        <UCard>
          <template #header>
            <h3 class="text-lg font-semibold">Quick Actions</h3>
          </template>
          
          <div class="space-y-3">
            <UButton block variant="outline" icon="i-lucide-user">
              Edit Profile
            </UButton>
            <UButton block variant="outline" icon="i-lucide-settings">
              Account Settings
            </UButton>
            <UButton block variant="outline" icon="i-lucide-credit-card">
              Billing
            </UButton>
          </div>
        </UCard>

        <!-- Activity Card -->
        <UCard>
          <template #header>
            <h3 class="text-lg font-semibold">Recent Activity</h3>
          </template>
          
          <div class="space-y-3">
            <div class="text-sm text-gray-600 dark:text-gray-400">
              <p>• Signed in {{ new Date(user?.last_sign_in_at || '').toLocaleDateString() }}</p>
              <p>• Account created {{ new Date(user?.created_at || '').toLocaleDateString() }}</p>
            </div>
          </div>
        </UCard>
      </div>
    </div>
  </div>
</template>
