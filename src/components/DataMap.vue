<script setup>
import { ref, onMounted } from 'vue'

const stats = [
  {
    number: '20+',
    label: 'Years of Experience',
    description: 'Delivering professional photo retouching since 2003',
    icon: '<svg class="w-12 h-12" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/></svg>',
    color: 'bg-gradient-to-br from-purple-100 to-purple-50',
    iconColor: 'text-purple-600'
  },
  {
    number: '1M+',
    label: 'Photos Retouched',
    description: 'Successfully enhanced over a million images',
    icon: '<svg class="w-12 h-12" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"/></svg>',
    color: 'bg-gradient-to-br from-pink-100 to-pink-50',
    iconColor: 'text-pink-600'
  },
  {
    number: '24/7',
    label: 'Customer Support',
    description: 'Round-the-clock assistance for your needs',
    icon: '<svg class="w-12 h-12" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18.364 5.636l-3.536 3.536m0 5.656l3.536 3.536M9.172 9.172L5.636 5.636m3.536 9.192l-3.536 3.536M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-5 0a4 4 0 11-8 0 4 4 0 018 0z"/></svg>',
    color: 'bg-gradient-to-br from-cyan-100 to-cyan-50',
    iconColor: 'text-cyan-600'
  },
  {
    number: '100%',
    label: 'Satisfaction Rate',
    description: 'Committed to delivering perfect results',
    icon: '<svg class="w-12 h-12" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>',
    color: 'bg-gradient-to-br from-green-100 to-green-50',
    iconColor: 'text-green-600'
  }
]

const sectionRef = ref(null)
const headerRef = ref(null)
const statsRef = ref(null)
const isVisible = ref(false)

const animateHeader = () => {
  headerRef.value.style.opacity = '0'
  headerRef.value.style.transform = 'translateY(20px)'
  setTimeout(() => {
    headerRef.value.style.transition = 'all 0.8s ease-out'
    headerRef.value.style.opacity = '1'
    headerRef.value.style.transform = 'translateY(0)'
  }, 100)
}

const animateStats = () => {
  const cards = document.querySelectorAll('.stat-card')
  cards.forEach((card, index) => {
    card.style.opacity = '0'
    card.style.transform = 'translateY(40px)'
    setTimeout(() => {
      card.style.transition = 'all 0.6s ease-out'
      card.style.opacity = '1'
      card.style.transform = 'translateY(0)'
    }, 300 + index * 150)
  })
}

onMounted(() => {
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting && !isVisible.value) {
        isVisible.value = true
        animateHeader()
        animateStats()
      }
    })
  }, {
    threshold: 0.2 // Triggers when 20% of the section is visible
  })

  if (sectionRef.value) {
    observer.observe(sectionRef.value)
  }
})
</script>

<template>
  <section ref="sectionRef" class="py-16 bg-gradient-to-b from-gray-50 to-white">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <!-- Header -->
      <div ref="headerRef" class="text-center max-w-3xl mx-auto mb-16 opacity-0">
        <h2 class="text-8xl font-bold text-gray-900 sm:text-4xl mb-4">
          Why Hire Us?
        </h2>
        <p class="text-lg text-gray-600">
          We've helped thousands of photographers achieve their perfect vision through our professional retouching services
        </p>
      </div>

      <!-- Stats Grid -->
      <div ref="statsRef" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
        <div 
          v-for="(stat, index) in stats" 
          :key="index"
          :class="[stat.color, 'stat-card rounded-xl p-8 shadow-lg hover:shadow-2xl transform hover:-translate-y-1 transition-all duration-300 opacity-0']"
        >
          <div class="text-center">
            <div 
              :class="[stat.iconColor, 'inline-flex items-center justify-center w-16 h-16 rounded-xl mb-6 bg-white/80 backdrop-blur-sm transform rotate-3 hover:rotate-6 transition-transform duration-300']"
              v-html="stat.icon"
            ></div>
            <div class="relative">
              <span class="text-4xl font-bold text-gray-900">
                {{ stat.number }}
              </span>
            </div>
            <h3 class="text-xl font-semibold text-gray-900 mt-4 mb-2">{{ stat.label }}</h3>
            <p class="text-gray-700">{{ stat.description }}</p>
          </div>
        </div>
      </div>

      <!-- Additional Info -->
      <div class="mt-16 text-center transform hover:scale-105 transition-transform duration-300">
        <p class="text-gray-600  mb-6">
          Join thousands of satisfied photographers who trust us with their images
        </p>
        <a 
          href="#contact" 
          class="group inline-flex items-center px-8 py-4 text-lg border border-transparent font-medium rounded-xl shadow-lg text-white bg-green-700 transition-all duration-300"
        >
          Start Your Project
          <svg 
            class="ml-2 -mr-1 w-6 h-6 transform group-hover:translate-x-1 transition-transform duration-300" 
            fill="none" 
            stroke="currentColor" 
            viewBox="0 0 24 24"
          >
            <path 
              stroke-linecap="round" 
              stroke-linejoin="round" 
              stroke-width="2" 
              d="M13 7l5 5m0 0l-5 5m5-5H6"
            />
          </svg>
        </a>
      </div>
    </div>
  </section>
</template>

<style scoped>
.stat-card {
  backface-visibility: hidden;
}

@keyframes float {
  0% {
    transform: translateY(0px);
  }
  50% {
    transform: translateY(-5px);
  }
  100% {
    transform: translateY(0px);
  }
}

.stat-card:hover {
  animation: float 3s ease-in-out infinite;
}
</style>