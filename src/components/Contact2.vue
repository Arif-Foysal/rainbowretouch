<script setup>
import { ref, onMounted } from 'vue'
import { EnvelopeIcon, PhoneIcon, ChatBubbleLeftRightIcon } from '@heroicons/vue/24/outline'
import { SparklesIcon, UserGroupIcon, HeartIcon } from '@heroicons/vue/24/solid'

const sectionRef = ref(null)

const badges = [
  {
    title: 'We Serve with Smile',
    description: 'Customer satisfaction is our top priority with friendly support.',
    color: 'border-blue-500'
  },
  {
    title: 'Transparent & Timely Delivery',
    description: 'Clear communication and on-time project completion guaranteed.',
    color: 'border-purple-500'
  },
  {
    title: 'Focused on Results',
    description: 'We measure our success by the results we deliver for you.',
    color: 'border-green-500'
  }
]

const achievements = [
  {
    value: '10+ YEARS',
    label: 'Industry Experience',
    icon: SparklesIcon,
    bgColor: 'bg-blue-100',
    textColor: 'text-blue-600'
  },
  {
    value: 'TEAM OF 50+',
    label: 'Professionals',
    icon: UserGroupIcon,
    bgColor: 'bg-purple-100',
    textColor: 'text-purple-600'
  },
  {
    value: 'DEDICATED',
    label: 'Free Support',
    icon: HeartIcon,
    bgColor: 'bg-green-100',
    textColor: 'text-green-600'
  }
]

// Intersection Observer setup
onMounted(() => {
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('show')
      }
    })
  }, {
    threshold: 0.1
  })

  const animatedElements = document.querySelectorAll('.animate-on-scroll')
  animatedElements.forEach(el => observer.observe(el))
})
</script>

<template>
  <section ref="sectionRef" class="py-24 overflow-hidden">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <!-- Main Grid -->
      <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <!-- Contact Form Section -->
        <div class="lg:col-span-2 bg-white rounded-xl    p-6 md:p-8 animate-on-scroll slide-up">
          <h2 class="text-5xl font-bold text-gray-900 mb-2">
            Let's Build Something Great Together
          </h2>
          <p class="text-gray-600 mb-8">
            Send us your query and you will hear from one of our experts soon.
          </p>
          
          <form class="space-y-6">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div>
                <label for="name" class="block text-md font-medium text-gray-700 mb-1">Your Name</label>
                <input 
                  type="text" 
                  id="name" 
                  class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all duration-200"
                  placeholder="John Doe"
                >
              </div>
              <div>
                <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Your Email</label>
                <input 
                  type="email" 
                  id="email" 
                  class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all duration-200"
                  placeholder="john@example.com"
                >
              </div>
            </div>
            
            <div>
              <label for="message" class="block text-sm font-medium text-gray-700 mb-1">Your Message</label>
              <textarea 
                id="message" 
                rows="5" 
                class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-all duration-200"
                placeholder="Tell us about your project..."
              ></textarea>
            </div>
            
            <button 
              type="submit" 
              class="w-full bg-blue-600 hover:bg-blue-700 text-white font-medium py-3 px-6 rounded-lg transition-all duration-300 transform hover:scale-105"
            >
              SEND MESSAGE
            </button>
          </form>
        </div>
        
        <!-- Contact Information Sidebar -->
        <div class="space-y-8 animate-on-scroll slide-left">
          <div class="bg-white rounded-xl  p-6">
            <h3 class="text-xl font-semibold text-gray-900 mb-6">Contact Information</h3>
            
            <div class="space-y-4">
              <div class="flex items-start">
                <div class="flex-shrink-0 bg-blue-100 p-3 rounded-lg">
                  <EnvelopeIcon class="h-6 w-6 text-blue-600" />
                </div>
                <div class="ml-4">
                  <p class="text-sm font-medium text-gray-500">Email</p>
                  <p class="text-base font-medium text-gray-900">contact@example.com</p>
                </div>
              </div>
              
              <div class="flex items-start">
                <div class="flex-shrink-0 bg-purple-100 p-3 rounded-lg">
                  <PhoneIcon class="h-6 w-6 text-purple-600" />
                </div>
                <div class="ml-4">
                  <p class="text-sm font-medium text-gray-500">Phone</p>
                  <p class="text-base font-medium text-gray-900">+1 (555) 123-4567</p>
                </div>
              </div>
              
              <div class="flex items-start">
                <div class="flex-shrink-0 bg-green-100 p-3 rounded-lg">
                  <ChatBubbleLeftRightIcon class="h-6 w-6 text-green-600" />
                </div>
                <div class="ml-4">
                  <p class="text-sm font-medium text-gray-500">Skype</p>
                  <p class="text-base font-medium text-gray-900">example.skype</p>
                </div>
              </div>
            </div>
          </div>
          
          <!-- Highlight Badges -->
          <div class="space-y-4">
            <div 
              v-for="(badge, index) in badges" 
              :key="index"
              class="bg-white rounded-xl  p-6 border-l-4 animate-on-scroll slide-up"
              :class="[badge.color, {'delay-100': index === 1, 'delay-200': index === 2}]"
            >
              <h4 class="text-lg font-semibold text-gray-900">{{ badge.title }}</h4>
              <p class="text-gray-600 mt-2">{{ badge.description }}</p>
            </div>
          </div>
        </div>
      </div>
      
      <!-- Achievements Bar -->
      <div class="mt-12 grid grid-cols-1 md:grid-cols-3 gap-4">
        <div 
          v-for="(achievement, index) in achievements"
          :key="index"
          class="bg-white rounded-xl  p-6 text-center transition-all duration-300 transform hover:scale-105 animate-on-scroll slide-up"
          :class="{'delay-100': index === 1, 'delay-200': index === 2}"
        >
          <div class="mx-auto h-12 w-12 rounded-full flex items-center justify-center mb-4"
               :class="achievement.bgColor">
            <component :is="achievement.icon" class="h-6 w-6" :class="achievement.textColor" />
          </div>
          <h4 class="text-xl font-bold text-gray-900">{{ achievement.value }}</h4>
          <p class="text-gray-600">{{ achievement.label }}</p>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.animate-on-scroll {
  opacity: 0;
  transform: translateY(20px);
  transition: all 0.6s cubic-bezier(0.4, 0, 0.2, 1);
}

.animate-on-scroll.slide-left {
  transform: translateX(20px);
}

.animate-on-scroll.slide-up {
  transform: translateY(20px);
}

.animate-on-scroll.show {
  opacity: 1;
  transform: translate(0);
}

.delay-100 {
  transition-delay: 100ms;
}

.delay-200 {
  transition-delay: 200ms;
}

@media (max-width: 640px) {
  .animate-on-scroll.slide-left {
    transform: translateY(20px);
  }
}
</style>