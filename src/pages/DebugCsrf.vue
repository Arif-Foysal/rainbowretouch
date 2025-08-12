<script setup>
import { ref, onMounted } from 'vue';
import axios from 'axios';

const csrfInfo = ref(null);
const error = ref(null);
const loading = ref(true);

onMounted(async () => {
  try {
    // First get CSRF cookie
    await axios.get('http://localhost:8000/sanctum/csrf-cookie', {
      withCredentials: true
    });
    
    // Get all cookies
    const cookies = document.cookie.split('; ').reduce((acc, cookie) => {
      const [key, value] = cookie.split('=');
      acc[key] = value;
      return acc;
    }, {});
    
    // Get CSRF token from cookie
    const xsrfToken = cookies['XSRF-TOKEN'] ? decodeURIComponent(cookies['XSRF-TOKEN']) : null;
    
    // Now call debug endpoint
    const response = await axios.get('http://localhost:8000/api/debug-csrf', {
      withCredentials: true,
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'X-XSRF-TOKEN': xsrfToken
      }
    });
    
    csrfInfo.value = {
      clientCookies: cookies,
      serverResponse: response.data
    };
  } catch (e) {
    error.value = e;
  } finally {
    loading.value = false;
  }
});
</script>

<template>
  <div class="p-8">
    <h1 class="text-2xl font-bold mb-4">CSRF Debug Page</h1>
    
    <div v-if="loading" class="text-gray-700">
      Loading CSRF information...
    </div>
    
    <div v-else-if="error" class="bg-red-50 p-4 rounded-md text-red-800">
      <h2 class="font-bold">Error</h2>
      <pre class="mt-2 whitespace-pre-wrap">{{ error.toString() }}</pre>
      <div v-if="error.response" class="mt-2">
        <h3 class="font-bold">Response:</h3>
        <pre class="mt-1 whitespace-pre-wrap">{{ JSON.stringify(error.response.data, null, 2) }}</pre>
      </div>
    </div>
    
    <div v-else>
      <div class="mb-4">
        <h2 class="text-xl font-bold">Client Cookies</h2>
        <pre class="mt-2 p-4 bg-gray-100 rounded-md whitespace-pre-wrap overflow-auto max-h-40">{{ JSON.stringify(csrfInfo.clientCookies, null, 2) }}</pre>
      </div>
      
      <div>
        <h2 class="text-xl font-bold">Server Response</h2>
        <pre class="mt-2 p-4 bg-gray-100 rounded-md whitespace-pre-wrap overflow-auto max-h-60">{{ JSON.stringify(csrfInfo.serverResponse, null, 2) }}</pre>
      </div>
      
      <div class="mt-8">
        <h2 class="text-xl font-bold">CSRF Status</h2>
        <div class="mt-2">
          <p class="text-green-600 font-bold" v-if="csrfInfo.clientCookies['XSRF-TOKEN'] && csrfInfo.serverResponse.csrf_token">
            ✅ CSRF token is present in both client and server!
          </p>
          <p class="text-red-600 font-bold" v-else>
            ❌ CSRF token mismatch between client and server!
          </p>
          
          <ul class="mt-4 list-disc pl-5">
            <li v-if="csrfInfo.clientCookies['XSRF-TOKEN']" class="text-green-600">
              Client has XSRF-TOKEN cookie
            </li>
            <li v-else class="text-red-600">
              Client is missing XSRF-TOKEN cookie
            </li>
            
            <li v-if="csrfInfo.serverResponse.csrf_token" class="text-green-600">
              Server has csrf_token
            </li>
            <li v-else class="text-red-600">
              Server is missing csrf_token
            </li>
            
            <li v-if="csrfInfo.clientCookies['laravel_session']" class="text-green-600">
              Client has laravel_session cookie
            </li>
            <li v-else class="text-red-600">
              Client is missing laravel_session cookie
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
pre {
  font-family: monospace;
}
</style>
