<template>
    <div class="relative overflow-hidden w-full" ref="container" @mousemove="handleMouseMove" @touchmove="handleTouchMove" @mouseleave="resetSlider">
      <!-- After image (full width, shown by default) -->
      <img 
        :src="afterImage" 
        :alt="afterAlt" 
        class="w-full h-auto block"
      />
      
      <!-- Before image (clipped by the slider position) -->
      <div 
        class="absolute top-0 left-0 w-full h-full overflow-hidden"
        :style="{ clipPath: `inset(0 ${100 - sliderPosition}% 0 0)` }"
      >
        <img 
          :src="beforeImage" 
          :alt="beforeAlt" 
          class="w-full h-auto block"
        />
      </div>
      
      <!-- Slider handle -->
      <div 
        class="absolute top-0 bottom-0 w-1 bg-white cursor-ew-resize"
        :style="{ left: `${sliderPosition}%`, transform: 'translateX(-50%)' }"
      >
  </div>
      
      <!-- Labels -->
      <div v-if="showLabels" class="absolute top-4 left-4 bg-black bg-opacity-50 text-white px-2 py-1 text-sm rounded">
        {{ beforeLabel }}
      </div>
      <div v-if="showLabels" class="absolute top-4 right-4 bg-black bg-opacity-50 text-white px-2 py-1 text-sm rounded">
        {{ afterLabel }}
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref, onMounted } from 'vue';
  
  // Props
  const props = defineProps({
    beforeImage: {
      type: String,
      default: 'https://picsum.photos/id/1018/800/500'
    },
    afterImage: {
      type: String,
      default: 'https://picsum.photos/id/1015/800/500'
    },
    beforeAlt: {
      type: String,
      default: 'Before image'
    },
    afterAlt: {
      type: String,
      default: 'After image'
    },
    beforeLabel: {
      type: String,
      default: 'Before'
    },
    afterLabel: {
      type: String,
      default: 'After'
    },
    showLabels: {
      type: Boolean,
      default: true
    },
    initialPosition: {
      type: Number,
      default: 50
    }

});
  
  // Reactive state
  const sliderPosition = ref(props.initialPosition);
  const container = ref(null);
  
  // Methods
  const handleMouseMove = (event) => {
    if (!container.value) return;
    
    const rect = container.value.getBoundingClientRect();
    const x = event.clientX - rect.left;
    const containerWidth = rect.width;
    
  // Calculate percentage (0-100)
    let percentage = (x / containerWidth) * 100;
    
  // Clamp between 0 and 100
    percentage = Math.max(0, Math.min(100, percentage));
    
    sliderPosition.value = percentage;
  };
  
  const handleTouchMove = (event) => {
    event.preventDefault();
    if (!container.value || !event.touches[0]) return;
    
    const rect = container.value.getBoundingClientRect();
    const x = event.touches[0].clientX - rect.left;
    const containerWidth = rect.width;
    
    // Calculate percentage (0-100)
    let percentage = (x / containerWidth) * 100;
    
    // Clamp between 0 and 100
    percentage = Math.max(0, Math.min(100, percentage));
    
    sliderPosition.value = percentage;
  };
  
  const resetSlider = () => {
    // Optional: reset to initial position when mouse leaves
    // Uncomment if you want this behavior
    // sliderPosition.value = props.initialPosition;
  };
  
    // Lifecycle hooks
  
  onMounted(() => {
    // Initialize slider position
    sliderPosition.value = props.initialPosition;
  });
  </script>