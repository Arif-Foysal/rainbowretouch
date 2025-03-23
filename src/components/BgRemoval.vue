<template>
    <div class="background-removal-container">
      <div class="header-section">
        <p class="quality-tag">STUNNING QUALITY</p>
        <h1 class="main-heading">We've Removed These Tricky Backgrounds</h1>
      </div>
  
      <div class="filter-buttons">
        <button 
          v-for="category in categories" 
          :key="category.id"
          class="filter-btn" 
          :class="{ active: activeCategory === category.id }"
          @click="setActiveCategory(category.id)"
        >
          <component :is="category.icon" class="icon" />
          {{ category.name }}
        </button>
      </div>
  
      <div class="image-comparison-container" ref="container">
        <div class="image-wrapper">
          <!-- Before image (static, always fully visible) -->
          <img 
            :src="currentImagePair.before" 
            alt="Before background removal" 
            class="comparison-image before-image" 
          />
          
          <!-- After image (clipped by the slider position) -->
          <img 
            :src="currentImagePair.after" 
            alt="After background removal" 
            class="comparison-image after-image" 
            :style="{ clipPath: `inset(0 0 0 ${sliderPosition}%)` }"
          />
          
          <!-- Slider handle -->
          <div 
            class="slider-handle" 
            :style="{ left: `${sliderPosition}%` }"
            @mousedown="startDrag"
            @touchstart="startDrag"
          >
            <div class="slider-button">
              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="15 18 9 12 15 6"></polyline></svg>
              
              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 18 15 12 9 6"></polyline></svg>
            </div>
          </div>
        </div>
      </div>
  
      <button class="scroll-top-btn" @click="scrollToTop">
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><polyline points="16 12 12 8 8 12"></polyline><line x1="12" y1="16" x2="12" y2="8"></line></svg>
      </button>
    </div>
  </template>
  
  <script setup>
  import { ref, computed, onMounted, onUnmounted, h } from 'vue';
  
  // Define category icons as render functions
  const PeopleIcon = () => h('svg', {
    xmlns: 'http://www.w3.org/2000/svg',
    width: '20',
    height: '20',
    viewBox: '0 0 24 24',
    fill: 'none',
    stroke: 'currentColor',
    'stroke-width': '2',
    'stroke-linecap': 'round',
    'stroke-linejoin': 'round'
  }, [
    h('path', { d: 'M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2' }),
    h('circle', { cx: '12', cy: '7', r: '4' })
  ]);
  
  const ProductsIcon = () => h('svg', {
    xmlns: 'http://www.w3.org/2000/svg',
    width: '20',
    height: '20',
    viewBox: '0 0 24 24',
    fill: 'none',
    stroke: 'currentColor',
    'stroke-width': '2',
    'stroke-linecap': 'round',
    'stroke-linejoin': 'round'
  }, [
    h('circle', { cx: '12', cy: '12', r: '10' }),
    h('line', { x1: '2', y1: '12', x2: '22', y2: '12' }),
    h('path', { d: 'M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z' })
  ]);
  
  const AnimalsIcon = () => h('svg', {
    xmlns: 'http://www.w3.org/2000/svg',
    width: '20',
    height: '20',
    viewBox: '0 0 24 24',
    fill: 'none',
    stroke: 'currentColor',
    'stroke-width': '2',
    'stroke-linecap': 'round',
    'stroke-linejoin': 'round'
  }, [
    h('path', { d: 'M17 3a2.85 2.85 0 1 1 0 5.7' }),
    h('path', { d: 'M10.5 3a2.85 2.85 0 1 1 0 5.7' }),
    h('path', { d: 'M3 10c0-1.66 1.34-3 3-3h11c1.66 0 3 1.34 3 3v7c0 1.66-1.34 3-3 3h-11c-1.66 0-3-1.34-3-3v-7Z' }),
    h('path', { d: 'M10.5 14c.85 0 1.5.65 1.5 1.5v1c0 .85-.65 1.5-1.5 1.5h-1c-.85 0-1.5-.65-1.5-1.5v-1c0-.85.65-1.5 1.5-1.5h1Z' })
  ]);
  
  const CarsIcon = () => h('svg', {
    xmlns: 'http://www.w3.org/2000/svg',
    width: '20',
    height: '20',
    viewBox: '0 0 24 24',
    fill: 'none',
    stroke: 'currentColor',
    'stroke-width': '2',
    'stroke-linecap': 'round',
    'stroke-linejoin': 'round'
  }, [
    h('path', { d: 'M19 17h2c.6 0 1-.4 1-1v-3c0-.9-.7-1.7-1.5-1.9C18.7 10.6 16 10 16 10s-1.3-1.4-2.2-2.3c-.5-.6-1.1-.7-1.8-.7H5c-.6 0-1.1.4-1.4.9l-1.5 2.8C1.4 11.3 1 12.1 1 13v3c0 .6.4 1 1 1h2' }),
    h('circle', { cx: '7', cy: '17', r: '2' }),
    h('path', { d: 'M9 17h6' }),
    h('circle', { cx: '17', cy: '17', r: '2' })
  ]);
  
  const GraphicsIcon = () => h('svg', {
    xmlns: 'http://www.w3.org/2000/svg',
    width: '20',
    height: '20',
    viewBox: '0 0 24 24',
    fill: 'none',
    stroke: 'currentColor',
    'stroke-width': '2',
    'stroke-linecap': 'round',
    'stroke-linejoin': 'round'
  }, [
    h('rect', { x: '3', y: '3', width: '18', height: '18', rx: '2', ry: '2' }),
    h('circle', { cx: '8.5', cy: '8.5', r: '1.5' }),
    h('path', { d: 'm21 15-5-5L5 21' })
  ]);
  
  // Define categories with their respective image pairs
