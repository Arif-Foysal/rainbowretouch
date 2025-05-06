<template>
    <section class="py-16 px-4 max-w-7xl mx-auto">
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
          <!-- Service Icon (placeholder) -->
          <div class="h-48 bg-gray-100 flex items-center justify-center">
            <div class="w-20 h-20 rounded-full bg-red-50 flex items-center justify-center">
              <component :is="getServiceIcon(service.name)" class="w-10 h-10 text-red-500" />
            </div>
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
              class="w-full py-3 px-4 bg-transparent border border-red-500 text-red-500 rounded-md font-medium tracking-wide hover:bg-red-500 hover:text-white transition-all duration-300 focus:outline-none focus:ring-2 focus:ring-red-300 focus:ring-offset-2"
              aria-label="Read more about the ${service.name} service"
            >
              READ MORE
            </button>
          </div>
        </div>
      </div>
      <br>
      <br>
      <div class="flex justify-center items-center">
        <button 
              class="py-3 px-4 bg-transparent border border-red-500 text-red-500 rounded-md font-medium tracking-wide hover:bg-red-500 hover:text-white transition-all duration-300 focus:outline-none focus:ring-2 focus:ring-red-300 focus:ring-offset-2"
              aria-label="Read more about the ${service.name} service"
            >
              ALL SERVICES
            </button>
      </div>
    </section>
  </template>
  
  <script setup>
  import { ref } from 'vue';
  import { Camera, User, UserCheck, Baby, Heart, Crown } from 'lucide-vue-next';
  
  // Services data
  const services = ref([
    { name: 'HEADSHOT', price: 3.00 },
    { name: 'PORTRAIT', price: 1.50 },
    { name: 'MODEL', price: 1.00 },
    { name: 'E-Commerce Photo Editing', price: 1.30 },
    { name: 'Background Removal', price: 1.20 },
    { name: 'Photo Retouching', price: 1.50 }
  ]);
  
  // Function to get the appropriate icon for each service
  const getServiceIcon = (serviceName) => {
    switch (serviceName) {
      case 'HEADSHOT':
        return User;
      case 'PORTRAIT':
        return UserCheck;
      case 'MODEL':
        return Camera;
      case 'E-Commerce Photo Editing':
        return Baby;
      case 'Background Removal':
        return Heart;
      case 'Photo Retouching':
        return Crown;
      default:
        return Camera;
    }
  };
  </script>
  
  <style scoped>
  /* Additional custom styles can be added here if needed */
  </style>