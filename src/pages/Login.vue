<template>
  <div class="flex min-h-screen w-full items-center justify-center bg-gray-50">
    <div class="w-full max-w-md space-y-8 rounded-xl bg-white p-8 shadow-lg">
      <!-- Logo and Heading -->
      <div class="text-center">
        <h2 class="mt-6 text-3xl font-bold text-gray-900">Welcome back</h2>
        <p class="mt-2 text-sm text-gray-600">Sign in to your account</p>
      </div>

      <!-- Alert for errors -->
      <div v-if="errorMessage" class="rounded-md bg-red-50 p-4 mb-4">
        <div class="flex">
          <div class="ml-3">
            <h3 class="text-sm font-medium text-red-800">{{ errorMessage }}</h3>
          </div>
        </div>
      </div>

      <!-- Login Form -->
      <form class="mt-8 space-y-6" @submit.prevent="handleLogin">
        <div class="space-y-4 rounded-md">
          <!-- Email Input -->
          <div>
            <label for="email" class="block text-sm font-medium text-gray-700">Email address</label>
            <div class="mt-1">
              <input
                id="email"
                v-model="email"
                type="email"
                required
                class="block w-full appearance-none rounded-md border border-gray-300 px-3 py-2 placeholder-gray-400 shadow-sm focus:border-blue-500 focus:outline-none focus:ring-blue-500 sm:text-sm"
                placeholder="you@example.com"
              />
            </div>
          </div>

          <!-- Password Input -->
          <div>
            <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
            <div class="mt-1 relative">
              <input
                id="password"
                v-model="password"
                :type="showPassword ? 'text' : 'password'"
                required
                class="block w-full appearance-none rounded-md border border-gray-300 px-3 py-2 placeholder-gray-400 shadow-sm focus:border-blue-500 focus:outline-none focus:ring-blue-500 sm:text-sm"
                placeholder="••••••••"
              />
              <button 
                type="button"
                @click="showPassword = !showPassword"
                class="absolute inset-y-0 right-0 flex items-center pr-3 text-gray-400 hover:text-gray-600"
              >
                <span v-if="showPassword">Hide</span>
                <span v-else>Show</span>
              </button>
            </div>
          </div>
        </div>

        <!-- Remember me and Forgot password -->
        <div class="flex items-center justify-between">
          <div class="flex items-center">
            <input
              id="remember-me"
              v-model="rememberMe"
              type="checkbox"
              class="h-4 w-4 rounded border-gray-300 text-blue-600 focus:ring-blue-500"
            />
            <label for="remember-me" class="ml-2 block text-sm text-gray-900">Remember me</label>
          </div>

          <div class="text-sm">
            <a href="#" class="font-medium text-blue-600 hover:text-blue-500">Forgot your password?</a>
          </div>
        </div>

        <!-- Submit Button -->
        <div>
          <button
            type="submit"
            :disabled="isLoading"
            class="group relative flex w-full justify-center rounded-md border border-transparent bg-blue-600 py-2 px-4 text-sm font-medium text-white hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 disabled:opacity-50 disabled:cursor-not-allowed"
          >
            <span v-if="isLoading">
              Signing in...
            </span>
            <span v-else>
              Sign in
            </span>
          </button>
        </div>
      </form>

      <!-- Sign up link -->
      <div class="mt-6 text-center">
        <p class="text-sm text-gray-600">
          Don't have an account?
          <a href="#" class="font-medium text-blue-600 hover:text-blue-500">Sign up</a>
        </p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import authService from '@/services/auth'

const router = useRouter()

// Form data
const email = ref('')
const password = ref('')
const rememberMe = ref(false)
const showPassword = ref(false)

// UI states
const isLoading = ref(false)
const errorMessage = ref('')

// Handle login submission
const handleLogin = async () => {
  isLoading.value = true
  errorMessage.value = ''
  
  try {
    // Use the auth service, which now handles CSRF properly
    const response = await authService.login({
      email: email.value,
      password: password.value
    })
    
    // Store the token and user info
    localStorage.setItem('auth_token', response.data.token)
    localStorage.setItem('user', JSON.stringify(response.data.user))
    
    // Redirect to home or dashboard
    router.push({ name: 'Home' })
  } catch (error) {
    console.error('Login error:', error)
    
    // More detailed error handling
    if (error.response) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx
      console.error('Error data:', error.response.data);
      console.error('Error status:', error.response.status);
      console.error('Error headers:', error.response.headers);
      
      if (error.response.status === 419) {
        errorMessage.value = 'CSRF token mismatch. Please try refreshing the page.';
      } else if (error.response.data && error.response.data.message) {
        errorMessage.value = error.response.data.message;
      } else {
        errorMessage.value = `Server error (${error.response.status})`;
      }
    } else if (error.message) {
      // The error has a message property
      errorMessage.value = error.message;
    } else {
      // Something happened in setting up the request that triggered an Error
      errorMessage.value = 'An error occurred while trying to log in';
    }
  } finally {
    isLoading.value = false
  }
}
</script>

<style scoped>
/* Additional styling if needed */
</style>