import peopleBefore from '@/assets/images/image-4.jpg';
import peopleAfter from '@/assets/images/image-5.jpg';
import productsBefore from '@/assets/images/image-4.jpg';
import productsAfter from '@/assets/images/image-4.jpg';
import animalsBefore from '@/assets/images/image-4.jpg';
import animalsAfter from '@/assets/images/image-4.jpg';
import carsBefore from '@/assets/images/image-4.jpg';
import carsAfter from '@/assets/images/image-4.jpg';
import graphicsBefore from '@/assets/images/image-4.jpg';
import graphicsAfter from '@/assets/images/image-4.jpg';

const categories = [
    {
        id: 'people',
        name: 'People',
        icon: PeopleIcon,
        images: {
            before: peopleBefore,
            after: peopleAfter
        }
    },
    {
        id: 'products',
        name: 'Products',
        icon: ProductsIcon,
        images: {
            before: productsBefore,
            after: productsAfter
        }
    },
    {
        id: 'animals',
        name: 'Animals',
        icon: AnimalsIcon,
        images: {
            before: animalsBefore,
            after: animalsAfter
        }
    },
    {
        id: 'cars',
        name: 'Cars',
        icon: CarsIcon,
        images: {
            before: carsBefore,
            after: carsAfter
        }
    },
    {
        id: 'graphics',
        name: 'Graphics',
        icon: GraphicsIcon,
        images: {
            before: graphicsBefore,
            after: graphicsAfter
        }
    }
];
  
  const container = ref(null);
  const sliderPosition = ref(50); // Start at 50%
  const isDragging = ref(false);
  const activeCategory = ref('people'); // Default to 'people' category
  
  // Get the current image pair based on the active category
  const currentImagePair = computed(() => {
    const category = categories.find(cat => cat.id === activeCategory.value);
    return category ? category.images : categories[0].images;
  });
  
  // Set the active category
  const setActiveCategory = (categoryId) => {
    activeCategory.value = categoryId;
    // Reset slider position when changing categories
    sliderPosition.value = 50;
  };
  
  const startDrag = (event) => {
    event.preventDefault();
    isDragging.value = true;
    document.addEventListener('mousemove', onDrag);
    document.addEventListener('touchmove', onDrag);
    document.addEventListener('mouseup', stopDrag);
    document.addEventListener('touchend', stopDrag);
  };
  
  const onDrag = (event) => {
    if (!isDragging.value || !container.value) return;
    
    const containerRect = container.value.getBoundingClientRect();
    const containerWidth = containerRect.width;
    
    // Get the x position relative to the container
    let clientX;
    if (event.type === 'touchmove') {
      clientX = event.touches[0].clientX;
    } else {
      clientX = event.clientX;
    }
    
    const x = clientX - containerRect.left;
    
    // Calculate percentage and clamp between 0 and 100
    let newPosition = (x / containerWidth) * 100;
    newPosition = Math.max(0, Math.min(100, newPosition));
    
    sliderPosition.value = newPosition;
  };
  
  const stopDrag = () => {
    isDragging.value = false;
    document.removeEventListener('mousemove', onDrag);
    document.removeEventListener('touchmove', onDrag);
    document.removeEventListener('mouseup', stopDrag);
    document.removeEventListener('touchend', stopDrag);
  };
  
  const scrollToTop = () => {
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    });
  };
  
  onMounted(() => {
    // Add event listeners for mobile touch events
    container.value.addEventListener('touchstart', startDrag, { passive: false });
  });
  
  onUnmounted(() => {
    // Clean up event listeners
    document.removeEventListener('mousemove', onDrag);
    document.removeEventListener('touchmove', onDrag);
    document.removeEventListener('mouseup', stopDrag);
    document.removeEventListener('touchend', stopDrag);
    if (container.value) {
      container.value.removeEventListener('touchstart', startDrag);
    }
  });
  </script>
  
  <style scoped>
  .background-removal-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem 1rem;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  }
  
  .header-section {
    text-align: center;
    margin-bottom: 2rem;
  }
  
  .quality-tag {
    color: #ff4d4f;
    font-size: 0.9rem;
    font-weight: 600;
    letter-spacing: 1px;
    margin-bottom: 0.5rem;
  }
  
  .main-heading {
    font-size: 2.5rem;
    font-weight: 700;
    color: #1f2937;
    margin: 0.5rem 0 2rem;
  }
  
  .filter-buttons {
    display: flex;
    justify-content: center;
    gap: 0.5rem;
    margin-bottom: 2.5rem;
    flex-wrap: wrap;
  }
  
  .filter-btn {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.5rem 1rem;
    border-radius: 9999px;
    border: none;
    background-color: #f3f4f6;
    color: #4b5563;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease;
  }
  
  .filter-btn.active {
    background-color: #4f46e5;
    color: white;
  }
  
  .filter-btn:hover:not(.active) {
    background-color: #e5e7eb;
  }
  
  .icon {
    width: 18px;
    height: 18px;
  }
  
  .image-comparison-container {
    position: relative;
    max-width: 800px;
    margin: 0 auto;
    overflow: hidden;
    border-radius: 8px;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
  }
  
  .image-wrapper {
    position: relative;
    width: 100%;
    height: 100%;
  }
  
  /* Both images are positioned absolutely and overlap each other */
  .comparison-image {
    display: block;
    width: 100%;
    height: auto;
    object-fit: cover;
  }
  
  /* Before image is static and always fully visible */
  .before-image {
    position: relative;
    z-index: 1;
  }
  
  /* After image is positioned on top and clipped based on slider position */
  .after-image {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 2;
  }
  
  .slider-handle {
    position: absolute;
    top: 0;
    bottom: 0;
    width: 2px;
    background-color: white;
    transform: translateX(-50%);
    cursor: ew-resize;
    z-index: 3;
  }
  
  .slider-button {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 40px;
    height: 40px;
    background-color: white;
    border-radius: 50%;
    display: flex;
    justify-content: center;
    align-items: center;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    z-index: 4;
  }
  
  .slider-button svg {
    /* width: 12px;
    height: 12px;
    stroke-width: 3; */
    width: 20px;
    height: 15px;
    stroke-width: 4;
    /* padding:  4px; Add margin to create space between the arrows */

  }
  
  .slider-button svg:first-child {
    margin-right: -4px;
  }
  
  .slider-button svg:last-child {
    margin-left: -4px;
  }
 
  .scroll-top-btn {
    position: fixed;
    bottom: 2rem;
    right: 2rem;
    width: 50px;
    height: 50px;
    border-radius: 50%;
    background-color: white;
    border: 1px solid #e5e7eb;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    display: flex;
    justify-content: center;
    align-items: center;
    cursor: pointer;
    color: #ff4d4f;
    transition: all 0.2s ease;
  }
  
  .scroll-top-btn:hover {
    transform: translateY(-3px);
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  }
  
  @media (max-width: 768px) {
    .main-heading {
      font-size: 1.8rem;
    }
    
    .filter-buttons {
      gap: 0.3rem;
    }
    
    .filter-btn {
      padding: 0.4rem 0.8rem;
      font-size: 0.9rem;
    }
  }
  
  @media (max-width: 480px) {
    .filter-buttons {
      flex-direction: row;
      overflow-x: auto;
      padding-bottom: 0.5rem;
      justify-content: flex-start;
    }
    
    .main-heading {
      font-size: 1.5rem;
    }
  }
  </style>