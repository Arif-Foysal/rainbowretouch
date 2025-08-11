<template>
    <section class="py-4 px-8 md:px-16 lg:px-20  mx-auto">
      <!-- Section Title -->
      <div class="mb-12 text-center">
        <h2 class="text-3xl md:text-4xl font-bold tracking-wider text-gray-800">
          OUR POPULAR SERVICES
        </h2>
        <div class="w-24 h-1 bg-red-500 mx-auto mt-4"></div>
      </div>
  
      <!-- Services Grid -->
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
        <div 
          v-for="(service, index) in services" 
          :key="index"
          class="bg-white rounded-lg overflow-hidden shadow-md hover:shadow-xl transition-all duration-300 hover:scale-[1.02] group"
        >
        <div class="h-54 bg-gray-100 flex items-center justify-center">

          <!-- Using with props -->
          <!--        
            <BeforeAfter
            :beforeImage="service.before" 
            :afterImage="service.after"
            /> -->

            <!-- Without Props -->

            <BeforeAfter/>

          </div>
  
          <!-- Service Content -->
          <div class="p-6">
            <h3 class="text-xl font-bold tracking-wide text-gray-800 mb-2">
              {{ service.name }}
            </h3>
            
            <div class="flex items-center justify-between mb-6">
              <p class="text-2xl font-bold text-red-500">
                <span class="text-sm font-normal text-gray-500 mr-1">USD</span>
                ${{ service.price.toFixed(2) }}
              </p>
              <div class="h-px w-16 bg-gray-200"></div>
            </div>
            
            <button 
              class="w-full py-3 px-4 bg-transparent border-2 border-red-500 text-red-500 rounded-md font-semibold tracking-wide hover:bg-red-500 hover:text-white transition-all duration-300 focus:outline-none focus:ring-2 focus:ring-red-300 focus:ring-offset-2"
              aria-label="Read more about the ${service.name} service"
            >
              READ MORE
            </button>
          </div>
        </div>
      </div>
      <br>
      <br>
      <!-- <div class="flex justify-center items-center">
        <button 
              class="py-3 px-4 bg-transparent border-2 border-red-500 text-red-500 rounded-md font-semibold tracking-wide hover:bg-red-500 hover:text-white transition-all duration-300 focus:outline-none focus:ring-2 focus:ring-red-300 focus:ring-offset-2"
              aria-label="Read more about the ${service.name} service"
            >
              ALL SERVICES
            </button>
      </div> -->
    </section>
  </template>
  
  <script setup>
  import { ref } from 'vue';
  import BeforeAfter from '@/components/BeforeAfter.vue';
  // Services data
  const services = ref([
    { name: 'HEADSHOT', price: 3.00, before: '/src/assets/images/beforeAfter/1-1.jpeg', after: '/src/assets/images/beforeAfter/1-2.jpeg' },
 
    { name: 'PORTRAIT', price: 1.50, before: '/src/assets/images/beforeAfter/1-1.jpeg', after: '/src/assets/images/beforeAfter/1-2.jpeg' },
    { name: 'MODEL', price: 1.00, before: '/src/assets/images/beforeAfter/1-1.jpeg', after: '/src/assets/images/beforeAfter/1-2.jpeg' },
    { name: 'E-Commerce Photo Editing', price: 1.30, before: '/src/assets/images/beforeAfter/1-1.jpeg', after: '/src/assets/images/beforeAfter/1-2.jpeg' },
    { name: 'Background Removal', price: 1.20, before: '/src/assets/images/beforeAfter/1-1.jpeg', after: '/src/assets/images/beforeAfter/1-2.jpeg' },
    { name: 'Photo Retouching', price: 1.50, before: '/src/assets/images/beforeAfter/1-1.jpeg', after: '/src/assets/images/beforeAfter/1-2.jpeg' }
  ]);
  
  // Function to get the appropriate icon for each service

  </script>
  
  <style scoped>
  /* Additional custom styles can be added here if needed */
  </style>