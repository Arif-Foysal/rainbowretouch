<template>
  <div class="container mx-auto px-4 py-8">
    <h1 class="text-3xl font-bold mb-2 text-center">Photoshop Experts</h1>
    <p class="text-center text-gray-600 mb-8">Drag the slider to see the before & after transformation</p>
    
    <!-- Gallery grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
      <div 
        v-for="(item, index) in galleryItems" 
        :key="index"
        class="flex flex-col rounded-lg shadow-lg overflow-hidden"
      >
        <!-- Image comparison container -->
        <div class="relative h-80 w-full overflow-hidden">
          <!-- After image (base layer) -->
          <img 
            :src="item.afterImage" 
            :alt="`After: ${item.title}`"
            class="absolute inset-0 w-full h-full object-cover"
          />

          <!-- Before image (top layer with clip) -->
          <div 
            class="absolute inset-0 overflow-hidden" 
            :style="{ width: `${item.sliderPosition}%` }"
            ref="beforeContainer"
          >
            <img 
              :src="item.beforeImage" 
              :alt="`Before: ${item.title}`"
              class="absolute inset-0 w-full h-full object-cover"
            />
          </div>
          
          <!-- Slider handle -->
          <div 
            class="absolute top-0 bottom-0 w-1 bg-white cursor-ew-resize"
            :style="{ left: `${item.sliderPosition}%`, transform: 'translateX(-50%)' }"
            @mousedown="startDrag($event, index)"
            @touchstart="startDrag($event, index)"
          >
            <div class="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-8 h-8 rounded-full bg-white shadow-md flex items-center justify-center">
              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M21 12H3M9 6l-6 6 6 6M15 6l6 6-6 6"></path>
              </svg>
            </div>
          </div>
          
          <!-- Labels -->
          <div class="absolute bottom-2 left-2 bg-black bg-opacity-50 text-white px-2 py-1 text-xs rounded">BEFORE</div>
          <div class="absolute bottom-2 right-2 bg-black bg-opacity-50 text-white px-2 py-1 text-xs rounded">AFTER</div>
        </div>
        
        <!-- Caption -->
        <div class="p-4 bg-white">
          <h3 class="font-bold text-lg mb-1">{{ item.title }}</h3>
          <p class="text-gray-600 text-sm">{{ item.description }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      activeIndex: null,
      galleryItems: [
        {
          title: "Portrait Retouching",
          description: "Professional skin retouching and color enhancement",
          beforeImage: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=776&q=80",
          afterImage: "https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80",
          sliderPosition: 50
        },
        {
          title: "Product Enhancement",
          description: "Background removal and product enhancement",
          beforeImage: "https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=796&q=80",
          afterImage: "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80",
          sliderPosition: 50
        },
        {
          title: "Landscape Transformation",
          description: "Color correction and sky replacement",
          beforeImage: "https://images.unsplash.com/photo-1472214103451-9374bd1c798e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
          afterImage: "https://images.unsplash.com/photo-1501785888041-af3ef285b470?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
          sliderPosition: 50
        },
        {
          title: "Real Estate Enhancement",
          description: "Interior lighting and perspective correction",
          beforeImage: "https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
          afterImage: "https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1453&q=80",
          sliderPosition: 50
        },
        {
          title: "Food Photography",
          description: "Color enhancement and composition improvement",
          beforeImage: "https://images.unsplash.com/photo-1565299507177-b0ac66763828?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=722&q=80",
          afterImage: "https://images.unsplash.com/photo-1565958011703-44f9829ba187?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=765&q=80",
          sliderPosition: 50
        },
        {
          title: "Fashion Retouching",
          description: "Fabric enhancement and color grading",
          beforeImage: "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=720&q=80",
          afterImage: "https://images.unsplash.com/photo-1529139574466-a303027c1d8b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
          sliderPosition: 50
        }
      ]
    };
  },
  mounted() {
    // Add global event listeners for mouse/touch move and up events
    window.addEventListener('mousemove', this.onDrag);
    window.addEventListener('mouseup', this.stopDrag);
    window.addEventListener('touchmove', this.onDrag);
    window.addEventListener('touchend', this.stopDrag);
  },
  beforeUnmount() {
    // Clean up event listeners
    window.removeEventListener('mousemove', this.onDrag);
    window.removeEventListener('mouseup', this.stopDrag);
    window.removeEventListener('touchmove', this.onDrag);
    window.removeEventListener('touchend', this.stopDrag);
  },
  methods: {
    startDrag(event, index) {
      // Prevent default behavior to avoid text selection during drag
      event.preventDefault();
      this.activeIndex = index;
    },
    onDrag(event) {
      if (this.activeIndex === null) return;
      
      // Get the container element
      const container = event.target.closest('.relative');
      if (!container) return;
      
      // Calculate the container's width and bounds
      const rect = container.getBoundingClientRect();
      const containerWidth = rect.width;
      
      // Get the x position relative to the container
      let clientX;
      if (event.type === 'touchmove') {
        clientX = event.touches[0].clientX;
      } else {
        clientX = event.clientX;
      }
      
      // Calculate the percentage position
      let position = ((clientX - rect.left) / containerWidth) * 100;
      
      // Clamp the position between 0 and 100
      position = Math.max(0, Math.min(100, position));
      
      // Update the slider position
      this.galleryItems[this.activeIndex].sliderPosition = position;
    },
    stopDrag() {
      this.activeIndex = null;
    }
  }
};
</script>

<style>
/* Add any additional custom styles here if needed */
</style>