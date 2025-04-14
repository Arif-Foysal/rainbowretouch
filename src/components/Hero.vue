<template>
    <section class="relative overflow-hidden">
      <!-- Background image -->
      <div class="absolute inset-0 z-0">
        <img 
          src="https://images.unsplash.com/photo-1557804506-669a67965ba0?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80" 
          alt="" 
          class="w-full h-full object-cover"
          style="filter: brightness(0.5);"
        />
        <div class="absolute inset-0 "></div>
      </div>
      
      <!-- Content container -->
      <div class="container mx-auto px-4 py-20 md:py-32 relative z-10">
        <div class="grid md:grid-cols-2 gap-8 items-center">
          <!-- Left column with promotional text -->
          <div class="text-white">
            <h1 class="text-4xl md:text-8xl font-bold mb-4">High End Photo Retouching</h1>
            <p class="text-lg font-semibold md:text-xl mb-6 text-gray-200">
              Starting with only 1$ per image
            </p>
            <div class="flex flex-wrap gap-4">
              <button class="bg-white text-gray-900 hover:bg-gray-100 px-6 py-3 rounded-md font-medium transition-colors">
                Free Trial
              </button>
              <button class="bg-green-600 text-white hover:bg-green-700 px-6 py-3 rounded-md font-medium transition-colors">
                Order Now
              </button>
            </div>
          </div>
          
          <!-- Right column is empty to maintain the layout -->
          <div></div>
        </div>
      </div>
    </section>
  </template>
  
  <script setup>
  // No additional script needed for this component
  </script>
  
  <style scoped>
  /* Any additional custom styles can go here */
  </style>