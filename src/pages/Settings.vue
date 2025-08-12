<template>
  <div class="settings-page">
    <div class="header mb-6">
      <h1 class="text-3xl font-bold text-gray-900">Settings</h1>
      <p class="text-gray-600 mt-2">Manage your application settings and preferences</p>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-4 gap-6">
      <!-- Settings Navigation -->
      <div class="lg:col-span-1">
        <nav class="bg-white rounded-lg shadow-sm border p-4">
          <ul class="space-y-2">
            <li>
              <button 
                @click="activeTab = 'general'" 
                :class="activeTab === 'general' ? 'bg-blue-50 text-blue-700 border-blue-200' : 'text-gray-700 hover:bg-gray-50'"
                class="w-full text-left px-3 py-2 rounded-md border"
              >
                General
              </button>
            </li>
            <li>
              <button 
                @click="activeTab = 'security'" 
                :class="activeTab === 'security' ? 'bg-blue-50 text-blue-700 border-blue-200' : 'text-gray-700 hover:bg-gray-50'"
                class="w-full text-left px-3 py-2 rounded-md border"
              >
                Security
              </button>
            </li>
            <li>
              <button 
                @click="activeTab = 'notifications'" 
                :class="activeTab === 'notifications' ? 'bg-blue-50 text-blue-700 border-blue-200' : 'text-gray-700 hover:bg-gray-50'"
                class="w-full text-left px-3 py-2 rounded-md border"
              >
                Notifications
              </button>
            </li>
            <li>
              <button 
                @click="activeTab = 'billing'" 
                :class="activeTab === 'billing' ? 'bg-blue-50 text-blue-700 border-blue-200' : 'text-gray-700 hover:bg-gray-50'"
                class="w-full text-left px-3 py-2 rounded-md border"
              >
                Billing
              </button>
            </li>
            <li>
              <button 
                @click="activeTab = 'integrations'" 
                :class="activeTab === 'integrations' ? 'bg-blue-50 text-blue-700 border-blue-200' : 'text-gray-700 hover:bg-gray-50'"
                class="w-full text-left px-3 py-2 rounded-md border"
              >
                Integrations
              </button>
            </li>
          </ul>
        </nav>
      </div>

      <!-- Settings Content -->
      <div class="lg:col-span-3">
        <div class="bg-white rounded-lg shadow-sm border p-6">
          
          <!-- General Settings -->
          <div v-if="activeTab === 'general'">
            <h2 class="text-xl font-semibold mb-4">General Settings</h2>
            <div class="space-y-6">
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Company Name</label>
                <input type="text" value="Rainbow Retouch" class="w-full p-3 border border-gray-300 rounded-md">
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Company Email</label>
                <input type="email" value="contact@rainbowretouch.com" class="w-full p-3 border border-gray-300 rounded-md">
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Phone Number</label>
                <input type="tel" value="+1 (555) 123-4567" class="w-full p-3 border border-gray-300 rounded-md">
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Address</label>
                <textarea rows="3" class="w-full p-3 border border-gray-300 rounded-md">123 Main Street, City, State 12345</textarea>
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Timezone</label>
                <select class="w-full p-3 border border-gray-300 rounded-md">
                  <option>UTC-5 (Eastern Time)</option>
                  <option>UTC-6 (Central Time)</option>
                  <option>UTC-7 (Mountain Time)</option>
                  <option>UTC-8 (Pacific Time)</option>
                </select>
              </div>
            </div>
          </div>

          <!-- Security Settings -->
          <div v-if="activeTab === 'security'">
            <h2 class="text-xl font-semibold mb-4">Security Settings</h2>
            <div class="space-y-6">
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Current Password</label>
                <input type="password" class="w-full p-3 border border-gray-300 rounded-md">
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">New Password</label>
                <input type="password" class="w-full p-3 border border-gray-300 rounded-md">
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Confirm New Password</label>
                <input type="password" class="w-full p-3 border border-gray-300 rounded-md">
              </div>
              <div class="border-t pt-6">
                <h3 class="text-lg font-medium mb-3">Two-Factor Authentication</h3>
                <div class="flex items-center justify-between">
                  <span class="text-gray-700">Enable 2FA for added security</span>
                  <label class="relative inline-flex items-center cursor-pointer">
                    <input type="checkbox" class="sr-only peer">
                    <div class="w-11 h-6 bg-gray-200 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-blue-600"></div>
                  </label>
                </div>
              </div>
            </div>
          </div>

          <!-- Notifications Settings -->
          <div v-if="activeTab === 'notifications'">
            <h2 class="text-xl font-semibold mb-4">Notification Settings</h2>
            <div class="space-y-4">
              <div class="flex items-center justify-between">
                <div>
                  <h3 class="font-medium">Email Notifications</h3>
                  <p class="text-sm text-gray-600">Receive notifications via email</p>
                </div>
                <label class="relative inline-flex items-center cursor-pointer">
                  <input type="checkbox" checked class="sr-only peer">
                  <div class="w-11 h-6 bg-gray-200 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-blue-600"></div>
                </label>
              </div>
              <div class="flex items-center justify-between">
                <div>
                  <h3 class="font-medium">New Order Alerts</h3>
                  <p class="text-sm text-gray-600">Get notified when new orders arrive</p>
                </div>
                <label class="relative inline-flex items-center cursor-pointer">
                  <input type="checkbox" checked class="sr-only peer">
                  <div class="w-11 h-6 bg-gray-200 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-blue-600"></div>
                </label>
              </div>
              <div class="flex items-center justify-between">
                <div>
                  <h3 class="font-medium">Weekly Reports</h3>
                  <p class="text-sm text-gray-600">Receive weekly performance reports</p>
                </div>
                <label class="relative inline-flex items-center cursor-pointer">
                  <input type="checkbox" class="sr-only peer">
                  <div class="w-11 h-6 bg-gray-200 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-blue-600"></div>
                </label>
              </div>
            </div>
          </div>

          <!-- Billing Settings -->
          <div v-if="activeTab === 'billing'">
            <h2 class="text-xl font-semibold mb-4">Billing Settings</h2>
            <div class="space-y-6">
              <div class="bg-blue-50 p-4 rounded-lg">
                <h3 class="font-medium text-blue-900">Current Plan: Pro</h3>
                <p class="text-blue-700">$99/month - Unlimited orders and features</p>
              </div>
              <div>
                <h3 class="font-medium mb-3">Payment Method</h3>
                <div class="border rounded-lg p-4">
                  <div class="flex items-center justify-between">
                    <div class="flex items-center">
                      <div class="w-8 h-5 bg-blue-600 rounded mr-3"></div>
                      <span>•••• •••• •••• 1234</span>
                    </div>
                    <button class="text-blue-600 hover:text-blue-800">Change</button>
                  </div>
                </div>
              </div>
              <div>
                <h3 class="font-medium mb-3">Billing History</h3>
                <div class="space-y-2">
                  <div class="flex justify-between items-center p-3 border rounded">
                    <span>January 2024</span>
                    <span class="font-medium">$99.00</span>
                  </div>
                  <div class="flex justify-between items-center p-3 border rounded">
                    <span>December 2023</span>
                    <span class="font-medium">$99.00</span>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Integrations Settings -->
          <div v-if="activeTab === 'integrations'">
            <h2 class="text-xl font-semibold mb-4">Integrations</h2>
            <div class="space-y-4">
              <div class="border rounded-lg p-4">
                <div class="flex items-center justify-between">
                  <div class="flex items-center">
                    <div class="w-10 h-10 bg-green-500 rounded-lg mr-3"></div>
                    <div>
                      <h3 class="font-medium">PayPal</h3>
                      <p class="text-sm text-gray-600">Payment processing</p>
                    </div>
                  </div>
                  <button class="bg-green-600 text-white px-4 py-2 rounded-md text-sm">Connected</button>
                </div>
              </div>
              <div class="border rounded-lg p-4">
                <div class="flex items-center justify-between">
                  <div class="flex items-center">
                    <div class="w-10 h-10 bg-blue-500 rounded-lg mr-3"></div>
                    <div>
                      <h3 class="font-medium">Stripe</h3>
                      <p class="text-sm text-gray-600">Payment processing</p>
                    </div>
                  </div>
                  <button class="border border-gray-300 px-4 py-2 rounded-md text-sm hover:bg-gray-50">Connect</button>
                </div>
              </div>
              <div class="border rounded-lg p-4">
                <div class="flex items-center justify-between">
                  <div class="flex items-center">
                    <div class="w-10 h-10 bg-purple-500 rounded-lg mr-3"></div>
                    <div>
                      <h3 class="font-medium">Slack</h3>
                      <p class="text-sm text-gray-600">Team notifications</p>
                    </div>
                  </div>
                  <button class="border border-gray-300 px-4 py-2 rounded-md text-sm hover:bg-gray-50">Connect</button>
                </div>
              </div>
            </div>
          </div>

          <!-- Save Button -->
          <div class="mt-8 pt-6 border-t">
            <button class="bg-blue-600 text-white px-6 py-2 rounded-md hover:bg-blue-700">
              Save Changes
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const activeTab = ref('general')
</script>

<style scoped>
.settings-page {
  padding: 2rem;
  max-width: 1200px;
  margin: 0 auto;
}
</style>
