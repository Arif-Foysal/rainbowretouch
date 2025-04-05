<template>
    <div class="max-w-6xl mx-auto p-4">
      <h2 class=" text-5xl font-bold text-center mb-10 text-gray-800">Bulk Image Editing Discounts</h2>
      
      <div class="grid md:grid-cols-2 gap-8">
        <!-- Premium Tier Card -->
        <div class="bg-indigo-500 rounded-2xl p-8 text-white shadow-lg transform transition-all duration-300 hover:shadow-xl hover:scale-[1.02] card-animation">
          <h3 class="text-4xl font-bold mb-6">🔥 Special Offer!</h3>
          
          <div class="text-2xl font-medium mb-8">
            Get <span class="text-yellow-300 font-bold text-3xl">20% OFF</span> your next purchase!
          </div>
          
          <div class="mb-4 text-xl">Perfect for high-volume clients:</div>
          <ul class="space-y-2 mb-8">
            <li class="flex items-center">
              <span class="mr-2">•</span>
              <span>Over 1000 Images/Month</span>
            </li>
            <li class="flex items-center">
              <span class="mr-2">•</span>
              <span>Dedicated account manager</span>
            </li>
            <li class="flex items-center">
              <span class="mr-2">•</span>
              <span>Priority delivery timelines</span>
            </li>
          </ul>
          
          <div class="text-xl mb-3">Use coupon code:</div>
          <div class="flex bg-white rounded-lg overflow-hidden mb-6">
            <div class="flex-grow p-4 text-gray-800 font-mono text-xl font-bold">PREMIUM20</div>
            <button @click="copyCode('PREMIUM20')" class="bg-indigo-700 hover:bg-indigo-800 text-white px-6 py-4 transition-colors duration-300">
              Copy
            </button>
          </div>
          
          <div class="mt-4 text-lg">
            Valid until December 31, 2025
            <div class="text-sm opacity-80 mt-1">Terms and conditions apply.</div>
          </div>
        </div>
        
        <!-- Standard Tier Card -->
        <div class="bg-red-500 rounded-2xl p-8 text-white shadow-lg transform transition-all duration-300 hover:shadow-xl hover:scale-[1.02] card-animation">
          <h3 class="text-4xl font-bold mb-6">🔥 Special Offer!</h3>
          
          <div class="text-2xl font-medium mb-8">
            Get <span class="text-yellow-300 font-bold text-3xl">10% OFF</span> your next purchase!
          </div>
          
          <div class="mb-4 text-xl">Perfect for high-volume clients:</div>
          <ul class="space-y-2 mb-8">
            <li class="flex items-center">
              <span class="mr-2">•</span>
              <span>Over 500 Images/Month</span>
            </li>
            <li class="flex items-center">
              <span class="mr-2">•</span>
              <span>Dedicated account manager</span>
            </li>
            <li class="flex items-center">
              <span class="mr-2">•</span>
              <span>Priority delivery timelines</span>
            </li>
          </ul>
          
          <div class="text-xl mb-3">Use coupon code:</div>
          <div class="flex bg-white rounded-lg overflow-hidden mb-6">
            <div class="flex-grow p-4 text-gray-800 font-mono text-xl font-bold">STANDARD10</div>
            <button @click="copyCode('STANDARD10')" class="bg-indigo-700 hover:bg-indigo-800 text-white px-6 py-4 transition-colors duration-300">
              Copy
            </button>
          </div>
          
          <div class="mt-4 text-lg">
            Valid until December 31, 2025
            <div class="text-sm opacity-80 mt-1">Terms and conditions apply.</div>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script setup>
  const copyCode = (code) => {
    navigator.clipboard.writeText(code)
      .then(() => {
        alert(`Coupon code ${code} copied to clipboard!`);
      })
      .catch(err => {
        console.error('Failed to copy: ', err);
      });
  };
  </script>
  
  <style>
  @keyframes cardEntrance {
    from { opacity: 0; transform: translateY(25px); }
    to { opacity: 1; transform: translateY(0); }
  }
  
  .card-animation {
    animation: cardEntrance 0.8s ease-out forwards;
  }
  
  .card-animation:nth-child(1) {
    animation-delay: 0.1s;
  }
  
  .card-animation:nth-child(2) {
    animation-delay: 0.3s;
  }
  </style>