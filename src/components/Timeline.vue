<template>

    <div class="timeline-container py-16 px-4 sm:px-6 lg:px-8 bg-gradient-to-b from-gray-50 to-white">
      <div class="max-w-4xl mx-auto">
        <!-- Header Section -->
        <div class="text-center mb-16" ref="header">
          <h2 class="text-3xl md:text-4xl font-bold text-gray-800 mb-4">Our Journey Through Time</h2>
          <p class="text-xl text-gray-600">Evolving Excellence in Photo Retouching Since 2003</p>
        </div>
        
        <!-- Timeline -->
        <div class="relative">
          <!-- Timeline Line -->
          <div class="absolute left-0 md:left-1/2 transform md:-translate-x-1/2 h-full w-1 bg-gradient-to-b from-amber-300 to-amber-500 rounded-full"></div>
          
          <!-- Timeline Items -->
          <div class="space-y-24">
            <div 
              v-for="(item, index) in timelineItems" 
              :key="index" 
              class="timeline-item relative"
              :class="{'md:flex-row-reverse': index % 2 !== 0}"
              ref="timelineItems"
            >
              <!-- Year Marker -->
              <div class="absolute left-0 md:left-1/2 transform md:-translate-x-1/2 -translate-y-1/2 z-10">
                <div class="year-marker w-12 h-12 rounded-full bg-amber-400 flex items-center justify-center shadow-lg">
                  <span class="text-white font-bold">{{ item.year }}</span>
                </div>
              </div>
              
              <!-- Content Card -->
              <div 
                class="timeline-content ml-16 md:ml-0 md:w-5/12 bg-white p-6 rounded-xl shadow-xl"
                :class="{
                  'md:mr-auto': index % 2 === 0,
                  'md:ml-auto': index % 2 !== 0
                }"
              >
                <div class="card-content">
                  <h3 class="text-xl font-bold text-gray-800 mb-3">{{ item.title }}</h3>
                  <p class="text-gray-600 mb-4">{{ item.description }}</p>
                  <div class="flex items-center">
                    <button 
                      @click="toggleDetails(index)" 
                      class="text-amber-500 hover:text-amber-600 flex items-center font-medium transition-colors"
                    >
                      {{ item.expanded ? 'Read Less' : 'Read More' }}
                      <svg 
                        xmlns="http://www.w3.org/2000/svg" 
                        class="h-5 w-5 ml-1 transition-transform" 
                        :class="{ 'rotate-180': item.expanded }"
                        fill="none" 
                        viewBox="0 0 24 24" 
                        stroke="currentColor"
                      >
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                      </svg>
                    </button>
                  </div>
                  
                  <!-- Expanded Content -->
                  <div 
                    v-if="item.expanded" 
                    class="expanded-content mt-4 pt-4 border-t border-gray-200"
                  >
                    <p class="text-gray-600">{{ item.expandedContent }}</p>
                    <div class="mt-4 flex flex-wrap gap-2">
                      <span 
                        v-for="(tag, tagIndex) in item.tags" 
                        :key="tagIndex"
                        class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-amber-100 text-amber-800"
                      >
                        {{ tag }}
                      </span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        
        <!-- Call to Action -->
        <div class="mt-24 text-center" ref="cta">
          <h3 class="text-2xl font-bold text-gray-800 mb-4">LET'S WORK TOGETHER</h3>
          <p class="text-xl text-gray-600 mb-8">Our image retouchers are ready for you.</p>
          <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <button class="px-8 py-3 bg-amber-400 hover:bg-amber-500 text-white font-medium rounded-lg shadow-md transition-all transform hover:scale-105">
              Try for Free
            </button>
            <button class="px-8 py-3 border-2 border-amber-400 text-amber-500 hover:bg-amber-50 font-medium rounded-lg transition-all transform hover:scale-105">
              Get a Quote
            </button>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref, onMounted, nextTick } from 'vue'
  import gsap from 'gsap'
  import { ScrollTrigger } from 'gsap/ScrollTrigger'
  
  gsap.registerPlugin(ScrollTrigger)
  
  const header = ref(null)
  const timelineItems = ref([
    {
      year: '2022',
      title: 'FixThePhoto Photo Editing App',
      description: 'Launched our mobile application for on-the-go photo editing with professional results.',
      expanded: false,
      expandedContent: 'Our mobile app brings professional-grade photo editing to your fingertips. With intuitive controls and powerful features, you can enhance your photos anywhere, anytime.',
      tags: ['Mobile App', 'iOS', 'Android', 'AI Enhancement']
    },
    {
      year: '2020',
      title: 'Reviews Professional Photography Editing Software',
      description: 'Expanded our services to include comprehensive reviews of professional editing tools.',
      expanded: false,
      expandedContent: 'We began testing and reviewing the latest professional photo editing software to help photographers make informed decisions about their toolkit.',
      tags: ['Software Reviews', 'Photoshop', 'Lightroom', 'Capture One']
    },
    {
      year: '2017',
      title: 'Shop for Digital Photo Retouching Tools',
      description: 'Opened our online store offering specialized tools for photo retouching professionals.',
      expanded: false,
      expandedContent: 'Our curated selection of digital tools, presets, and actions helps photographers streamline their workflow and achieve consistent results.',
      tags: ['Digital Tools', 'Presets', 'Actions', 'Brushes']
    },
    {
      year: '2016',
      title: 'Digital Image Retouching Manipulation',
      description: 'Introduced advanced manipulation services for creative and commercial projects.',
      expanded: false,
      expandedContent: 'We expanded our capabilities to include complex image manipulation, compositing, and creative retouching for advertising and artistic purposes.',
      tags: ['Manipulation', 'Compositing', 'Creative Retouching']
    },
    {
      year: '2015',
      title: 'Product Photo Retouching Services',
      description: 'Specialized in product photography enhancement with clipping path services.',
      expanded: false,
      expandedContent: 'Our product retouching services help e-commerce businesses present their products in the best light with clean backgrounds, perfect lighting, and accurate colors.',
      tags: ['Product Photography', 'Clipping Path', 'E-commerce']
    },
    {
      year: '2011',
      title: 'Lightroom Photo Editing Services',
      description: 'Expanded our editing capabilities with Lightroom-specific services.',
      expanded: false,
      expandedContent: 'We began offering specialized Lightroom editing services for photographers who prefer non-destructive editing workflows and batch processing.',
      tags: ['Lightroom', 'Color Grading', 'Batch Processing']
    },
    {
      year: '2009',
      title: 'Old Photo Retouching Restoration Services',
      description: 'Started offering restoration services for damaged and vintage photographs.',
      expanded: false,
      expandedContent: 'Our restoration experts breathe new life into old, damaged, or faded photographs, preserving precious memories for generations to come.',
      tags: ['Restoration', 'Vintage Photos', 'Damage Repair']
    },
    {
      year: '2003',
      title: 'Portrait Retouching Services',
      description: 'Founded our company with a focus on professional portrait retouching.',
      expanded: false,
      expandedContent: 'We started our journey by offering basic portrait retouching services, focusing on natural-looking skin enhancement and subtle improvements.',
      tags: ['Portrait Retouching', 'Skin Retouching', 'Company Founding']
    }
  ])
  const timelineItemsRef = ref([])
  const cta = ref(null)
  
  const toggleDetails = (index) => {
    timelineItems.value[index].expanded = !timelineItems.value[index].expanded
  }
  
  onMounted(async () => {
    await nextTick()
    
    // Header animation
    gsap.from(header.value, {
      opacity: 0,
      y: -50,
      duration: 1,
      scrollTrigger: {
        trigger: header.value,
        start: "top 80%",
        toggleActions: "play none none none"
      }
    })
    
    // Timeline items animations
    const items = document.querySelectorAll('.timeline-item')
    items.forEach((item, index) => {
      const isEven = index % 2 === 0
      
      // Year marker animation
      gsap.from(item.querySelector('.year-marker'), {
        scale: 0,
        opacity: 0,
        duration: 0.6,
        scrollTrigger: {
          trigger: item,
          start: "top 70%",
          toggleActions: "play none none none"
        }
      })
      
      // Content card animation
      gsap.from(item.querySelector('.timeline-content'), {
        x: isEven ? -100 : 100,
        opacity: 0,
        duration: 0.8,
        delay: 0.3,
        scrollTrigger: {
          trigger: item,
          start: "top 70%",
          toggleActions: "play none none none"
        }
      })
    })
    
    // CTA animation
    gsap.from(cta.value, {
      opacity: 0,
      y: 50,
      duration: 1,
      scrollTrigger: {
        trigger: cta.value,
        start: "top 80%",
        toggleActions: "play none none none"
      }
    })
    
    // Timeline line drawing animation
    gsap.from(".timeline-container .absolute.left-0", {
      height: 0,
      duration: 2,
      ease: "power2.out",
      scrollTrigger: {
        trigger: ".timeline-container",
        start: "top 80%",
        end: "bottom 80%",
        scrub: 1
      }
    })
  })
  </script>
  
  <style scoped>
  .timeline-item {
    padding-top: 3rem;
    padding-bottom: 3rem;
  }
  
  @media (min-width: 768px) {
    .timeline-item {
      display: flex;
      align-items: flex-start;
    }
  }
  
  .year-marker {
    transition: transform 0.3s ease;
  }
  
  .timeline-item:hover .year-marker {
    transform: scale(1.1);
  }
  
  .timeline-content {
    transition: transform 0.3s ease, box-shadow 0.3s ease;
  }
  
  .timeline-content:hover {
    transform: translateY(-5px);
    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
  }
  
  .expanded-content {
    animation: fadeIn 0.5s ease-in-out;
  }
  
  @keyframes fadeIn {
    from {
      opacity: 0;
      transform: translateY(-10px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }
  </style>