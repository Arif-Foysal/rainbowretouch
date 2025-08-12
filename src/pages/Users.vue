<template>
  <div class="users-page">
    <div class="header mb-6 flex justify-between items-center">
      <div>
        <h1 class="text-3xl font-bold text-gray-900">Users Management</h1>
        <p class="text-gray-600 mt-2">Manage clients, staff, and user permissions</p>
      </div>
      <button class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700">
        + Add User
      </button>
    </div>

    <!-- User Statistics -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
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

    <!-- Filters and Search -->
    <div class="bg-white p-4 rounded-lg shadow-sm border mb-6">
      <div class="flex flex-wrap gap-4 items-center">
        <div class="flex-1 min-w-64">
          <input 
            type="text" 
            placeholder="Search users..." 
            class="w-full p-2 border border-gray-300 rounded-md"
          >
        </div>
        <select class="p-2 border border-gray-300 rounded-md">
          <option>All Roles</option>
          <option>Admin</option>
          <option>Staff</option>
          <option>Client</option>
        </select>
        <select class="p-2 border border-gray-300 rounded-md">
          <option>All Status</option>
          <option>Active</option>
          <option>Inactive</option>
          <option>Suspended</option>
        </select>
        <button class="bg-gray-600 text-white px-4 py-2 rounded-md hover:bg-gray-700">
          Filter
        </button>
      </div>
    </div>

    <!-- Users Table -->
    <div class="bg-white rounded-lg shadow-sm border overflow-hidden">
      <div class="overflow-x-auto">
        <table class="w-full">
          <thead class="bg-gray-50">
            <tr>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                User
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Email
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Role
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Status
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Orders
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Joined
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Actions
              </th>
            </tr>
          </thead>
          <tbody class="bg-white divide-y divide-gray-200">
            <tr v-for="user in users" :key="user.id">
              <td class="px-6 py-4 whitespace-nowrap">
                <div class="flex items-center">
                  <div class="flex-shrink-0 h-10 w-10">
                    <img class="h-10 w-10 rounded-full" :src="user.avatar" :alt="user.name">
                  </div>
                  <div class="ml-4">
                    <div class="text-sm font-medium text-gray-900">{{ user.name }}</div>
                  </div>
                </div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                {{ user.email }}
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <span :class="getRoleClass(user.role)" class="px-2 py-1 text-xs font-semibold rounded-full">
                  {{ user.role }}
                </span>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <span :class="getStatusClass(user.status)" class="px-2 py-1 text-xs font-semibold rounded-full">
                  {{ user.status }}
                </span>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                {{ user.orders }}
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                {{ user.joinDate }}
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                <button class="text-blue-600 hover:text-blue-900 mr-3">Edit</button>
                <button class="text-green-600 hover:text-green-900 mr-3">View</button>
                <button class="text-red-600 hover:text-red-900">Suspend</button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Pagination -->
    <div class="mt-6 flex justify-between items-center">
      <span class="text-sm text-gray-700">Showing 1 to 10 of 567 users</span>
      <div class="flex space-x-2">
        <button class="px-3 py-1 border border-gray-300 rounded-md text-sm hover:bg-gray-50">Previous</button>
        <button class="px-3 py-1 bg-blue-600 text-white rounded-md text-sm">1</button>
        <button class="px-3 py-1 border border-gray-300 rounded-md text-sm hover:bg-gray-50">2</button>
        <button class="px-3 py-1 border border-gray-300 rounded-md text-sm hover:bg-gray-50">3</button>
        <button class="px-3 py-1 border border-gray-300 rounded-md text-sm hover:bg-gray-50">Next</button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

// Sample users data
const users = ref([
  { 
    id: 1, 
    name: 'John Doe', 
    email: 'john@example.com', 
    role: 'Client', 
    status: 'Active', 
    orders: 15, 
    joinDate: '2024-01-15',
    avatar: 'https://via.placeholder.com/40'
  },
  { 
    id: 2, 
    name: 'Jane Smith', 
    email: 'jane@rainbowretouch.com', 
    role: 'Staff', 
    status: 'Active', 
    orders: 0, 
    joinDate: '2023-12-01',
    avatar: 'https://via.placeholder.com/40'
  },
  { 
    id: 3, 
    name: 'Mike Johnson', 
    email: 'mike@example.com', 
    role: 'Client', 
    status: 'Active', 
    orders: 8, 
    joinDate: '2024-01-10',
    avatar: 'https://via.placeholder.com/40'
  },
  { 
    id: 4, 
    name: 'Sarah Wilson', 
    email: 'sarah@example.com', 
    role: 'Client', 
    status: 'Inactive', 
    orders: 3, 
    joinDate: '2023-11-20',
    avatar: 'https://via.placeholder.com/40'
  },
  { 
    id: 5, 
    name: 'Admin User', 
    email: 'admin@rainbowretouch.com', 
    role: 'Admin', 
    status: 'Active', 
    orders: 0, 
    joinDate: '2023-01-01',
    avatar: 'https://via.placeholder.com/40'
  },
])

const getRoleClass = (role) => {
  switch (role) {
    case 'Admin':
      return 'bg-purple-100 text-purple-800'
    case 'Staff':
      return 'bg-blue-100 text-blue-800'
    case 'Client':
      return 'bg-green-100 text-green-800'
    default:
      return 'bg-gray-100 text-gray-800'
  }
}

const getStatusClass = (status) => {
  switch (status) {
    case 'Active':
      return 'bg-green-100 text-green-800'
    case 'Inactive':
      return 'bg-gray-100 text-gray-800'
    case 'Suspended':
      return 'bg-red-100 text-red-800'
    default:
      return 'bg-gray-100 text-gray-800'
  }
}
</script>

<style scoped>
.users-page {
  padding: 2rem;
  max-width: 1400px;
  margin: 0 auto;
}
</style>
