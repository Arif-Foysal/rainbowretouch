<template>
  <div class="reports-page">
    <div class="header mb-6">
      <h1 class="text-3xl font-bold text-gray-900">Reports</h1>
      <p class="text-gray-600 mt-2">Generate and view detailed business reports</p>
    </div>

    <!-- Report Filters -->
    <div class="bg-white p-6 rounded-lg shadow-sm border mb-6">
      <h3 class="text-lg font-semibold mb-4">Report Filters</h3>
      <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-2">Date Range</label>
          <select class="w-full p-2 border border-gray-300 rounded-md">
            <option>Last 7 days</option>
            <option>Last 30 days</option>
            <option>Last 3 months</option>
            <option>Last year</option>
            <option>Custom range</option>
          </select>
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-2">Service Type</label>
          <select class="w-full p-2 border border-gray-300 rounded-md">
            <option>All Services</option>
            <option>Photo Retouching</option>
            <option>Background Removal</option>
            <option>E-commerce Editing</option>
            <option>Digital Marketing</option>
          </select>
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-2">Status</label>
          <select class="w-full p-2 border border-gray-300 rounded-md">
            <option>All Statuses</option>
            <option>Completed</option>
            <option>In Progress</option>
            <option>Pending</option>
            <option>Cancelled</option>
          </select>
        </div>
      </div>
      <div class="mt-4">
        <button class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700">
          Generate Report
        </button>
      </div>
    </div>

    <!-- Available Reports -->
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

      <div class="bg-white p-6 rounded-lg shadow-sm border">
        <h3 class="text-lg font-semibold mb-2">Financial Report</h3>
        <p class="text-gray-600 mb-4">Revenue, expenses, and profit analysis</p>
        <button class="w-full bg-green-600 text-white py-2 rounded-md hover:bg-green-700">
          Download PDF
        </button>
      </div>

      <div class="bg-white p-6 rounded-lg shadow-sm border">
        <h3 class="text-lg font-semibold mb-2">Order Summary</h3>
        <p class="text-gray-600 mb-4">Complete order history and statistics</p>
        <button class="w-full bg-green-600 text-white py-2 rounded-md hover:bg-green-700">
          Download PDF
        </button>
      </div>

      <div class="bg-white p-6 rounded-lg shadow-sm border">
        <h3 class="text-lg font-semibold mb-2">Custom Report</h3>
        <p class="text-gray-600 mb-4">Create your own custom report</p>
        <button class="w-full bg-blue-600 text-white py-2 rounded-md hover:bg-blue-700">
          Create Report
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
// Reports logic can be added here
</script>

<style scoped>
.reports-page {
  padding: 2rem;
  max-width: 1200px;
  margin: 0 auto;
}
</style>
