<template>

    <MarqueeText 
    :duration="10" 
    class="text-xl font-bold text-white bg-gray-800 p-2 rounded shadow-sm"
    :paused="false"
  >
   Welcome to rainbow retouch journey 24hrs live support, your trusted partner in creative design and digital image enhancement.
  </MarqueeText>
  <br>
  <p class="text-center text-xl text-gray-700">A visual timeline of Rainbow Retouch’s growth, milestones, and achievements in the world of creative design and digital image enhancement.</p>
  <br>
  <div class="max-w-3xl mx-auto py-8 px-4">
    <div class="relative">
      <!-- Timeline items -->
      <div v-for="(item, index) in timelineItems" :key="index" class="relative mb-12">
        <div class="flex">
          <!-- Date badge -->
          <div class="w-28 flex-shrink-0">
            <div class="bg-green-100 text-green-600 px-3 py-1 rounded-full text-sm font-semibold inline-block">
              {{ item.date }}
            </div>
          </div>
          
          <!-- Vertical line and dot -->
          <div class="relative flex-shrink-0 w-6 flex items-center justify-center">
            <div class="absolute top-0 bottom-0 w-0.5 bg-blue-200 -z-10" 
                 :class="index === timelineItems.length - 1 ? 'h-6' : 'h-full'"></div>
            <div class="w-3 h-3 rounded-full bg-blue-500 z-10"></div>
          </div>
          
          <!-- Content -->
          <div class="ml-6 flex-1">
            <h3 class="text-blue-500 font-semibold text-lg">{{ item.category }}</h3>
            <h2 class="text-2xl font-bold text-gray-900 mt-1">{{ item.title }}</h2>
            <p class="text-gray-600 text-lg mt-2">
              {{ item.description }}
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import MarqueeText from 'vue-marquee-text-component'

const timelineItems = ref([
  {
    date: 'JAN, 2019',
    category: 'The beginning',
    title: 'Rainbow Retouch was founded in British Columbia, USA',
    description: 'Launched by a team of passionate designers aiming to deliver high-quality photo editing and manipulation services to global clients.'
  },
  {
    date: 'DEC, 2019',
    category: 'First milestone',
    title: 'Served 1,000 clients across 10 countries',
    description: 'Built a reputation for reliable service, quick turnaround, and premium quality retouching.'
  },
  {
    date: 'AUG, 2020',
    category: 'Scaling Up',
    title: 'Expanded the team and added advanced image masking and shadow services',
    description: 'Invested in skilled talent and automation tools to handle bulk orders more efficiently.'
  },
  {
    date: 'APR, 2021',
    category: 'Creative Studio Launched',
    title: 'Opened an in-house creative studio for complex editing projects',
    description: 'Enabled real-time collaboration for advertising agencies and fashion brands.'
  },
  {
    date: 'JUL, 2022',
    category: 'Industry Recognition',
    title: 'Featured in ‘Top 10 Photo Editing Agencies’ by CreativeCloudMag',
    description: 'Recognized for consistency, client satisfaction, and innovative techniques.'
  }
]);
</script>