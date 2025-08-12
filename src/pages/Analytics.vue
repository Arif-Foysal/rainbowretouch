<template>
  <div class="analytics-page">
    <div class="header mb-6">
      <h1 class="text-3xl font-bold text-gray-900">Analytics Dashboard</h1>
      <p class="text-gray-600 mt-2">Monitor your business performance and insights</p>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
      <!-- Key Metrics Cards -->
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
      <!-- Chart Placeholder -->
      <div class="bg-white p-6 rounded-lg shadow-sm border">
        <h3 class="text-lg font-semibold mb-4">Revenue Over Time</h3>
        <div class="h-64 bg-gray-100 rounded flex items-center justify-center">
          <p class="text-gray-500">Chart will be displayed here</p>
        </div>
      </div>

      <!-- Service Performance -->
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
</template>

<script setup>
// Analytics logic can be added here
</script>

<style scoped>
.analytics-page {
  padding: 2rem;
  max-width: 1200px;
  margin: 0 auto;
}
</style>
