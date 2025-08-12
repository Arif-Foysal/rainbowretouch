<script lang="ts">
export const description
  = "A sidebar that collapses to icons."
export const iframeHeight = "800px"
export const containerClass = "w-full h-full"
</script>

<script setup lang="ts">
import { ref, provide, onMounted, computed } from 'vue'
import AppSidebar from "@/components/AppSidebar.vue"
import {
  Breadcrumb,
  BreadcrumbItem,
  BreadcrumbLink,
  BreadcrumbList,
  BreadcrumbPage,
  BreadcrumbSeparator,
} from "@/components/ui/breadcrumb"
import { Separator } from "@/components/ui/separator"
import {
  SidebarInset,
  SidebarProvider,
  SidebarTrigger,
} from "@/components/ui/sidebar"
import api from '@/services/api'
import authService from '@/services/auth'

// Current active section
const activeSection = ref('overview')

// Orders/Contacts data
const contacts = ref([])
const loading = ref(false)
const error = ref(null)

// Provide the active section to child components
provide('activeSection', activeSection)

// Function to change section
const changeSection = async (section: string) => {
  activeSection.value = section
  
  // Fetch contacts data when orders section is opened
  if (section === 'orders') {
    await fetchContacts()
  }
}

// Provide the change function to child components
provide('changeSection', changeSection)

// Function to fetch contacts from API
const fetchContacts = async () => {
  try {
    loading.value = true
    error.value = null
    
    // Check if user is authenticated
    if (!authService.isAuthenticated()) {
      error.value = 'Please log in to view orders'
      return
    }
    
    const response = await api.get('/contacts')
    contacts.value = response.data
    
  } catch (err) {
    console.error('Error fetching contacts:', err)
    error.value = err.response?.data?.message || 'Failed to load orders'
    
    // If 401 error, user might need to re-authenticate
    if (err.response?.status === 401) {
      error.value = 'Authentication expired. Please log in again.'
    }
  } finally {
    loading.value = false
  }
}

// Computed properties for contact statistics
const contactStats = computed(() => {
  const total = contacts.value.length
  const newContacts = contacts.value.filter(c => c.status === 'new').length
  const inProgress = contacts.value.filter(c => c.status === 'in_progress').length
  const completed = contacts.value.filter(c => c.status === 'completed').length
  
  return { total, new: newContacts, inProgress, completed }
})

// Function to format date
const formatDate = (dateString) => {
  return new Date(dateString).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  })
}

// Function to get status color
const getStatusColor = (status) => {
  switch (status) {
    case 'new':
      return 'bg-orange-100 text-orange-800'
    case 'in_progress':
      return 'bg-blue-100 text-blue-800'
    case 'completed':
      return 'bg-green-100 text-green-800'
    default:
      return 'bg-gray-100 text-gray-800'
  }
}

// Function to get section title
const getSectionTitle = (section: string) => {
  const titles: Record<string, string> = {
    overview: 'Dashboard Overview',
    analytics: 'Analytics',
    reports: 'Reports',
    orders: 'Orders Management',
    users: 'Users Management',
    settings: 'Settings'
  }
  return titles[section] || 'Dashboard'
}

// Action functions for orders
const viewOrder = (contact) => {
  // Show order details in a modal or navigate to detail view
  alert(`Viewing order #${contact.id} for ${contact.name}\n\nService: ${contact.service}\nMessage: ${contact.message}`)
}

const editOrder = (contact) => {
  // Open edit form or modal
  console.log('Editing order:', contact)
  alert(`Edit functionality for order #${contact.id} - ${contact.name}`)
}

const deleteOrder = async (contactId) => {
  if (confirm('Are you sure you want to delete this order?')) {
    try {
      await api.delete(`/contacts/${contactId}`)
      // Refresh the contacts list
      await fetchContacts()
      alert('Order deleted successfully')
    } catch (err) {
      console.error('Error deleting order:', err)
      alert('Failed to delete order')
    }
  }
}

