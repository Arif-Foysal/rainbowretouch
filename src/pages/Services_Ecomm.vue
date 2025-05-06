<template>
    <div class="min-h-screen">
      <div class="py-16 bg-gradient-to-b from-white to-gray-50">
        <h2 class="text-4xl font-bold text-center text-gray-900 mb-4">E-Commerce Photo Editing Services</h2>
        <p class="text-center text-gray-600 max-w-2xl mx-auto mb-16">Transform your images with our professional editing services tailored to your specific needs</p>
      </div>
      
      <!-- Service 1: Text Left, Image Right -->
      <div ref="section1" class="py-20 bg-gradient-to-r from-rose-50 to-rose-100">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div class="flex flex-col md:flex-row items-center">
            <div class="w-full md:w-1/2 md:pr-12 mb-8 md:mb-0 overflow-hidden">
              <!-- Title - appears first -->
              <div class="overflow-hidden">
                <h3 ref="title1" class="text-3xl font-bold text-gray-900 mb-4 transform translate-y-16 opacity-0 transition-all duration-700 ease-out">
                 Clothing Photo Editing
                </h3>
              </div>
              
              <!-- Description - appears last -->
              <div class="overflow-hidden">
                <div ref="desc1" class="transform translate-y-16 opacity-0 transition-all duration-700 ease-out" :style="{ transitionDelay: '700ms' }">
                  <p class="text-gray-700 mb-6 text-lg">
                    We will provide an image masking effect to isolate your products from the background accurately. 
                    We can proficiently eliminate the background from your product image and perform necessary 
                    enhancements such as color adjustments, contrast optimization, sharpening, and tonal correction.
                  </p>
                  <ul class="space-y-3">
                    <li class="flex items-start">
                      <span class="text-rose-500 mr-2 text-xl">→</span>
                      <span class="text-gray-700">Image Background Removal Feature to Clean Up Your Images</span>
                    </li>
                    <li class="flex items-start">
                      <span class="text-rose-500 mr-2 text-xl">→</span>
                      <span class="text-gray-700">Our service includes background removal. We will clean up your images</span>
                    </li>
                  </ul>
                  <br>
                  <div class="flex flex-wrap gap-4">
              <button class="bg-white text-gray-900 hover:bg-gray-100 px-6 py-3 rounded-md font-semibold transition-colors">
                Free Trial
              </button>
              <button class="bg-green-600 text-white hover:bg-green-700 px-6 py-3 rounded-md font-semibold transition-colors">
                Order Now
              </button>
            </div>

                </div>
              </div>
            </div>
            
            <!-- Image - appears second -->
            <div ref="image1" class="w-full md:w-1/2 relative opacity-0 scale-95 transition-all duration-700 ease-out" :style="{ transitionDelay: '350ms' }">
              <div class="relative overflow-hidden rounded-xl shadow-2xl h-96 transform transition-all duration-500 hover:scale-[1.02]">
                <transition name="fade" mode="out-in">
                  <img 
                    v-if="serviceStates[0]" 
                    key="after1"
                    src="https://images.unsplash.com/photo-1581044777550-4cfa60707c03?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=686&q=80" 
                    alt="Product after background removal" 
                    class="w-full h-full object-cover"
                  >
                  <img 
                    v-else 
                    key="before1"
                    src="https://images.unsplash.com/photo-1581044777550-4cfa60707c03?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=686&q=80&blur=5" 
                    alt="Product before background removal" 
                    class="w-full h-full object-cover"
                  >
                </transition>
                <div class="absolute bottom-0 left-0 right-0 bg-black bg-opacity-60 backdrop-blur-sm py-3">
                  <transition name="slide-fade" mode="out-in">
                    <p v-if="serviceStates[0]" key="after-text1" class="text-white text-center font-medium text-lg">After</p>
                    <p v-else key="before-text1" class="text-white text-center font-medium text-lg">Before</p>
                  </transition>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <!-- Service 2: Image Left, Text Right -->
      <div ref="section2" class="py-20 bg-gradient-to-r from-purple-50 to-indigo-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div class="flex flex-col md:flex-row-reverse items-center">
            <div class="w-full md:w-1/2 md:pl-12 mb-8 md:mb-0 overflow-hidden">
              <!-- Title - appears first -->
              <div class="overflow-hidden">
                <h3 ref="title2" class="text-3xl font-bold text-gray-900 mb-4 transform translate-y-16 opacity-0 transition-all duration-700 ease-out">
                  Shoe Photo Editing
                </h3>
              </div>
              
              <!-- Description - appears last -->
              <div class="overflow-hidden">
                <div ref="desc2" class="transform translate-y-16 opacity-0 transition-all duration-700 ease-out" :style="{ transitionDelay: '700ms' }">
                  <p class="text-gray-700 mb-6 text-lg">
                    Our portrait retouching service enhances your photos while maintaining a natural look. 
                    We carefully remove blemishes, smooth skin texture, and enhance facial features without 
                    making the subject look artificial. Our professional retouchers pay attention to details.
                  </p>
                  <ul class="space-y-3">
                    <li class="flex items-start">
                      <span class="text-violet-500 mr-2 text-xl">→</span>
                      <span class="text-gray-700">Natural-looking skin retouching that preserves texture</span>
                    </li>
                    <li class="flex items-start">
                      <span class="text-violet-500 mr-2 text-xl">→</span>
                      <span class="text-gray-700">Subtle enhancements that highlight your best features</span>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
            
            <!-- Image - appears second -->
            <div ref="image2" class="w-full md:w-1/2 relative opacity-0 scale-95 transition-all duration-700 ease-out" :style="{ transitionDelay: '350ms' }">
              <div class="relative overflow-hidden rounded-xl shadow-2xl h-96 transform transition-all duration-500 hover:scale-[1.02]">
                <transition name="fade" mode="out-in">
                  <img 
                    v-if="serviceStates[1]" 
                    key="after2"
                    src="https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=688&q=80" 
                    alt="Portrait after retouching" 
                    class="w-full h-full object-cover"
                  >
                  <img 
                    v-else 
                    key="before2"
                    src="https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=688&q=80&sat=-100&contrast=-20" 
                    alt="Portrait before retouching" 
                    class="w-full h-full object-cover"
                  >
                </transition>
                <div class="absolute bottom-0 left-0 right-0 bg-black bg-opacity-60 backdrop-blur-sm py-3">
                  <transition name="slide-fade" mode="out-in">
                    <p v-if="serviceStates[1]" key="after-text2" class="text-white text-center font-medium text-lg">After</p>
                    <p v-else key="before-text2" class="text-white text-center font-medium text-lg">Before</p>
                  </transition>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <!-- Service 3: Text Left, Image Right -->
      <div ref="section3" class="py-20 bg-gradient-to-r from-emerald-50 to-teal-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div class="flex flex-col md:flex-row items-center">
            <div class="w-full md:w-1/2 md:pr-12 mb-8 md:mb-0 overflow-hidden">
              <!-- Title - appears first -->
              <div class="overflow-hidden">
                <h3 ref="title3" class="text-3xl font-bold text-gray-900 mb-4 transform translate-y-16 opacity-0 transition-all duration-700 ease-out">
                  Hat and Bag Photo Editing
                </h3>
              </div>
              
              <!-- Description - appears last -->
              <div class="overflow-hidden">
                <div ref="desc3" class="transform translate-y-16 opacity-0 transition-all duration-700 ease-out" :style="{ transitionDelay: '700ms' }">
                  <p class="text-gray-700 mb-6 text-lg">
                    Transform your real estate photography with our professional enhancement services. 
                    We specialize in sky replacement, perspective correction, and lighting adjustments 
                    to make properties more appealing to potential buyers. Our edits help showcase the 
                    property's best features.
                  </p>
                  <ul class="space-y-3">
                    <li class="flex items-start">
                      <span class="text-teal-500 mr-2 text-xl">→</span>
                      <span class="text-gray-700">Sky replacement for stunning exterior shots</span>
                    </li>
                    <li class="flex items-start">
                      <span class="text-teal-500 mr-2 text-xl">→</span>
                      <span class="text-gray-700">Interior lighting balance to highlight spacious rooms</span>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
            
            <!-- Image - appears second -->
            <div ref="image3" class="w-full md:w-1/2 relative opacity-0 scale-95 transition-all duration-700 ease-out" :style="{ transitionDelay: '350ms' }">
              <div class="relative overflow-hidden rounded-xl shadow-2xl h-96 transform transition-all duration-500 hover:scale-[1.02]">
                <transition name="fade" mode="out-in">
                  <img 
                    v-if="serviceStates[2]" 
                    key="after3"
                    src="https://images.unsplash.com/photo-1564013799919-ab600027ffc6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80" 
                    alt="Real estate photo after editing" 
                    class="w-full h-full object-cover"
                  >
                  <img 
                    v-else 
                    key="before3"
                    src="https://images.unsplash.com/photo-1564013799919-ab600027ffc6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80&brightness=-20&sat=-50" 
                    alt="Real estate photo before editing" 
                    class="w-full h-full object-cover"
                  >
                </transition>
                <div class="absolute bottom-0 left-0 right-0 bg-black bg-opacity-60 backdrop-blur-sm py-3">
                  <transition name="slide-fade" mode="out-in">
                    <p v-if="serviceStates[2]" key="after-text3" class="text-white text-center font-medium text-lg">After</p>
                    <p v-else key="before-text3" class="text-white text-center font-medium text-lg">Before</p>
                  </transition>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>


            <!-- Service 4: Text Left, Image Right -->
    <div ref="section3" class="py-20 bg-gradient-to-r from-emerald-50 to-teal-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div class="flex flex-col md:flex-row items-center">
            <div class="w-full md:w-1/2 md:pr-12 mb-8 md:mb-0 overflow-hidden">
              <!-- Title - appears first -->
              <div class="overflow-hidden">
                <h3 ref="title3" class="text-3xl font-bold text-gray-900 mb-4 transform translate-y-16 opacity-0 transition-all duration-700 ease-out">
                  Eyeglass Photo Editing
                </h3>
              </div>
              
              <!-- Description - appears last -->
              <div class="overflow-hidden">
                <div ref="desc3" class="transform translate-y-16 opacity-0 transition-all duration-700 ease-out" :style="{ transitionDelay: '700ms' }">
                  <p class="text-gray-700 mb-6 text-lg">
                    Transform your real estate photography with our professional enhancement services. 
                    We specialize in sky replacement, perspective correction, and lighting adjustments 
                    to make properties more appealing to potential buyers. Our edits help showcase the 
                    property's best features.
                  </p>
                  <ul class="space-y-3">
                    <li class="flex items-start">
                      <span class="text-teal-500 mr-2 text-xl">→</span>
                      <span class="text-gray-700">Sky replacement for stunning exterior shots</span>
                    </li>
                    <li class="flex items-start">
                      <span class="text-teal-500 mr-2 text-xl">→</span>
                      <span class="text-gray-700">Interior lighting balance to highlight spacious rooms</span>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
            
            <!-- Image - appears second -->
            <div ref="image3" class="w-full md:w-1/2 relative opacity-0 scale-95 transition-all duration-700 ease-out" :style="{ transitionDelay: '350ms' }">
              <div class="relative overflow-hidden rounded-xl shadow-2xl h-96 transform transition-all duration-500 hover:scale-[1.02]">
                <transition name="fade" mode="out-in">
                  <img 
                    v-if="serviceStates[2]" 
                    key="after3"
                    src="https://images.unsplash.com/photo-1564013799919-ab600027ffc6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80" 
                    alt="Real estate photo after editing" 
                    class="w-full h-full object-cover"
                  >
                  <img 
                    v-else 
                    key="before3"
                    src="https://images.unsplash.com/photo-1564013799919-ab600027ffc6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80&brightness=-20&sat=-50" 
                    alt="Real estate photo before editing" 
                    class="w-full h-full object-cover"
                  >
                </transition>
                <div class="absolute bottom-0 left-0 right-0 bg-black bg-opacity-60 backdrop-blur-sm py-3">
                  <transition name="slide-fade" mode="out-in">
                    <p v-if="serviceStates[2]" key="after-text3" class="text-white text-center font-medium text-lg">After</p>
                    <p v-else key="before-text3" class="text-white text-center font-medium text-lg">Before</p>
                  </transition>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

            <!-- Service 3: Text Left, Image Right -->
    <div ref="section3" class="py-20 bg-gradient-to-r from-emerald-50 to-teal-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div class="flex flex-col md:flex-row items-center">
            <div class="w-full md:w-1/2 md:pr-12 mb-8 md:mb-0 overflow-hidden">
              <!-- Title - appears first -->
              <div class="overflow-hidden">
                <h3 ref="title3" class="text-3xl font-bold text-gray-900 mb-4 transform translate-y-16 opacity-0 transition-all duration-700 ease-out">
                  Shoe Photo Editing
                </h3>
              </div>
              
              <!-- Description - appears last -->
              <div class="overflow-hidden">
                <div ref="desc3" class="transform translate-y-16 opacity-0 transition-all duration-700 ease-out" :style="{ transitionDelay: '700ms' }">
                  <p class="text-gray-700 mb-6 text-lg">
                    Transform your real estate photography with our professional enhancement services. 
                    We specialize in sky replacement, perspective correction, and lighting adjustments 
                    to make properties more appealing to potential buyers. Our edits help showcase the 
                    property's best features.
                  </p>
                  <ul class="space-y-3">
                    <li class="flex items-start">
                      <span class="text-teal-500 mr-2 text-xl">→</span>
                      <span class="text-gray-700">Sky replacement for stunning exterior shots</span>
                    </li>
                    <li class="flex items-start">
                      <span class="text-teal-500 mr-2 text-xl">→</span>
                      <span class="text-gray-700">Interior lighting balance to highlight spacious rooms</span>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
            
            <!-- Image - appears second -->
            <div ref="image3" class="w-full md:w-1/2 relative opacity-0 scale-95 transition-all duration-700 ease-out" :style="{ transitionDelay: '350ms' }">
              <div class="relative overflow-hidden rounded-xl shadow-2xl h-96 transform transition-all duration-500 hover:scale-[1.02]">
                <transition name="fade" mode="out-in">
                  <img 
                    v-if="serviceStates[2]" 
                    key="after3"
                    src="https://images.unsplash.com/photo-1564013799919-ab600027ffc6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80" 
                    alt="Real estate photo after editing" 
                    class="w-full h-full object-cover"
                  >
                  <img 
                    v-else 
                    key="before3"
                    src="https://images.unsplash.com/photo-1564013799919-ab600027ffc6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80&brightness=-20&sat=-50" 
                    alt="Real estate photo before editing" 
                    class="w-full h-full object-cover"
                  >
                </transition>
                <div class="absolute bottom-0 left-0 right-0 bg-black bg-opacity-60 backdrop-blur-sm py-3">
                  <transition name="slide-fade" mode="out-in">
                    <p v-if="serviceStates[2]" key="after-text3" class="text-white text-center font-medium text-lg">After</p>
                    <p v-else key="before-text3" class="text-white text-center font-medium text-lg">Before</p>
                  </transition>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

          <!-- Service 3: Text Left, Image Right -->
    <div ref="section3" class="py-20 bg-gradient-to-r from-emerald-50 to-teal-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div class="flex flex-col md:flex-row items-center">
            <div class="w-full md:w-1/2 md:pr-12 mb-8 md:mb-0 overflow-hidden">
              <!-- Title - appears first -->
              <div class="overflow-hidden">
                <h3 ref="title3" class="text-3xl font-bold text-gray-900 mb-4 transform translate-y-16 opacity-0 transition-all duration-700 ease-out">
                 Color Correction
                </h3>
              </div>
              
              <!-- Description - appears last -->
              <div class="overflow-hidden">
                <div ref="desc3" class="transform translate-y-16 opacity-0 transition-all duration-700 ease-out" :style="{ transitionDelay: '700ms' }">
                  <p class="text-gray-700 mb-6 text-lg">
                    Transform your real estate photography with our professional enhancement services. 
                    We specialize in sky replacement, perspective correction, and lighting adjustments 
                    to make properties more appealing to potential buyers. Our edits help showcase the 
                    property's best features.
                  </p>
                  <ul class="space-y-3">
                    <li class="flex items-start">
                      <span class="text-teal-500 mr-2 text-xl">→</span>
                      <span class="text-gray-700">Sky replacement for stunning exterior shots</span>
                    </li>
                    <li class="flex items-start">
                      <span class="text-teal-500 mr-2 text-xl">→</span>
                      <span class="text-gray-700">Interior lighting balance to highlight spacious rooms</span>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
            
            <!-- Image - appears second -->
            <div ref="image3" class="w-full md:w-1/2 relative opacity-0 scale-95 transition-all duration-700 ease-out" :style="{ transitionDelay: '350ms' }">
              <div class="relative overflow-hidden rounded-xl shadow-2xl h-96 transform transition-all duration-500 hover:scale-[1.02]">
                <transition name="fade" mode="out-in">
                  <img 
                    v-if="serviceStates[2]" 
                    key="after3"
                    src="https://images.unsplash.com/photo-1564013799919-ab600027ffc6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80" 
                    alt="Real estate photo after editing" 
                    class="w-full h-full object-cover"
                  >
                  <img 
                    v-else 
                    key="before3"
                    src="https://images.unsplash.com/photo-1564013799919-ab600027ffc6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80&brightness=-20&sat=-50" 
                    alt="Real estate photo before editing" 
                    class="w-full h-full object-cover"
                  >
                </transition>
                <div class="absolute bottom-0 left-0 right-0 bg-black bg-opacity-60 backdrop-blur-sm py-3">
                  <transition name="slide-fade" mode="out-in">
                    <p v-if="serviceStates[2]" key="after-text3" class="text-white text-center font-medium text-lg">After</p>
                    <p v-else key="before-text3" class="text-white text-center font-medium text-lg">Before</p>
                  </transition>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>


          <!-- Service 3: Text Left, Image Right -->
          <div ref="section3" class="py-20 bg-gradient-to-r from-emerald-50 to-teal-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div class="flex flex-col md:flex-row items-center">
            <div class="w-full md:w-1/2 md:pr-12 mb-8 md:mb-0 overflow-hidden">
              <!-- Title - appears first -->
              <div class="overflow-hidden">
                <h3 ref="title3" class="text-3xl font-bold text-gray-900 mb-4 transform translate-y-16 opacity-0 transition-all duration-700 ease-out">
                  Shadow Creation
                </h3>
              </div>
              
              <!-- Description - appears last -->
              <div class="overflow-hidden">
                <div ref="desc3" class="transform translate-y-16 opacity-0 transition-all duration-700 ease-out" :style="{ transitionDelay: '700ms' }">
                  <p class="text-gray-700 mb-6 text-lg">
                    Transform your real estate photography with our professional enhancement services. 
                    We specialize in sky replacement, perspective correction, and lighting adjustments 
                    to make properties more appealing to potential buyers. Our edits help showcase the 
                    property's best features.
                  </p>
                  <ul class="space-y-3">
                    <li class="flex items-start">
                      <span class="text-teal-500 mr-2 text-xl">→</span>
                      <span class="text-gray-700">Sky replacement for stunning exterior shots</span>
                    </li>
                    <li class="flex items-start">
                      <span class="text-teal-500 mr-2 text-xl">→</span>
                      <span class="text-gray-700">Interior lighting balance to highlight spacious rooms</span>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
            
            <!-- Image - appears second -->
            <div ref="image3" class="w-full md:w-1/2 relative opacity-0 scale-95 transition-all duration-700 ease-out" :style="{ transitionDelay: '350ms' }">
              <div class="relative overflow-hidden rounded-xl shadow-2xl h-96 transform transition-all duration-500 hover:scale-[1.02]">
                <transition name="fade" mode="out-in">
                  <img 
                    v-if="serviceStates[2]" 
                    key="after3"
                    src="https://images.unsplash.com/photo-1564013799919-ab600027ffc6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80" 
                    alt="Real estate photo after editing" 
                    class="w-full h-full object-cover"
                  >
                  <img 
                    v-else 
                    key="before3"
                    src="https://images.unsplash.com/photo-1564013799919-ab600027ffc6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80&brightness=-20&sat=-50" 
                    alt="Real estate photo before editing" 
                    class="w-full h-full object-cover"
                  >
                </transition>
                <div class="absolute bottom-0 left-0 right-0 bg-black bg-opacity-60 backdrop-blur-sm py-3">
                  <transition name="slide-fade" mode="out-in">
                    <p v-if="serviceStates[2]" key="after-text3" class="text-white text-center font-medium text-lg">After</p>
                    <p v-else key="before-text3" class="text-white text-center font-medium text-lg">Before</p>
                  </transition>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref, onMounted, onBeforeUnmount, nextTick } from 'vue';
  
  // Track the state of each service card (true = after, false = before)
  const serviceStates = ref([false, false, false]);
  
  // Refs for each section and its elements
  const section1 = ref(null);
  const title1 = ref(null);
  const image1 = ref(null);
  const desc1 = ref(null);
  
  const section2 = ref(null);
  const title2 = ref(null);
  const image2 = ref(null);
  const desc2 = ref(null);
  
  const section3 = ref(null);
  const title3 = ref(null);
  const image3 = ref(null);
  const desc3 = ref(null);
  
  // Interval IDs for each service card
  const intervals = ref([null, null, null]);
  
  // Observer instance
  let observer = null;
  
  // Function to toggle the state of a specific service
  const toggleServiceState = (index) => {
    serviceStates.value[index] = !serviceStates.value[index];
  };
  
  // Function to animate an element
  const animateElement = (element) => {
    if (element) {
      element.style.opacity = '1';
      element.style.transform = 'translateY(0) scale(1)';
    }
  };
  
  // Function to check if element is in viewport and animate if needed
  const checkAndAnimateElement = (element, delay = 0) => {
    if (!element) return;
    
    const rect = element.getBoundingClientRect();
    const isInViewport = (
      rect.top >= 0 &&
      rect.left >= 0 &&
      rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
      rect.right <= (window.innerWidth || document.documentElement.clientWidth)
    );
    
    if (isInViewport) {
      setTimeout(() => {
        animateElement(element);
      }, delay);
      return true;
    }
    return false;
  };
  
  // Function to set up animations for a section
  const setupSectionAnimations = (sectionId) => {
    let titleEl, imageEl, descEl;
    
    if (sectionId === '1') {
      titleEl = title1.value;
      imageEl = image1.value;
      descEl = desc1.value;
    } else if (sectionId === '2') {
      titleEl = title2.value;
      imageEl = image2.value;
      descEl = desc2.value;
    } else if (sectionId === '3') {
      titleEl = title3.value;
      imageEl = image3.value;
      descEl = desc3.value;
    }
    
    // Check if elements are already in viewport
    const titleInView = checkAndAnimateElement(titleEl, 0);
    const imageInView = checkAndAnimateElement(imageEl, 350);
    const descInView = checkAndAnimateElement(descEl, 700);
    
    // If all elements are already in viewport, no need to observe
    if (titleInView && imageInView && descInView) {
      return false;
    }
    
    return true;
  };
  
  // Initialize animations and observers
  const initAnimations = () => {
    // Clean up any existing observer
    if (observer) {
      observer.disconnect();
    }
    
    // Create a new observer
    observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          const sectionId = entry.target.getAttribute('data-section-id');
          
          // Animate title immediately
          if (sectionId === '1') animateElement(title1.value);
          if (sectionId === '2') animateElement(title2.value);
          if (sectionId === '3') animateElement(title3.value);
          
          // Animate image after a delay
          setTimeout(() => {
            if (sectionId === '1') animateElement(image1.value);
            if (sectionId === '2') animateElement(image2.value);
            if (sectionId === '3') animateElement(image3.value);
          }, 350);
          
          // Animate description after a longer delay
          setTimeout(() => {
            if (sectionId === '1') animateElement(desc1.value);
            if (sectionId === '2') animateElement(desc2.value);
            if (sectionId === '3') animateElement(desc3.value);
          }, 700);
          
          // Stop observing after animation is triggered
          observer.unobserve(entry.target);
        }
      });
    }, { threshold: 0.15 });
    
    // Add data attributes to sections for identification
    if (section1.value) {
      section1.value.setAttribute('data-section-id', '1');
      if (setupSectionAnimations('1')) {
        observer.observe(section1.value);
      }
    }
    
    if (section2.value) {
      section2.value.setAttribute('data-section-id', '2');
      if (setupSectionAnimations('2')) {
        observer.observe(section2.value);
      }
    }
    
    if (section3.value) {
      section3.value.setAttribute('data-section-id', '3');
      if (setupSectionAnimations('3')) {
        observer.observe(section3.value);
      }
    }
  };
  
  // Set up intervals to toggle each service state
  onMounted(() => {
    // Different intervals for each card to create a staggered effect
    intervals.value[0] = setInterval(() => toggleServiceState(0), 4000);
    intervals.value[1] = setInterval(() => toggleServiceState(1), 4500);
    intervals.value[2] = setInterval(() => toggleServiceState(2), 5000);
    
    // Wait for next tick to ensure DOM is fully rendered
    nextTick(() => {
      initAnimations();
    });
    
    // Add scroll event listener to check for elements in viewport during scroll
    window.addEventListener('scroll', () => {
      setupSectionAnimations('1');
      setupSectionAnimations('2');
      setupSectionAnimations('3');
    }, { passive: true });
  });
  
  // Clean up intervals when component is unmounted
  onBeforeUnmount(() => {
    intervals.value.forEach(interval => {
      if (interval) clearInterval(interval);
    });
    
    if (observer) {
      observer.disconnect();
    }
    
    window.removeEventListener('scroll', () => {});
  });
  </script>
  
  <style scoped>
  /* Image transition effects */
  .fade-enter-active,
  .fade-leave-active {
    transition: opacity 1s ease, transform 1s ease;
  }
  
  .fade-enter-from,
  .fade-leave-to {
    opacity: 0;
    transform: scale(1.05);
  }
  
  .fade-enter-to,
  .fade-leave-from {
    opacity: 1;
    transform: scale(1);
  }
  
  /* Text transition effects */
  .slide-fade-enter-active,
  .slide-fade-leave-active {
    transition: all 0.5s ease;
  }
  
  .slide-fade-enter-from {
    transform: translateY(20px);
    opacity: 0;
  }
  
  .slide-fade-leave-to {
    transform: translateY(-20px);
    opacity: 0;
  }
  </style>
  