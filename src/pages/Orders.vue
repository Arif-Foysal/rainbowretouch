<template>
  <div class="orders-page">
    <div class="header mb-6 flex justify-between items-center">
      <div>
        <h1 class="text-3xl font-bold text-gray-900">Orders Management</h1>
        <p class="text-gray-600 mt-2">Manage and track all customer orders</p>
      </div>
      <button class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700">
        + New Order
      </button>
    </div>

    <!-- Order Statistics -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
      <div class="bg-white p-4 rounded-lg shadow-sm border">
        <h3 class="text-sm font-medium text-gray-500">Total Orders</h3>
        <p class="text-2xl font-bold text-gray-900 mt-1">1,234</p>
      </div>
      <div class="bg-white p-4 rounded-lg shadow-sm border">
        <h3 class="text-sm font-medium text-gray-500">Pending</h3>
        <p class="text-2xl font-bold text-orange-600 mt-1">45</p>
      </div>
      <div class="bg-white p-4 rounded-lg shadow-sm border">
        <h3 class="text-sm font-medium text-gray-500">In Progress</h3>
        <p class="text-2xl font-bold text-blue-600 mt-1">89</p>
      </div>
      <div class="bg-white p-4 rounded-lg shadow-sm border">
        <h3 class="text-sm font-medium text-gray-500">Completed</h3>
        <p class="text-2xl font-bold text-green-600 mt-1">1,100</p>
      </div>
    </div>

    <!-- Filters and Search -->
    <div class="bg-white p-4 rounded-lg shadow-sm border mb-6">
      <div class="flex flex-wrap gap-4 items-center">
        <div class="flex-1 min-w-64">
          <input 
            type="text" 
            placeholder="Search orders..." 
            class="w-full p-2 border border-gray-300 rounded-md"
          >
        </div>
        <select class="p-2 border border-gray-300 rounded-md">
          <option>All Statuses</option>
          <option>Pending</option>
          <option>In Progress</option>
          <option>Completed</option>
          <option>Cancelled</option>
        </select>
        <select class="p-2 border border-gray-300 rounded-md">
          <option>All Services</option>
          <option>Photo Retouching</option>
          <option>Background Removal</option>
          <option>E-commerce</option>
        </select>
        <button class="bg-gray-600 text-white px-4 py-2 rounded-md hover:bg-gray-700">
          Filter
        </button>
      </div>
    </div>

    <!-- Orders Table -->
    <div class="bg-white rounded-lg shadow-sm border overflow-hidden">
      <div class="overflow-x-auto">
        <table class="w-full">
          <thead class="bg-gray-50">
            <tr>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Order ID
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Client
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Service
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Status
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Amount
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Date
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Actions
              </th>
            </tr>
          </thead>
          <tbody class="bg-white divide-y divide-gray-200">
            <tr v-for="order in orders" :key="order.id">
              <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                #{{ order.id }}
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                {{ order.client }}
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                {{ order.service }}
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <span :class="getStatusClass(order.status)" class="px-2 py-1 text-xs font-semibold rounded-full">
                  {{ order.status }}
                </span>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                ${{ order.amount }}
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                {{ order.date }}
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                <button class="text-blue-600 hover:text-blue-900 mr-3">View</button>
                <button class="text-green-600 hover:text-green-900 mr-3">Edit</button>
                <button class="text-red-600 hover:text-red-900">Delete</button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Pagination -->
    <div class="mt-6 flex justify-between items-center">
      <span class="text-sm text-gray-700">Showing 1 to 10 of 1,234 orders</span>
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

// Sample orders data
const orders = ref([
  { id: '1001', client: 'John Doe', service: 'Photo Retouching', status: 'Completed', amount: '45.00', date: '2024-01-15' },
  { id: '1002', client: 'Jane Smith', service: 'Background Removal', status: 'In Progress', amount: '25.00', date: '2024-01-14' },
  { id: '1003', client: 'Mike Johnson', service: 'E-commerce Editing', status: 'Pending', amount: '65.00', date: '2024-01-13' },
  { id: '1004', client: 'Sarah Wilson', service: 'Digital Marketing', status: 'Completed', amount: '120.00', date: '2024-01-12' },
  { id: '1005', client: 'David Brown', service: 'Photo Retouching', status: 'In Progress', amount: '35.00', date: '2024-01-11' },
])

const getStatusClass = (status) => {
  switch (status) {
    case 'Completed':
      return 'bg-green-100 text-green-800'
    case 'In Progress':
      return 'bg-blue-100 text-blue-800'
    case 'Pending':
      return 'bg-yellow-100 text-yellow-800'
    case 'Cancelled':
      return 'bg-red-100 text-red-800'
    default:
      return 'bg-gray-100 text-gray-800'
  }
}
</script>

<style scoped>
.orders-page {
  padding: 2rem;
  max-width: 1400px;
  margin: 0 auto;
}
</style>
