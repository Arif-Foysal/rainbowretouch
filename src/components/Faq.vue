<template>
  <section class="py-12 bg-gradient-to-br from-indigo-50 via-purple-50 to-pink-50">
    <div class="container mx-auto px-4">
      <div class="grid md:grid-cols-2 gap-8 items-start" ref="faqSection">
        <div class="opacity-0" :class="{ 'animate-fade-slide-left': isVisible }">
          <h2 class="text-4xl font-bold mb-4 text-gray-900">Frequently Asked Questions</h2>
          <p class="text-gray-600 mb-6">Find answers to common questions about our services, booking process, and policies. If you need further assistance, don't hesitate to contact us.</p>
          <div class="hidden md:block">
            <a href="#contact" class="inline-flex items-center text-gray-700 hover:text-gray-900 font-medium ">
              Still have questions? Contact us
              <svg class="w-5 h-5 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3"/>
              </svg>
            </a>
          </div>
        </div>
        <div class="space-y-4 opacity-0" :class="{ 'animate-fade-slide-right': isVisible }">
          <div v-for="(item, index) in faqItems" :key="index" 
               class="bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-200 border-l-4"
               :class="[item.isOpen ? 'border-purple-500' : 'border-transparent']">
            <button 
              @click="toggleItem(index)"
              class="w-full px-6 py-4 text-left flex justify-between items-center hover:bg-purple-50 transition-colors duration-200"
            >
              <span class="text-lg font-medium" :class="[item.isOpen ? 'text-purple-700' : 'text-gray-900']">
                {{ item.question }}
              </span>
              <svg 
                class="w-5 h-5 transform transition-transform duration-200"
                :class="[item.isOpen ? 'text-purple-600 rotate-180' : 'text-gray-400']"
                xmlns="http://www.w3.org/2000/svg" 
                viewBox="0 0 20 20" 
                fill="currentColor"
              >
                <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
              </svg>
            </button>
            <div 
              v-show="item.isOpen" 
              class="px-6 pb-4"
            >
              <p class="text-gray-600">{{ item.answer }}</p>
            </div>
          </div>
        </div>
        <div class="md:hidden text-center mt-6">
          <a href="#contact" class="inline-flex items-center text-gray-700 hover:text-gray-900 font-medium">
            Still have questions? Contact us
            <svg class="w-5 h-5 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3"/>
            </svg>
          </a>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  name: 'Faq',
  data() {
    return {
      isVisible: false,
      faqItems: [
        {
          question: "What services do you offer?",
          answer: "We offer a comprehensive range of beauty and wellness services including haircuts, styling, coloring, facials, manicures, pedicures, and more.",
          isOpen: false
        },
        {
          question: "How can I book an appointment?",
          answer: "You can book an appointment through our website, mobile app, or by calling our salon directly. We recommend booking in advance to ensure availability.",
          isOpen: false
        },
        {
          question: "What are your working hours?",
          answer: "We are open Monday through Saturday from 9:00 AM to 8:00 PM, and Sundays from 10:00 AM to 6:00 PM.",
          isOpen: false
        },
        {
          question: "Do you offer gift cards?",
          answer: "Yes, we offer digital and physical gift cards in various denominations. They can be purchased online or at our salon.",
          isOpen: false
        },
        {
          question: "What is your cancellation policy?",
          answer: "We require at least 24 hours notice for cancellations. Late cancellations or no-shows may result in a cancellation fee.",
          isOpen: false
        }
      ]
    }
  },
  mounted() {
    this.setupIntersectionObserver();
  },
  methods: {
    setupIntersectionObserver() {
      const options = {
        root: null,
        rootMargin: '0px',
        threshold: 0.3
      };

      const observer = new IntersectionObserver(([entry]) => {
        if (entry.isIntersecting) {
          this.isVisible = true;
          observer.unobserve(entry.target);
        }
      }, options);

      observer.observe(this.$refs.faqSection);
    },
    toggleItem(index) {
      this.faqItems = this.faqItems.map((item, i) => ({
        ...item,
        isOpen: i === index ? !item.isOpen : false
      }))
    }
  }
}
</script>

<style>
@keyframes fadeSlideLeft {
  from {
    opacity: 0;
    transform: translateX(-100px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

@keyframes fadeSlideRight {
  from {
    opacity: 0;
    transform: translateX(100px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

.animate-fade-slide-left {
  animation: fadeSlideLeft 1s ease-out forwards;
}

.animate-fade-slide-right {
  animation: fadeSlideRight 1s ease-out 0.3s forwards;
}
</style>