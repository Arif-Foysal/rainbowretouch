<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import authService from '@/services/auth'

const router = useRouter()
const user = ref(null)
const isLoading = ref(true)
const errorMessage = ref('')

// Fetch user data on component mount
onMounted(async () => {
  try {
    // Check if we have a token in localStorage
    const token = localStorage.getItem('auth_token')
    if (!token) {
      router.push({ name: 'Login' })
      return
    }
    
    // Get user profile data
    const response = await authService.getUser()
    user.value = response.data
  } catch (error) {
    console.error('Error fetching user data:', error)
    errorMessage.value = 'Failed to load user profile'
    
    // If unauthorized, redirect to login
    if (error.response && error.response.status === 401) {
      localStorage.removeItem('auth_token')
      localStorage.removeItem('user')
      router.push({ name: 'Login' })
    }
  } finally {
    isLoading.value = false
  }
})

// Handle logout
const handleLogout = async () => {
  try {
    await authService.logout()
    
    // Clear local storage
    localStorage.removeItem('auth_token')
    localStorage.removeItem('user')
    
    // Redirect to home
    router.push({ name: 'Home' })
  } catch (error) {
    console.error('Logout error:', error)
    errorMessage.value = 'Failed to logout. Please try again.'
  }
}
</script>

<template>
  <div class="bg-gray-100 min-h-screen">
    <div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
      <div class="px-4 py-6 sm:px-0">
        <!-- Loading state -->
        <div v-if="isLoading" class="flex justify-center items-center h-64">
          <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-indigo-500"></div>
        </div>
        
        <!-- Error message -->
        <div v-else-if="errorMessage" class="rounded-md bg-red-50 p-4 mb-6">
          <div class="flex">
            <div class="ml-3">
              <h3 class="text-sm font-medium text-red-800">{{ errorMessage }}</h3>
            </div>
          </div>
        </div>
        
        <!-- User profile -->
        <div v-else-if="user" class="bg-white shadow overflow-hidden sm:rounded-lg">
          <div class="px-4 py-5 sm:px-6 flex justify-between items-center">
            <div>
              <h3 class="text-lg leading-6 font-medium text-gray-900">User Profile</h3>
              <p class="mt-1 max-w-2xl text-sm text-gray-500">Personal details and account information</p>
            </div>
            <button 
              @click="handleLogout"
              class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500"
            >
              Logout
            </button>
          </div>
          <div class="border-t border-gray-200">
            <dl>
              <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                <dt class="text-sm font-medium text-gray-500">Full name</dt>
                <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">{{ user.name }}</dd>
              </div>
              <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                <dt class="text-sm font-medium text-gray-500">Email address</dt>
                <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">{{ user.email }}</dd>
              </div>
              <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                <dt class="text-sm font-medium text-gray-500">Account created</dt>
                <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                  {{ new Date(user.created_at).toLocaleDateString() }}
                </dd>
              </div>
            </dl>
          </div>
        </div>
        
        <!-- Services section -->
        <div class="mt-8 bg-white shadow overflow-hidden sm:rounded-lg">
          <div class="px-4 py-5 sm:px-6">
            <h3 class="text-lg leading-6 font-medium text-gray-900">My Services</h3>
            <p class="mt-1 max-w-2xl text-sm text-gray-500">Your ordered services and their status</p>
          </div>
          
          <!-- Service history list would go here -->
          <div class="border-t border-gray-200 px-4 py-5 sm:p-6">
            <p class="text-center text-gray-500 py-8">No services ordered yet.</p>
            
            <div class="mt-4 text-center">
              <router-link :to="{ name: 'Services' }" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                Browse Services
              </router-link>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
