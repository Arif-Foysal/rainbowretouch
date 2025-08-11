<script setup>
import { ref, onMounted } from 'vue'

const features = [
  {
    title: 'Fast Turnaround',
    description: 'Get high-quality, stunning and professional results within 24 hours.',
    icon: '<svg class="w-10 h-10" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>',
    color: 'text-purple-600'
  },
  {
    title: 'No Subscription',
    description: 'Pay only per image – no subscriptions required.',
    icon: '<svg class="w-10 h-10" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z"></path></svg>',
    color: 'text-pink-600'
  },
  {
    title: 'Unlimited Changes',
    description: 'Customer satisfaction is always our #1 priority.',
    icon: '<svg class="w-10 h-10" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"></path></svg>',
    color: 'text-amber-600'
  },
  {
    title: 'Work Directly 1:1',
    description: 'Work directly 1-on-1 with one of our best editors for consistent results.',
    icon: '<svg class="w-10 h-10" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path></svg>',
    color: 'text-blue-600'
  },
  {
    title: '2 Times Check',
    description: 'We always double-check our work before delivering to meet our cliens expectations',
    icon: '<svg class="w-10 h-10" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>',
    color: 'text-green-600'
  },
  {
    title: 'No Copyright',
    description: 'We edit your pictures and send them back - the Copyright belong to you only.',
    icon: '<svg class="w-10 h-10" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path></svg>',
    color: 'text-teal-600'
  }
]

const sectionRef = ref(null)
const isVisible = ref(false)

const animateCards = () => {
  const cards = document.querySelectorAll('.feature-card')
  cards.forEach((card, index) => {
    card.style.opacity = '0'
    card.style.transform = 'translateY(40px) scale(0.9)'
    setTimeout(() => {
      card.style.transition = 'all 0.8s cubic-bezier(0.34, 1.56, 0.64, 1)'
      card.style.opacity = '1'
      card.style.transform = 'translateY(0) scale(1)'
    }, 100 + index * 100)
  })
}

onMounted(() => {
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting && !isVisible.value) {
        isVisible.value = true
        animateCards()
      }
    })
  }, {
    threshold: 0.2
  })

  if (sectionRef.value) {
    observer.observe(sectionRef.value)
  }
})
</script>

<template>
  <section ref="sectionRef" class="py-24 px-8  overflow-hidden ">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="text-center">
        <h2 class="text-4xl font-bold
 mb-6">
          Professional Photo Retouching and Editing Services
        </h2>
        <div class="w-32 h-2 bg-gradient-to-r from-amber-500 via-amber-600 to-amber-500 mx-auto rounded-full"></div>
      </div>

      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-2">
        <div
          v-for="(feature, index) in features"
          :key="index"
          class="feature-card opacity-0 group"
        >
          <div class="relative p-8 rounded-2xl border-2 border-gray-200 hover:bg-gray-100 shadow-[8px_8px_16px_#e2e8f0,-8px_-8px_16px_#ffffff] hover:shadow-[12px_12px_24px_#e2e8f0,-12px_-12px_24px_#ffffff] transition-all duration-500">
            <div class="relative z-10">
              <div 
                :class="[feature.color, 'inline-flex items-center justify-center w-14 h-14 rounded-2xl bg-gray-50 shadow-inner mb-6 group-hover:scale-110 transition-transform duration-500']"
                v-html="feature.icon"
              ></div>
              <h3 class="text-2xl font-bold text-gray-900 mb-4 transform transition-all duration-500 group-hover:-translate-y-1 group-hover:text-amber-600">{{ feature.title }}</h3>
              <p class="text-gray-600 text-lg leading-relaxed transform transition-all duration-500 delay-75 group-hover:-translate-y-1 group-hover:text-gray-800">{{ feature.description }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.feature-card {
  backface-visibility: hidden;
  transform-style: preserve-3d;
  perspective: 1000px;
  transition: all 0.5s cubic-bezier(0.34, 1.56, 0.64, 1);
}

.feature-card:hover {
  transform: translateY(-12px) rotateX(2deg) rotateY(-2deg);
}

.feature-card:hover .shadow-inner {
  transform: scale(1.1);
}

.feature-card:nth-child(even):hover {
  transform: translateY(-12px) rotateX(2deg) rotateY(2deg);
}

.feature-card h3,
.feature-card p {
  transition-timing-function: cubic-bezier(0.34, 1.56, 0.64, 1);
}
</style>
