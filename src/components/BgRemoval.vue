<template>
    <div class="max-w-7xl mx-auto p-8 font-sans">
        <div class="text-center mb-8">
            <h1 class="text-5xl font-bold text-gray-800 mb-8">Services</h1>
            <p class="text-red-500 text-xl font-semibold tracking-wide mb-2">Showcasing some of our latest works</p>
        </div>

        <div 
            class="flex justify-center gap-4 mb-10 flex-wrap sticky top-32 bg-white z-50 shadow-md py-4"
        >
            <button 
            v-for="category in categories" 
            :key="category.id"
            class="flex items-center gap-2 px-4 py-2 text-xl rounded-full border-none bg-gray-200 font-medium cursor-pointer transition-all duration-200 ease-in-out"
            :class="{ 'bg-indigo-600 text-white': activeCategory == category.id }"
            @click="setActiveCategory(category.id)"
            >
            <component :is="category.icon" class="w-6 h-6" />
            {{ category.name }}
            </button>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 mb-8">
            <div v-for="(imagePair, index) in currentImagePairs" :key="index" class="relative overflow-hidden rounded-lg shadow-lg" :ref="el => { if(el) containers[index] = el }">
                <div class="relative w-full h-full">
                    <img 
                        :src="imagePair.before" 
                        alt="Before background removal" 
                        class="block w-full h-auto object-cover relative z-10" 
                    />
                    <img 
                        :src="imagePair.after" 
                        alt="After background removal" 
                        class="block w-full h-full object-cover absolute top-0 left-0 z-20"
                        :style="{ clipPath: `inset(0 0 0 ${sliderPositions[index]}%)` }"
                    />
                    <div 
                        class="absolute top-0 bottom-0 w-0.5 bg-white transform -translate-x-1/2 cursor-ew-resize z-30"
                        :style="{ left: `${sliderPositions[index]}%` }"
                        @mousedown="(e) => startDrag(e, index)"
                        @touchstart="(e) => startDrag(e, index)"
                    >
                        <div class="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-10 h-10 bg-white rounded-full flex justify-center items-center shadow-md z-40">
                            <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-4 stroke-current" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <polyline points="15 18 9 12 15 6"></polyline>
                            </svg>
                            <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-4 stroke-current" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <polyline points="9 18 15 12 9 6"></polyline>
                            </svg>
                        </div>
                    </div>
                </div>
            </div>
        </div>

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
import peopleBefore from '@/assets/images/beforeAfter/1-1.jpeg';
import peopleAfter from '@/assets/images/beforeAfter/1-2.jpeg';

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
        name: 'E-Commerce Photo Editing',
        icon: PeopleIcon,
        images: [
            { before: peopleBefore, after: peopleAfter },
            { before: peopleBefore, after: peopleAfter },
            { before: peopleBefore, after: peopleAfter },
            { before: peopleBefore, after: peopleAfter }
        ]
    },
    {
        id: 'products',
        name: 'Background Removal',
        icon: ProductsIcon,
        images: [
            { before: productsBefore, after: productsAfter },
            { before: productsBefore, after: productsAfter },
            { before: productsBefore, after: productsAfter },
            { before: productsBefore, after: productsAfter }
        ]
    },
    {
        id: 'animals',
        name: 'Photo Retouching',
        icon: AnimalsIcon,
        images: [
            { before: animalsBefore, after: animalsAfter },
            { before: animalsBefore, after: animalsAfter },
            { before: animalsBefore, after: animalsAfter },
            { before: animalsBefore, after: animalsAfter }
        ]
    },
    {
        id: 'cars',
        name: 'Photo Manipulation',
        icon: CarsIcon,
        images: [
            { before: carsBefore, after: carsAfter },
            { before: carsBefore, after: carsAfter },
            { before: carsBefore, after: carsAfter },
            { before: carsBefore, after: carsAfter }
        ]
    },
    {
        id: 'graphics',
        name: 'Graphics',
        icon: GraphicsIcon,
        images: [
            { before: graphicsBefore, after: graphicsAfter },
            { before: graphicsBefore, after: graphicsAfter },
            { before: graphicsBefore, after: graphicsAfter },
            { before: graphicsBefore, after: graphicsAfter }
        ]
    }
];

const containers = ref([]);
const sliderPositions = ref([50, 50, 50, 50]); // Start all at 50%
const isDragging = ref(false);
const activeCategory = ref('people'); // Default to 'people' category
const activeDragIndex = ref(null);

// Get the current image pairs based on the active category
const currentImagePairs = computed(() => {
    const category = categories.find(cat => cat.id === activeCategory.value);
    return category ? category.images : categories[0].images;
});

// Set the active category
const setActiveCategory = (categoryId) => {
    activeCategory.value = categoryId;
    // Reset all slider positions when changing categories
    sliderPositions.value = sliderPositions.value.map(() => 50);
};

const startDrag = (event, index) => {
    event.preventDefault();
    isDragging.value = true;
    activeDragIndex.value = index;
    document.addEventListener('mousemove', onDrag);
    document.addEventListener('touchmove', onDrag);
    document.addEventListener('mouseup', stopDrag);
    document.addEventListener('touchend', stopDrag);
};

const onDrag = (event) => {
    if (!isDragging.value || activeDragIndex.value === null || !containers.value[activeDragIndex.value]) return;

    const containerRect = containers.value[activeDragIndex.value].getBoundingClientRect();
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

    sliderPositions.value[activeDragIndex.value] = newPosition;
};

const stopDrag = () => {
    isDragging.value = false;
    activeDragIndex.value = null;
    document.removeEventListener('mousemove', onDrag);
    document.removeEventListener('touchmove', onDrag);
    document.removeEventListener('mouseup', stopDrag);
    document.removeEventListener('touchend', stopDrag);
};

onMounted(() => {
    // Add event listeners for mobile touch events
    containers.value.forEach(container => {
        if (container) {
            container.addEventListener('touchstart', startDrag, { passive: false });
        }
    });
});

onUnmounted(() => {
    // Clean up event listeners
    document.removeEventListener('mousemove', onDrag);
    document.removeEventListener('touchmove', onDrag);
    document.removeEventListener('mouseup', stopDrag);
    document.removeEventListener('touchend', stopDrag);
    containers.value.forEach(container => {
        if (container) {
            container.removeEventListener('touchstart', startDrag);
        }
    });
});
</script>

<style scoped>
/* No additional styles needed as Tailwind CSS is used */
</style>
