<template>
    <section class="py-12 px-4 bg-gray-50">
      <div class="max-w-7xl mx-auto">
        <!-- <h2 class="text-3xl font-bold text-center mb-12">Our Key Features</h2> -->
        
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
          <div 
            v-for="(feature, index) in features" 
            :key="feature.id"
            class="relative feature-card"
            :style="{ animationDelay: `${index * 100}ms` }"
            v-observe-visibility="onVisibilityChange"
          >
            <div class="bg-white rounded-lg shadow-md p-6 pt-12 h-full card-content">
              <div class="absolute -left-3 -top-3 bg-green-500 rounded-full w-16 h-16 flex items-center justify-center shadow-lg icon-badge">
                <div class="w-8 h-8 text-white" v-html="feature.icon"></div>
              </div>
              <h3 class="text-3xl font-bold mt-4 mb-2">{{ feature.headline }}</h3>
              <p class="text-gray-600 text-md">{{ feature.description }}</p>
            </div>
          </div>
        </div>
      </div>
    </section>
  </template>
  
  <script setup>
  import { ref, onMounted, onUnmounted } from 'vue';
  
  // Custom visibility observer directive
  const vObserveVisibility = {
    mounted(el, binding) {
      el._observer = new IntersectionObserver((entries) => {
        if (entries[0].isIntersecting) {
          binding.value(true, el);
          el._observer.unobserve(el);
        }
      }, { threshold: 0.2 });
      
      el._observer.observe(el);
    },
    unmounted(el) {
      if (el._observer) {
        el._observer.disconnect();
      }
    }
  };
  
  // Visibility change handler
  const onVisibilityChange = (isVisible, element) => {
    if (isVisible) {
      element.classList.add('visible');
    }
  };
  
  // Sample feature data with inline SVG icons
  const features = ref([
    {
      id: 1,
      icon: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
            </svg>`,
      headline: '98%',
      description: 'Customer satisfaction rate across all our service platforms'
    },
    {
      id: 2,
      icon: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
            </svg>`,
      headline: '2x Faster',
      description: 'Performance improvement compared to traditional solutions'
    },
    {
      id: 3,
      icon: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
            </svg>`,
      headline: 'Seamless',
      description: 'Integration with your existing tools and workflows'
    },
    {
      id: 4,
      icon: `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
            </svg>`,
      headline: '24/7',
      description: 'Support from our dedicated customer success team'
    }
  ]);
  </script>
  
  <style scoped>
  .feature-card {
    opacity: 0;
    transform: translateY(50px);
    transition: opacity 1.2s ease, transform 1.2s ease; /* Slower animation - increased from 0.5s to 1.2s */
  }
  
  .feature-card.visible {
    opacity: 1;
    transform: translateY(0);
  }
  
  .card-content {
    transition: all 0.3s ease;
    border: 1px solid transparent;
  }
  
  /* Hover animations */
  .feature-card:hover .card-content {
    transform: translateY(-5px) scale(1.03);
    box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
    border-color: #e5e7eb;
    background-color: #fafafa;
  }
  
  .feature-card:hover .icon-badge {
    transform: rotate(10deg) scale(1.1);
    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
  }
  
  .icon-badge {
    transition: all 0.3s ease;
  }
  </style>