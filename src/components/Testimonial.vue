<template>
    <div class="flex flex-col bg-blue-600 text-white p-8 w-full overflow-hidden lg:flex-row lg:items-center lg:p-16">
        <div class="p-4 max-w-full lg:w-1/3 lg:pr-8">
            <div class="mb-8">
                <h3 class="text-lg font-medium mb-2">CUSTOMER TESTIMONIAL</h3>
                <h2 class="text-4xl font-bold leading-tight mb-4">They Love Us. You Will Too.</h2>
                <p class="text-base leading-relaxed mb-8 opacity-90">
                    Because A Quick Product Shoot Can Easily Turn Into A Week Or More Of Editing And Formatting Your Images. Let Us Look After The Edits.
                </p>
                <div class="flex gap-4">
                    <button class="flex items-center justify-center w-12 h-12 rounded-full border border-white/30 bg-transparent text-white transition-all duration-300 ease-in-out hover:bg-white/10" @click="prevSlide">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-arrow-left"><path d="m12 19-7-7 7-7"/><path d="M19 12H5"/></svg>
                    </button>
                    <button class="flex items-center justify-center w-12 h-12 rounded-full border border-white/30 bg-transparent text-white transition-all duration-300 ease-in-out hover:bg-white/10" @click="nextSlide">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-arrow-right"><path d="M5 12h14"/><path d="m12 5 7 7-7 7"/></svg>
                    </button>
                </div>
            </div>
        </div>
        
        <div class="w-full overflow-hidden p-4 lg:w-2/3">
            <div class="flex transition-transform duration-500 ease-in-out" :style="{ transform: `translateX(-${currentIndex * 100 / visibleSlides}%)` }">
                <div v-for="(testimonial, index) in testimonials" :key="index" class="flex-none w-full lg:w-1/3 p-4 box-border">
                    <div class="bg-white rounded-lg p-8 h-full flex flex-col text-gray-800">
                        <div class="text-indigo-500 mb-6">
                            <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-quote"><path d="M3 21c3 0 7-1 7-8V5c0-1.25-.756-2.017-2-2H4c-1.25 0-2 .75-2 1.972V11c0 1.25.75 2 2 2 1 0 1 0 1 1v1c0 1-1 2-2 2s-1 .008-1 1.031V20c0 1 0 1 1 1z"/><path d="M15 21c3 0 7-1 7-8V5c0-1.25-.757-2.017-2-2h-4c-1.25 0-2 .75-2 1.972V11c0 1.25.75 2 2 2h.75c0 2.25.25 4-2.75 4v3c0 1 0 1 1 1z"/></svg>
                        </div>
                        <p class="flex-grow text-lg leading-relaxed mb-8">{{ testimonial.text }}</p>
                        <div class="flex items-center border-t border-gray-200 pt-6">
                            <img :src="testimonial.avatar" :alt="testimonial.name" class="w-14 h-14 rounded-full object-cover mr-4" />
                            <div>
                                <h4 class="font-semibold mb-1">{{ testimonial.name }}</h4>
                                <p class="text-sm text-gray-600">{{ testimonial.title }}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue';

// Sample testimonial data
const testimonials = ref([
        {
                text: "Welcome to our digital agency We specialize in helping business most like yours succeed online. From website design and development to digital marketing agency",
                name: "Delores Olivo",
                title: "Senior Technology Editor",
                avatar: "./assets/images/image-4.jpg"
        },
        {
                text: "Welcome to our digital agency We specialize in helping business most like yours succeed online. From website design and development to digital marketing agency",
                name: "Endru Kolins",
                title: "CEO",
                avatar: "/placeholder.svg?height=60&width=60"
        },
        {
                text: "Welcome to our digital agency We specialize in helping business most like yours succeed online. From website design and development to digital marketing agency",
                name: "Delores Smith",
                title: "Content Creator",
                avatar: "/placeholder.svg?height=60&width=60"
        },
        {
                text: "Our team delivers exceptional results. The attention to detail and commitment to quality is what sets this agency apart from others in the industry.",
                name: "James Wilson",
                title: "Marketing Director",
                avatar: "/placeholder.svg?height=60&width=60"
        },
        {
                text: "I've worked with many agencies, but none have delivered the level of service and results that this team has. Highly recommended for any business.",
                name: "Sarah Johnson",
                title: "E-commerce Manager",
                avatar: "/placeholder.svg?height=60&width=60"
        }
]);

const currentIndex = ref(0);
const windowWidth = ref(window.innerWidth);

// Calculate how many slides should be visible based on screen width
const visibleSlides = computed(() => {
        if (windowWidth.value < 768) {
                return 1;
        } else if (windowWidth.value < 1024) {
                return 2;
        } else {
                return 3;
        }
});

// Maximum index based on visible slides
const maxIndex = computed(() => {
        return Math.max(0, testimonials.value.length - visibleSlides.value);
});

// Navigation methods
const nextSlide = () => {
        if (currentIndex.value < maxIndex.value) {
                currentIndex.value++;
        } else {
                currentIndex.value = 0; // Loop back to the beginning
        }
};

const prevSlide = () => {
        if (currentIndex.value > 0) {
                currentIndex.value--;
        } else {
                currentIndex.value = maxIndex.value; // Loop to the end
        }
};

// Update window width on resize
onMounted(() => {
        window.addEventListener('resize', () => {
                windowWidth.value = window.innerWidth;
                // Ensure current index is valid after resize
                if (currentIndex.value > maxIndex.value) {
                        currentIndex.value = maxIndex.value;
                }
        });

        // Set interval for automatic slide change
        const interval = setInterval(nextSlide, 3000); // Change slide every 3 seconds

        // Clear interval on component unmount
        onUnmounted(() => {
                clearInterval(interval);
        });
});
</script>
