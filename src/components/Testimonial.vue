

<template>
	<section class="py-16 bg-white">
		<div class="max-w-4xl mx-auto text-center mb-12">
			<h4 class="text-blue-600 font-semibold text-lg mb-2">Testimonials</h4>
			<h2 class="text-4xl font-extrabold text-gray-900 mb-4">What our Clients Says</h2>
			<p class="text-gray-500 text-lg">There are many variations of passages of Lorem Ipsum available but the majority have suffered alteration in some form.</p>
		</div>
		<div class="max-w-6xl mx-auto relative">
			<div class="overflow-hidden">
				<div
					class="flex transition-transform duration-700"
					:style="{ transform: `translateX(-${currentSlide * 100}%)` }"
				>
					<div
						v-for="(group, idx) in groupedTestimonials"
						:key="idx"
						class="flex-shrink-0 w-full grid grid-cols-1 md:grid-cols-3 gap-8"
					>
						<div
							v-for="(testimonial, i) in group"
							:key="testimonial.name + i"
							class="bg-white rounded-xl shadow-lg p-8 flex flex-col items-center"
						>
							<div class="flex mb-4">
								<span v-for="n in 5" :key="n" class="text-yellow-400 text-xl">★</span>
							</div>
							<p class="text-gray-600 text-lg mb-6 text-center">{{ testimonial.text }}</p>
							<div class="flex items-center mt-auto">
								<img :src="testimonial.avatar" :alt="testimonial.name" class="w-12 h-12 rounded-full mr-4 border-2 border-blue-100" />
								<div class="text-left">
									<div class="font-bold text-gray-900">{{ testimonial.name }}</div>
									<div class="text-gray-500 text-sm">{{ testimonial.role }}</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- Navigation Buttons -->
			<div class="flex justify-center mt-10 space-x-4">
				<button @click="prevSlide" class="w-10 h-10 flex items-center justify-center rounded-full bg-blue-50 hover:bg-blue-100 text-blue-600 text-xl focus:outline-none">
					<span>&larr;</span>
				</button>
				<button @click="nextSlide" class="w-10 h-10 flex items-center justify-center rounded-full bg-blue-50 hover:bg-blue-100 text-blue-600 text-xl focus:outline-none">
					<span>&rarr;</span>
				</button>
			</div>
		</div>
	</section>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue';

const testimonials = [
	{
		name: 'Sabo Masties',
		role: 'Founder @ Rolex',
		avatar: 'https://randomuser.me/api/portraits/men/32.jpg',
		text: "Our members are so impressed. It's intuitive. It's clean. It's distraction free. If you're building a community.",
	},
	{
		name: 'Musharof Chowdhury',
		role: 'Founder @ Ayro UI',
		avatar: 'https://randomuser.me/api/portraits/men/33.jpg',
		text: "Our members are so impressed. It's intuitive. It's clean. It's distraction free. If you're building a community.",
	},
	{
		name: 'William Smith',
		role: 'Founder @ Trorex',
		avatar: 'https://randomuser.me/api/portraits/men/34.jpg',
		text: "Our members are so impressed. It's intuitive. It's clean. It's distraction free. If you're building a community.",
	},
	{
		name: 'Jane Doe',
		role: 'CEO @ Example',
		avatar: 'https://randomuser.me/api/portraits/women/44.jpg',
		text: "Absolutely love the service! The team is very professional and the results are amazing.",
	},
	{
		name: 'John Appleseed',
		role: 'Manager @ Apple',
		avatar: 'https://randomuser.me/api/portraits/men/45.jpg',
		text: "A seamless experience from start to finish. Highly recommended!",
	},
	{
		name: 'Emily Carter',
		role: 'Designer @ Behance',
		avatar: 'https://randomuser.me/api/portraits/women/46.jpg',
		text: "The best platform for creative professionals. I found exactly what I needed.",
	},
	{
		name: 'Michael Lee',
		role: 'Photographer @ Unsplash',
		avatar: 'https://randomuser.me/api/portraits/men/47.jpg',
		text: "Great support and fantastic results. Will use again!",
	},
	{
		name: 'Sara Kim',
		role: 'Founder @ Startup',
		avatar: 'https://randomuser.me/api/portraits/women/48.jpg',
		text: "A must-have for anyone looking to grow their business online.",
	},
	{
		name: 'David Brown',
		role: 'CTO @ Techies',
		avatar: 'https://randomuser.me/api/portraits/men/49.jpg',
		text: "Reliable, efficient, and easy to use. Five stars!",
	},
];

const cardsPerSlide = 3;
const currentSlide = ref(0);
const totalSlides = computed(() => Math.ceil(testimonials.length / cardsPerSlide));

const groupedTestimonials = computed(() => {
	const groups = [];
	for (let i = 0; i < testimonials.length; i += cardsPerSlide) {
		groups.push(testimonials.slice(i, i + cardsPerSlide));
	}
	return groups;
});

function nextSlide() {
	currentSlide.value = (currentSlide.value + 1) % totalSlides.value;
}
function prevSlide() {
	currentSlide.value = (currentSlide.value - 1 + totalSlides.value) % totalSlides.value;
}

let interval = null;
onMounted(() => {
	interval = setInterval(() => {
		nextSlide();
	}, 4000);
});
onUnmounted(() => {
	if (interval) clearInterval(interval);
});
</script>