// Load contacts on component mount if orders section is active
onMounted(() => {
  if (activeSection.value === 'orders') {
    fetchContacts()
  }
})
</script>

<template class="mt-4">
  <SidebarProvider class="bg-bl">
    <AppSidebar />
    <SidebarInset>
      <header class="flex h-16 shrink-0 items-center gap-2 transition-[width,height] ease-linear group-has-[[data-collapsible=icon]]/sidebar-wrapper:h-12">
        <div class="flex items-center gap-2 px-4">
          <SidebarTrigger class="-ml-1" />
          <Separator orientation="vertical" class="mr-2 h-4" />
          <Breadcrumb>
            <BreadcrumbList>
              <BreadcrumbItem class="hidden md:block">
                <BreadcrumbLink href="#">
                  Rainbow Retouch Admin
                </BreadcrumbLink>
              </BreadcrumbItem>
              <BreadcrumbSeparator class="hidden md:block" />
              <BreadcrumbItem>
                <BreadcrumbPage>{{ getSectionTitle(activeSection) }}</BreadcrumbPage>
              </BreadcrumbItem>
            </BreadcrumbList>
          </Breadcrumb>
        </div>
      </header>
      <div class="flex flex-1 flex-col gap-4 p-4 pt-0">
        <!-- Dashboard Overview -->
        <div v-if="activeSection === 'overview'" class="space-y-6">
          <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            <div class="bg-white p-6 rounded-lg shadow-sm border">
              <h3 class="text-sm font-medium text-gray-500">Total Orders</h3>
              <p class="text-2xl font-bold text-gray-900 mt-2">1,234</p>
              <span class="text-green-600 text-sm">+12% from last month</span>
            </div>
            <div class="bg-white p-6 rounded-lg shadow-sm border">
              <h3 class="text-sm font-medium text-gray-500">Revenue</h3>
              <p class="text-2xl font-bold text-gray-900 mt-2">$45,678</p>
              <span class="text-green-600 text-sm">+8% from last month</span>
            </div>
            <div class="bg-white p-6 rounded-lg shadow-sm border">
              <h3 class="text-sm font-medium text-gray-500">Active Clients</h3>
              <p class="text-2xl font-bold text-gray-900 mt-2">567</p>
              <span class="text-blue-600 text-sm">+3% from last month</span>
            </div>
            <div class="bg-white p-6 rounded-lg shadow-sm border">
              <h3 class="text-sm font-medium text-gray-500">Avg. Order Value</h3>
              <p class="text-2xl font-bold text-gray-900 mt-2">$37</p>
              <span class="text-red-600 text-sm">-2% from last month</span>
            </div>
          </div>
          
          <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <div class="bg-white p-6 rounded-lg shadow-sm border">
              <h3 class="text-lg font-semibold mb-4">Recent Orders</h3>
              <div class="space-y-3">
                <div class="flex justify-between items-center p-3 bg-gray-50 rounded">
                  <span class="font-medium">#1001 - Photo Retouching</span>
                  <span class="text-green-600 text-sm font-medium">Completed</span>
                </div>
                <div class="flex justify-between items-center p-3 bg-gray-50 rounded">
                  <span class="font-medium">#1002 - Background Removal</span>
                  <span class="text-blue-600 text-sm font-medium">In Progress</span>
                </div>
                <div class="flex justify-between items-center p-3 bg-gray-50 rounded">
                  <span class="font-medium">#1003 - E-commerce Editing</span>
                  <span class="text-yellow-600 text-sm font-medium">Pending</span>
                </div>
              </div>
            </div>
            
            <div class="bg-white p-6 rounded-lg shadow-sm border">
              <h3 class="text-lg font-semibold mb-4">Service Performance</h3>
              <div class="space-y-4">
                <div class="flex justify-between items-center">
                  <span>Photo Retouching</span>
                  <span class="font-semibold">45%</span>
                </div>
                <div class="w-full bg-gray-200 rounded-full h-2">
                  <div class="bg-blue-600 h-2 rounded-full" style="width: 45%"></div>
                </div>
                <div class="flex justify-between items-center">
                  <span>Background Removal</span>
                  <span class="font-semibold">30%</span>
                </div>
                <div class="w-full bg-gray-200 rounded-full h-2">
                  <div class="bg-green-600 h-2 rounded-full" style="width: 30%"></div>
                </div>
                <div class="flex justify-between items-center">
                  <span>E-commerce Editing</span>
                  <span class="font-semibold">25%</span>
                </div>
                <div class="w-full bg-gray-200 rounded-full h-2">
                  <div class="bg-purple-600 h-2 rounded-full" style="width: 25%"></div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Analytics Section -->
        <div v-if="activeSection === 'analytics'" class="space-y-6">
          <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            <div class="bg-white p-6 rounded-lg shadow-sm border">
              <h3 class="text-sm font-medium text-gray-500">Total Orders</h3>
              <p class="text-2xl font-bold text-gray-900 mt-2">1,234</p>
              <span class="text-green-600 text-sm">+12% from last month</span>
            </div>
            <div class="bg-white p-6 rounded-lg shadow-sm border">
              <h3 class="text-sm font-medium text-gray-500">Revenue</h3>
              <p class="text-2xl font-bold text-gray-900 mt-2">$45,678</p>
              <span class="text-green-600 text-sm">+8% from last month</span>
            </div>
            <div class="bg-white p-6 rounded-lg shadow-sm border">
              <h3 class="text-sm font-medium text-gray-500">Active Clients</h3>
              <p class="text-2xl font-bold text-gray-900 mt-2">567</p>
              <span class="text-blue-600 text-sm">+3% from last month</span>
            </div>
            <div class="bg-white p-6 rounded-lg shadow-sm border">
              <h3 class="text-sm font-medium text-gray-500">Avg. Order Value</h3>
              <p class="text-2xl font-bold text-gray-900 mt-2">$37</p>
              <span class="text-red-600 text-sm">-2% from last month</span>
            </div>
          </div>
          
          <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <div class="bg-white p-6 rounded-lg shadow-sm border">
              <h3 class="text-lg font-semibold mb-4">Revenue Over Time</h3>
              <div class="h-64 bg-gray-100 rounded flex items-center justify-center">
                <p class="text-gray-500">Chart will be displayed here</p>
              </div>
            </div>
            <div class="bg-white p-6 rounded-lg shadow-sm border">
              <h3 class="text-lg font-semibold mb-4">Service Performance</h3>
              <div class="space-y-4">
                <div class="flex justify-between items-center">
                  <span>Photo Retouching</span>
                  <span class="font-semibold">45%</span>
                </div>
                <div class="flex justify-between items-center">
                  <span>Background Removal</span>
                  <span class="font-semibold">30%</span>
                </div>
                <div class="flex justify-between items-center">
                  <span>E-commerce Editing</span>
                  <span class="font-semibold">15%</span>
                </div>
                <div class="flex justify-between items-center">
                  <span>Digital Marketing</span>
                  <span class="font-semibold">10%</span>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Reports Section -->
        <div v-if="activeSection === 'reports'" class="space-y-6">
          <div class="bg-white p-6 rounded-lg shadow-sm border">
            <h3 class="text-lg font-semibold mb-4">Report Filters</h3>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Date Range</label>
                <select class="w-full p-2 border border-gray-300 rounded-md">
                  <option>Last 7 days</option>
                  <option>Last 30 days</option>
                  <option>Last 3 months</option>
                  <option>Last year</option>
                </select>
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Service Type</label>
                <select class="w-full p-2 border border-gray-300 rounded-md">
                  <option>All Services</option>
                  <option>Photo Retouching</option>
                  <option>Background Removal</option>
                </select>
              </div>
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Status</label>
                <select class="w-full p-2 border border-gray-300 rounded-md">
                  <option>All Statuses</option>
                  <option>Completed</option>
                  <option>In Progress</option>
                </select>
              </div>
            </div>
            <div class="mt-4">
              <button class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700">
                Generate Report
              </button>
            </div>
          </div>
          
          <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <div class="bg-white p-6 rounded-lg shadow-sm border">
              <h3 class="text-lg font-semibold mb-2">Sales Report</h3>
              <p class="text-gray-600 mb-4">Detailed breakdown of sales performance</p>
              <button class="w-full bg-green-600 text-white py-2 rounded-md hover:bg-green-700">
                Download PDF
              </button>
            </div>
            <div class="bg-white p-6 rounded-lg shadow-sm border">
              <h3 class="text-lg font-semibold mb-2">Client Report</h3>
              <p class="text-gray-600 mb-4">Client activity and engagement metrics</p>
              <button class="w-full bg-green-600 text-white py-2 rounded-md hover:bg-green-700">
                Download PDF
              </button>
            </div>
            <div class="bg-white p-6 rounded-lg shadow-sm border">
              <h3 class="text-lg font-semibold mb-2">Service Performance</h3>
              <p class="text-gray-600 mb-4">Performance metrics for each service</p>
              <button class="w-full bg-green-600 text-white py-2 rounded-md hover:bg-green-700">
                Download PDF
              </button>
            </div>
          </div>
        </div>

        <!-- Orders Section with Real API Data -->
        <div v-if="activeSection === 'orders'" class="space-y-6">
          <div class="flex justify-between items-center">
            <h2 class="text-2xl font-bold text-gray-900">Orders Management</h2>
            <div class="flex gap-2">
              <button @click="fetchContacts" class="bg-gray-500 text-white px-4 py-2 rounded-md hover:bg-gray-600">
                 Refresh
              </button>
              <button class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700">
                + New Order
              </button>
            </div>
          </div>
          
          <!-- Statistics Cards with Real Data -->
          <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
            <div class="bg-white p-4 rounded-lg shadow-sm border">
              <h3 class="text-sm font-medium text-gray-500">Total Orders</h3>
              <p class="text-2xl font-bold text-gray-900 mt-1">{{ contactStats.total }}</p>
            </div>
            <div class="bg-white p-4 rounded-lg shadow-sm border">
              <h3 class="text-sm font-medium text-gray-500">New</h3>
              <p class="text-2xl font-bold text-orange-600 mt-1">{{ contactStats.new }}</p>
            </div>
            <div class="bg-white p-4 rounded-lg shadow-sm border">
              <h3 class="text-sm font-medium text-gray-500">In Progress</h3>
              <p class="text-2xl font-bold text-blue-600 mt-1">{{ contactStats.inProgress }}</p>
            </div>
            <div class="bg-white p-4 rounded-lg shadow-sm border">
              <h3 class="text-sm font-medium text-gray-500">Completed</h3>
              <p class="text-2xl font-bold text-green-600 mt-1">{{ contactStats.completed }}</p>
            </div>
          </div>

          <!-- Error State -->
          <div v-if="error" class="bg-red-50 border border-red-200 rounded-lg p-4">
            <div class="flex">
              <div class="flex-shrink-0">
                <svg class="h-5 w-5 text-red-400" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
                </svg>
              </div>
              <div class="ml-3">
                <h3 class="text-sm font-medium text-red-800">Error loading orders</h3>
                <p class="text-sm text-red-700 mt-1">{{ error }}</p>
                <button @click="fetchContacts" class="mt-2 bg-red-600 text-white px-3 py-1 rounded text-sm hover:bg-red-700">
                  Try Again
                </button>
              </div>
            </div>
          </div>

          <!-- Loading State -->
          <div v-if="loading" class="bg-white rounded-lg shadow-sm border p-8">
            <div class="flex items-center justify-center">
              <div class="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
              <span class="ml-3 text-gray-600">Loading orders...</span>
            </div>
          </div>

          <!-- Orders Table with Real Data -->
          <div v-else-if="!error" class="bg-white rounded-lg shadow-sm border overflow-hidden">
            <div class="p-4 border-b">
              <div class="flex gap-4 items-center">
                <input type="text" placeholder="Search orders..." class="flex-1 p-2 border border-gray-300 rounded-md">
                <select class="p-2 border border-gray-300 rounded-md">
                  <option>All Statuses</option>
                  <option>new</option>
                  <option>in_progress</option>
                  <option>completed</option>
                </select>
              </div>
            </div>
            
            <div v-if="contacts.length === 0" class="p-8 text-center text-gray-500">
              <p>No orders found</p>
            </div>
            
            <div v-else class="overflow-x-auto">
              <table class="w-full">
                <thead class="bg-gray-50">
                  <tr>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Order ID</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Client</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Email</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Service</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Status</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Date</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-200">
                  <tr v-for="contact in contacts" :key="contact.id">
                    <td class="px-6 py-4 text-sm font-medium text-gray-900">#{{ contact.id }}</td>
                    <td class="px-6 py-4 text-sm text-gray-900">{{ contact.name }}</td>
                    <td class="px-6 py-4 text-sm text-gray-900">{{ contact.email }}</td>
                    <td class="px-6 py-4 text-sm text-gray-900">{{ contact.service }}</td>
                    <td class="px-6 py-4">
                      <span :class="getStatusColor(contact.status)" class="px-2 py-1 text-xs font-semibold rounded-full capitalize">
                        {{ contact.status.replace('_', ' ') }}
                      </span>
                    </td>
                    <td class="px-6 py-4 text-sm text-gray-500">{{ formatDate(contact.created_at) }}</td>
                    <td class="px-6 py-4 text-sm">
                      <button class="text-blue-600 hover:text-blue-900 mr-3" @click="viewOrder(contact)">View</button>
                      <button class="text-green-600 hover:text-green-900 mr-3" @click="editOrder(contact)">Edit</button>
                      <button class="text-red-600 hover:text-red-900" @click="deleteOrder(contact.id)">Delete</button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>

        <!-- Users Section -->
        <div v-if="activeSection === 'users'" class="space-y-6">
          <div class="flex justify-between items-center">
            <h2 class="text-2xl font-bold text-gray-900">Users Management</h2>
            <button class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700">
              + Add User
            </button>
          </div>
          
          <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
            <div class="bg-white p-4 rounded-lg shadow-sm border">
              <h3 class="text-sm font-medium text-gray-500">Total Users</h3>
              <p class="text-2xl font-bold text-gray-900 mt-1">567</p>
            </div>
            <div class="bg-white p-4 rounded-lg shadow-sm border">
              <h3 class="text-sm font-medium text-gray-500">Clients</h3>
              <p class="text-2xl font-bold text-blue-600 mt-1">489</p>
            </div>
            <div class="bg-white p-4 rounded-lg shadow-sm border">
              <h3 class="text-sm font-medium text-gray-500">Staff</h3>
              <p class="text-2xl font-bold text-green-600 mt-1">12</p>
            </div>
            <div class="bg-white p-4 rounded-lg shadow-sm border">
              <h3 class="text-sm font-medium text-gray-500">Active Today</h3>
              <p class="text-2xl font-bold text-purple-600 mt-1">78</p>
            </div>
          </div>

          <div class="bg-white rounded-lg shadow-sm border overflow-hidden">
            <div class="p-4 border-b">
              <div class="flex gap-4 items-center">
                <input type="text" placeholder="Search users..." class="flex-1 p-2 border border-gray-300 rounded-md">
                <select class="p-2 border border-gray-300 rounded-md">
                  <option>All Roles</option>
                  <option>Admin</option>
                  <option>Staff</option>
                  <option>Client</option>
                </select>
              </div>
            </div>
            <div class="overflow-x-auto">
              <table class="w-full">
                <thead class="bg-gray-50">
                  <tr>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">User</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Email</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Role</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Status</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-200">
                  <tr>
                    <td class="px-6 py-4">
                      <div class="flex items-center">
                        <div class="w-8 h-8 bg-gray-300 rounded-full mr-3"></div>
                        <span class="text-sm font-medium text-gray-900">John Doe</span>
                      </div>
                    </td>
                    <td class="px-6 py-4 text-sm text-gray-900">john@example.com</td>
                    <td class="px-6 py-4"><span class="px-2 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-800">Client</span></td>
                    <td class="px-6 py-4"><span class="px-2 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-800">Active</span></td>
                    <td class="px-6 py-4 text-sm">
                      <button class="text-blue-600 hover:text-blue-900 mr-3">Edit</button>
                      <button class="text-red-600 hover:text-red-900">Suspend</button>
                    </td>
                  </tr>
                  <tr>
                    <td class="px-6 py-4">
                      <div class="flex items-center">
                        <div class="w-8 h-8 bg-gray-300 rounded-full mr-3"></div>
                        <span class="text-sm font-medium text-gray-900">Jane Smith</span>
                      </div>
                    </td>
                    <td class="px-6 py-4 text-sm text-gray-900">jane@rainbowretouch.com</td>
                    <td class="px-6 py-4"><span class="px-2 py-1 text-xs font-semibold rounded-full bg-blue-100 text-blue-800">Staff</span></td>
                    <td class="px-6 py-4"><span class="px-2 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-800">Active</span></td>
                    <td class="px-6 py-4 text-sm">
                      <button class="text-blue-600 hover:text-blue-900 mr-3">Edit</button>
                      <button class="text-red-600 hover:text-red-900">Suspend</button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>

        <!-- Settings Section -->
        <div v-if="activeSection === 'settings'" class="space-y-6">
          <h2 class="text-2xl font-bold text-gray-900">Settings</h2>
          
          <div class="grid grid-cols-1 lg:grid-cols-4 gap-6">
            <div class="lg:col-span-1">
              <nav class="bg-white rounded-lg shadow-sm border p-4">
                <ul class="space-y-2">
                  <li><button class="w-full text-left px-3 py-2 rounded-md bg-blue-50 text-blue-700 border border-blue-200">General</button></li>
                  <li><button class="w-full text-left px-3 py-2 rounded-md text-gray-700 hover:bg-gray-50 border">Security</button></li>
                  <li><button class="w-full text-left px-3 py-2 rounded-md text-gray-700 hover:bg-gray-50 border">Notifications</button></li>
                  <li><button class="w-full text-left px-3 py-2 rounded-md text-gray-700 hover:bg-gray-50 border">Billing</button></li>
                </ul>
              </nav>
            </div>
            
            <div class="lg:col-span-3">
              <div class="bg-white rounded-lg shadow-sm border p-6">
                <h3 class="text-xl font-semibold mb-4">General Settings</h3>
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
                    <label class="block text-sm font-medium text-gray-700 mb-2">Timezone</label>
                    <select class="w-full p-3 border border-gray-300 rounded-md">
                      <option>UTC-5 (Eastern Time)</option>
                      <option>UTC-6 (Central Time)</option>
                      <option>UTC-7 (Mountain Time)</option>
                      <option>UTC-8 (Pacific Time)</option>
                    </select>
                  </div>
                  <div class="pt-6 border-t">
                    <button class="bg-blue-600 text-white px-6 py-2 rounded-md hover:bg-blue-700">
                      Save Changes
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </SidebarInset>
  </SidebarProvider>
</template>

