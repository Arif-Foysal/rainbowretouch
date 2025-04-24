<template>
    <div class="w-full font-sans">
      <!-- Top Banner -->
      <div class="w-full bg-gradient-to-r from-purple-600 to-pink-500 py-6 text-center shadow-lg">
        <h1 class="text-white text-xl md:text-2xl font-bold tracking-wider px-4">
          Upload your Sample Images and Get them Retouched for free!!
        </h1>
      </div>
      
      <!-- How It Works Section -->
      <div class="w-full bg-gray-50 py-16 px-4">
        <h2 class="text-center text-4xl font-bold text-gray-800 mb-16 relative">
          <span class="relative z-10">HOW IT WORKS?</span>
          <span class="absolute bottom-0 left-1/2 transform -translate-x-1/2 w-24 h-2 bg-yellow-400 -mb-2 z-0"></span>
        </h2>
        
        <!-- Process Flow Container -->
        <div class="max-w-7xl mx-auto relative">
          <!-- Process Flow Line (only on desktop) -->
          <div class="hidden lg:block absolute top-6 left-0 right-0 h-0.5 bg-gray-200">
            <!-- This is the connecting line between steps -->
          </div>
          
          <!-- Steps Grid -->
          <div class="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-5 gap-8">
            <!-- Step 1 -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden transform transition-all duration-300 hover:shadow-xl hover:-translate-y-1">
              <div class="h-2 bg-pink-500"></div>
              <div class="p-6">
                <div class="flex items-center mb-4">
                  <div class="w-12 h-12 rounded-full bg-pink-500 flex items-center justify-center shadow-md relative z-10">
                    <span class="text-white font-bold text-xl">1</span>
                  </div>
                  <div class="ml-4 text-xl font-bold text-gray-700">Services</div>
                </div>
                <p class="text-gray-600 mb-4">
                  Choose the service that suits your needs with a variety of options.
                </p>
                <div class="flex items-center text-rose-600 font-semibold">
                  <span class="mr-2">Diverse services</span>
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
                  </svg>
                </div>
              </div>
            </div>
            
            <!-- Step 2 -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden transform transition-all duration-300 hover:shadow-xl hover:-translate-y-1">
              <div class="h-2 bg-green-500"></div>
              <div class="p-6">
                <div class="flex items-center mb-4">
                  <div class="w-12 h-12 rounded-full bg-green-500 flex items-center justify-center shadow-md relative z-10">
                    <span class="text-white font-bold text-xl">2</span>
                  </div>
                  <div class="ml-4 text-xl font-bold text-gray-700">Register</div>
                </div>
                <p class="text-gray-600 mb-4">
                  Complete registration quickly and efficiently, ensuring you without any hassle.
                </p>
                <div class="flex items-center text-amber-600 font-semibold">
                  <span class="mr-2">Hassle-free registration</span>
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
                  </svg>
                </div>
              </div>
            </div>
            
            <!-- Step 3 -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden transform transition-all duration-300 hover:shadow-xl hover:-translate-y-1">
              <div class="h-2 bg-red-500"></div>
              <div class="p-6">
                <div class="flex items-center mb-4">
                  <div class="w-12 h-12 rounded-full bg-red-500 flex items-center justify-center shadow-md relative z-10">
                    <span class="text-white font-bold text-xl">3</span>
                  </div>
                  <div class="ml-4 text-xl font-bold text-gray-700">Payment</div>
                </div>
                <p class="text-gray-600 mb-4">
                  Make payments securely through a trusted payment system, which prioritizes safety and ease of use.
                </p>
                <div class="flex items-center text-red-600 font-semibold">
                  <span class="mr-2">Secure Payments</span>
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
                  </svg>
                </div>
              </div>
            </div>
            
            <!-- Step 4 -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden transform transition-all duration-300 hover:shadow-xl hover:-translate-y-1">
              <div class="h-2 bg-purple-500"></div>
              <div class="p-6">
                <div class="flex items-center mb-4">
                  <div class="w-12 h-12 rounded-full bg-purple-500 flex items-center justify-center shadow-md relative z-10">
                    <span class="text-white font-bold text-xl">4</span>
                  </div>
                  <div class="ml-4 text-xl font-bold text-gray-700">Upload</div>
                </div>
                <p class="text-gray-600 mb-4">
                  Upload your images individually or in batches, accommodating both single and multiple photos.
                </p>
                <div class="flex items-center text-purple-600 font-semibold">
                  <span class="mr-2">Single or batch upload</span>
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
                  </svg>
                </div>
              </div>
            </div>
            
            <!-- Step 5 -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden transform transition-all duration-300 hover:shadow-xl hover:-translate-y-1">
              <div class="h-2 bg-gray-800"></div>
              <div class="p-6">
                <div class="flex items-center mb-4">
                  <div class="w-12 h-12 rounded-full bg-gray-800 flex items-center justify-center shadow-md relative z-10">
                    <span class="text-white font-bold text-xl">5</span>
                  </div>
                  <div class="ml-4 text-xl font-bold text-gray-700">Download</div>
                </div>
                <p class="text-gray-600 mb-4">
                  Download your professionally retouched images as soon as they are ready.
                </p>
                <div class="flex items-center text-teal-600 font-semibold">
                  <span class="mr-2">Flawless downloads</span>
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
                  </svg>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script setup>
  // Using Vue 3 Composition API
  // No reactive state needed for this static component
  </script>
  
  <style scoped>
  @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
  
  .font-sans {
    font-family: 'Inter', sans-serif;
  }
  </style>