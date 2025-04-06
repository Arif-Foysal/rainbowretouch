<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';
import logo from '@/assets/logo.png'; // Update the path to your logo
import Player from './Player.vue';

const viewFreeTrial = ref(true);
const mobileMenuOpen = ref(false);
const activeCategory = ref(null);

const props = defineProps({
    pages: Array,
    currentPageIndex: Number
});

const emit = defineEmits(['update:currentPageIndex']);

const changePage = (index) => {
    emit('update:currentPageIndex', index);
    // Close mobile menu when navigating
    if (mobileMenuOpen.value) {
        toggleMobileMenu();
    }
   
};

// Toggle mobile menu
const toggleMobileMenu = () => {
    mobileMenuOpen.value = !mobileMenuOpen.value;
    
    // When opening mobile menu, prevent body scrolling
    if (mobileMenuOpen.value) {
        document.body.style.overflow = 'hidden';
    } else {
        document.body.style.overflow = '';
    }
};

// Add this function after toggleMobileMenu
const closeMenu = () => {
    if (mobileMenuOpen.value) {
        mobileMenuOpen.value = false;
        document.body.style.overflow = '';
    }
};

// Toggle category in mobile view
const toggleCategory = (index) => {
    activeCategory.value = activeCategory.value === index ? null : index;
};

// Service categories with icons for the mega menu
const serviceCategories = [
  {
    title: "E-Commerce Photo Editing",
    icon: "/icons/image-icon.svg",
    services: [
      { name: "Clothing Photo Editing", url: "#" },
      { name: "Shoe Photo Editing", url: "#" },
      { name: "Hat and Bag Photo Editing", url: "#" },
      { name: "Eyeglass photo editing", url: "#" },
      { name: "Shoe product editing", url: "#" },
      { name: "Color Correction", url: "#" },
      { name: "Shadow Creation", url: "#" }
    ]
  },
  {
    title: "Background Removal",
    icon: "/icons/vfx-icon.svg",
    services: [
      { name: "Clipping Path Services", url: "#" },
      { name: "Reflection Shadow", url: "#" },
      { name: "Original Shadow", url: "#" },
      { name: "Drop Shadow", url: "#" },
      { name: "Image Masking Service", url: "#" },
        { name: "Ghost Mannequin", url: "#" },
        { name: "Color Correction", url: "#" }
    ]
  },
  {
    title: "Photo Retouching",
    icon: "/icons/web-icon.svg",
    services: [
      { name: "Headshot Retouching", url: "#" },
      { name: "Portrait Retouching", url: "#" },
      { name: "Model Retouching", url: "#" },
      { name: "Highend Retouching", url: "#" },
      { name: "Newborn Retouching", url: "#" },
      { name: "Wedding Photo Retouching", url: "#" }
    ]
  },
  {
    title: "Web Development",
    icon: "/icons/web-icon.svg",
    services: [
      { name: "Custom Website Development", url: "#" },
      { name: "Frontend Development", url: "#" },
      { name: "Backend Development", url: "#" },
      { name: "API Development & Integration", url: "#" },
      { name: "Database Design and Management", url: "#" }
    ]
  }
];

// Check if we're on mobile
const isMobile = () => {
    return window.innerWidth < 1024;
};

onMounted(() => {
  // Close dropdowns when clicking outside
  document.addEventListener('click', (e) => {
    if (!e.target.closest('.dropdown') && !e.target.closest('[data-collapse-toggle]')) {
      if (isMobile()) {
        // Don't auto-close on mobile as it interferes with the accordion behavior
      } else {
        // On desktop, we can close dropdowns when clicking elsewhere
        activeCategory.value = null;
      }
    }
  });

  // Handle window resize
  window.addEventListener('resize', () => {
    if (!isMobile()) {
      // Reset mobile menu state when resizing to desktop
      mobileMenuOpen.value = false;
      document.body.style.overflow = ''; // Reset body overflow
    }
  });
});

onBeforeUnmount(() => {
  // Clean up - reset body overflow when component is unmounted
  document.body.style.overflow = '';
});
</script>

<template>
<nav class="bg-gray-100 border-gray-200 sticky top-0 z-50">
    <!-- Previous green header div remains the same -->
    <div v-if="viewFreeTrial" class="bg-green-500 text-white text-center py-2 flex justify-between gap-4 items-center px-4">
      <div class="hidden md:flex items-center gap-2">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-whatsapp" viewBox="0 0 16 16">
          <path d="M13.601 2.326A7.85 7.85 0 0 0 7.994 0C3.627 0 .068 3.558.064 7.926c0 1.399.366 2.76 1.057 3.965L0 16l4.204-1.102a7.9 7.9 0 0 0 3.79.965h.004c4.368 0 7.926-3.558 7.93-7.93A7.9 7.9 0 0 0 13.6 2.326zM7.994 14.521a6.6 6.6 0 0 1-3.356-.92l-.24-.144-2.494.654.666-2.433-.156-.251a6.56 6.56 0 0 1-1.007-3.505c0-3.626 2.957-6.584 6.591-6.584a6.56 6.56 0 0 1 4.66 1.931 6.56 6.56 0 0 1 1.928 4.66c-.004 3.639-2.961 6.592-6.592 6.592m3.615-4.934c-.197-.099-1.17-.578-1.353-.646-.182-.065-.315-.099-.445.099-.133.197-.513.646-.627.775-.114.133-.232.148-.43.05-.197-.1-.836-.308-1.592-.985-.59-.525-.985-1.175-1.103-1.372-.114-.198-.011-.304.088-.403.087-.088.197-.232.296-.346.1-.114.133-.198.198-.33.065-.134.034-.248-.015-.347-.05-.099-.445-1.076-.612-1.47-.16-.389-.323-.335-.445-.34-.114-.007-.247-.007-.38-.007a.73.73 0 0 0-.529.247c-.182.198-.691.677-.691 1.654s.71 1.916.81 2.049c.098.133 1.394 2.132 3.383 2.992.47.205.84.326 1.129.418.475.152.904.129 1.246.08.38-.058 1.171-.48 1.338-.943.164-.464.164-.86.114-.943-.049-.084-.182-.133-.38-.232"/>
        </svg>
        <p class="font-semibold">+8801743987</p>
      </div>
      <div class="flex items-center gap-3">
        <p class="text-lg font-semibold">Get a free photo retouch — just upload your image!</p>
        <button class="bg-gray-900 text-white font-semibold p-2 rounded-md hover:bg-gray-800">Upload Now</button>
      </div>
      
      <button @click="viewFreeTrial=false;" class="text-white bg-red-500 font-bold p-1 rounded-md">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-lg" viewBox="0 0 16 16">
          <path d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8z"/>
        </svg>
      </button>
    </div>
    <div class="max-w-screen-xl flex flex-wrap items-center justify-between mx-auto px-4 relative">
        <a href="index.php" class="flex items-center space-x-3 rtl:space-x-reverse">
            <img :src="logo" class="h-16" alt="Momen Logo" />
        </a>
        <button @click="toggleMobileMenu" data-collapse-toggle="navbar-default" type="button" class="inline-flex items-center p-2 w-10 h-10 justify-center text-sm text-gray-500 rounded-lg lg:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 hamburger-button" aria-controls="navbar-default" :aria-expanded="mobileMenuOpen">
            <span class="sr-only">{{ mobileMenuOpen ? 'Close main menu' : 'Open main menu' }}</span>
            <!-- Always use hamburger icon -->
            <svg class="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 17 14">
              <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 1h15M1 7h15M1 13h15"/>
            </svg>
        </button>
        <div :class="['lg:block lg:w-auto', mobileMenuOpen ? 'block w-full mobile-menu-container' : 'hidden w-full']" id="navbar-default">
            <ul class="font-medium flex flex-col p-4 lg:p-0 mt-4 border border-gray-100 rounded-lg bg-gray-50 lg:flex-row lg:space-x-8 rtl:space-x-reverse lg:mt-0 lg:border-0 lg:bg-gray-100 mobile-menu-content">
                <li>
                    <a @click.prevent="changePage(0)" href="index.php" :class="['block py-2 px-3 lg:p-0 text-lg font-semibold hover:text-black', currentPageIndex === 0 ? ' border-b-4 border-indigo-600' : 'text-gray-700']" aria-current="page">Home</a>
                </li>
                <li>
                    <a @click.prevent="changePage(1)" href="about.php" :class="['block py-2 px-3 lg:p-0 text-lg font-semibold hover:text-black hover:border-indigo-400', currentPageIndex === 1 ? 'border-b-4 border-indigo-600' : 'text-gray-700']">About</a>
                </li>
                <li class="dropdown services-dropdown">
                    <!-- Services dropdown trigger -->
                    <a 
                      href="#" 
                      :class="['block py-2 px-3 lg:p-0 text-lg font-semibold hover:text-black hover:border-indigo-400', currentPageIndex === 2 ? 'border-b-4 border-indigo-600' : 'text-gray-700']" 
                      aria-current="page"
                    >
                        <div class="flex items-center justify-between">
                            <p>Services</p>
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-down ml-1" viewBox="0 0 16 16">
                                <path fill-rule="evenodd" d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708"/>
                            </svg>
                        </div>
                    </a>
                    
                    <!-- Desktop Mega Menu -->
                    <div class="mega-menu">
                        <div class="mega-menu-container">
                            <div class="mega-menu-header">
                                <h3 class="text-xl font-bold text-gray-800">Our Services</h3>
                                <p class="text-gray-600">Professional solutions for your business needs</p>
                            </div>
                            <div class="mega-menu-content">
                                <div v-for="(category, index) in serviceCategories" :key="index" class="mega-menu-category">
                                    <div class="category-header">
                                        <div class="category-icon">
                                            <img :src="category.icon" alt="" class="w-6 h-6">
                                        </div>
                                        <h4 class="category-title">{{ category.title }}</h4>
                                    </div>
                                    <ul class="category-services">
                                        <li v-for="(service, sIndex) in category.services" :key="sIndex">
                                            <a :href="service.url" class="service-link">{{ service.name }}</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="mega-menu-footer">
                                <a @click.prevent="changePage(2)" href="#" class="view-all-services">View all services</a>
                                <a href="#" class="request-quote">Request a quote</a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Mobile Accordion Menu -->
                    <div class="mobile-mega-menu lg:hidden mt-2">
                        <div v-for="(category, index) in serviceCategories" :key="index" class="mobile-category">
                            <button @click="toggleCategory(index)" class="mobile-category-header">
                                <div class="flex items-center">
                                    <div class="category-icon mr-2">
                                        <img :src="category.icon" alt="" class="w-5 h-5">
                                    </div>
                                    <span>{{ category.title }}</span>
                                </div>
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" 
                                    :class="['transition-transform', activeCategory === index ? 'rotate-180' : '']"
                                    viewBox="0 0 16 16">
                                    <path fill-rule="evenodd" d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708"/>
                                </svg>
                            </button>
                            <div v-show="activeCategory === index" class="mobile-category-content">
                                <a v-for="(service, sIndex) in category.services" 
                                   :key="sIndex" 
                                   :href="service.url" 
                                   @click="closeMenu"
                                   class="mobile-service-link">
                                    {{ service.name }}
                                </a>
                            </div>
                        </div>
                        <div class="mobile-mega-footer">
                            <a href="#" @click="closeMenu" class="mobile-view-all">View all services</a>
                        </div>
                    </div>
                </li>
                <!-- Rest of the menu items remain the same -->
                <li>
                    <a @click.prevent="changePage(3)" href="pricing.php" :class="['block py-2 px-3 lg:p-0 text-lg font-semibold hover:text-black', currentPageIndex === 3 ? 'border-b-4 border-indigo-600' : 'text-gray-700']">Pricing</a>
                </li>
                <li>
                    <a @click.prevent="changePage(4)" href="#" :class="['block py-2 px-3 lg:p-0 text-lg font-semibold hover:text-black', currentPageIndex === 4 ? 'border-b-4 border-indigo-600' : 'text-gray-700']">Portfolio</a>
                </li>
                <li>
                    <a @click.prevent="changePage(5)" href="blog.php" :class="['block py-2 px-3 lg:p-0 text-lg font-semibold hover:text-black', currentPageIndex === 5 ? 'border-b-4 border-indigo-600' : 'text-gray-700']">Blog</a>
                </li>
                <li>
                    <a @click.prevent="changePage(6)" href="workflow.php" :class="['block py-2 px-3 lg:p-0 text-lg font-semibold hover:text-black', currentPageIndex === 6 ? 'border-b-4 border-indigo-600' : 'text-gray-700']">Workflow</a>
                </li>
                <li>
                    <a @click.prevent="changePage(7)" href="contact.php" :class="['block py-2 px-3 lg:p-0 text-lg font-semibold hover:text-black', currentPageIndex === 7 ? 'border-b-4 border-indigo-600' : 'text-gray-700']">Contact</a>
                </li>
                
                <li class="dropdown">
                    <a href="#" class="block py-2 px-3 lg:p-0 text-lg text-gray-700 font-semibold hover:text-black dropdown-trigger" aria-current="page">
                        <div class="flex items-center justify-between">
                            <p>Account</p>
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-down ml-1" viewBox="0 0 16 16">
                                <path fill-rule="evenodd" d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708"/>
                            </svg>
                        </div>
                    </a>
                    <div class="dropdown-content">
                        <div class="dropdown-content-container">
                            <a href="profile.php" @click="closeMenu" class="dropdown-item">Dashboard</a>
                            <a href="signup.php" @click="closeMenu" class="dropdown-item">Sign Up</a>
                            <a href="login.php" @click="closeMenu" class="dropdown-item">Log In</a>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="fixed bottom-0 left-0 w-full z-50">
    <Player />
</div>
</template>

<style scoped>  
/* Base dropdown styles */
.dropdown {
    position: relative;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 200px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
    top: 100%;
}

/* Hamburger button fix */
.hamburger-button {
    position: relative;
    z-index: 60; /* Higher than the mobile menu */
    background-color: white; /* Make it visible */
}

/* Mobile menu scrolling fix */
.mobile-menu-container {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    z-index: 50;
    padding-top: 5rem;
    background-color: rgba(0, 0, 0, 0.5);
    overflow-y: auto;
    -webkit-overflow-scrolling: touch;
}

.mobile-menu-content {
    max-height: 100%;
    overflow-y: auto;
    padding-top: 1rem; /* Add some space at the top */
}

/* Mega Menu Styles */
.services-dropdown {
    position: static; /* Make the dropdown container full-width */
}

.mega-menu {
    display: none;
    position: absolute;
    left: 0;
    width: 100%;
    background-color: #ffffff;
    box-shadow: 0 8px 16px rgba(0,0,0,0.1);
    z-index: 100;
    padding: 0;
    margin-top: 1px;
    border-top: 3px solid #4f46e5; /* Indigo accent */
}

.mega-menu-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 1.5rem;
}

.mega-menu-header {
    padding-bottom: 1rem;
    margin-bottom: 1.5rem;
    border-bottom: 1px solid #e5e7eb;
}

.mega-menu-content {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 2rem;
}

.mega-menu-category {
    display: flex;
    flex-direction: column;
}

.category-header {
    display: flex;
    align-items: center;
    margin-bottom: 1rem;
}

.category-icon {
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    background-color: #f3f4f6;
    border-radius: 8px;
    margin-right: 0.75rem;
    color: #4f46e5; /* Indigo color for icons */
}

.category-title {
    font-size: 1.125rem;
    font-weight: 600;
    color: #1f2937;
}

.category-services {
    list-style: none;
    padding: 0;
    margin: 0;
}

.category-services li {
    margin-bottom: 0.5rem;
}

.service-link {
    display: block;
    padding: 0.5rem 0.75rem;
    color: #4b5563;
    text-decoration: none;
    border-radius: 4px;
    transition: all 0.2s ease;
}

.service-link:hover {
    background-color: #f3f4f6;
    color: #4f46e5;
}

/* Fix for the mega-menu-footer issue */
.mega-menu-footer {
    display: flex;
    justify-content: space-between;
    margin-top: 1.5rem;
    padding-top: 1.5rem;
    border-top: 1px solid #e5e7eb;
    position: relative; /* Add position relative */
    z-index: 2; /* Ensure it's above other elements */
}

/* Make sure there's no gap between content and footer */
.mega-menu-content + .mega-menu-footer {
    margin-top: 0;
    padding-top: 1.5rem;
}

.view-all-services, .request-quote {
    display: inline-block;
    padding: 0.5rem 1rem;
    border-radius: 4px;
    font-weight: 500;
    transition: all 0.2s ease;
}

.view-all-services {
    color: #4f46e5;
    background-color: #eef2ff;
}

.request-quote {
    color: #ffffff;
    background-color: #4f46e5;
}

.view-all-services:hover, .request-quote:hover {
    opacity: 0.9;
}

/* Mobile Mega Menu Styles */
.mobile-mega-menu {
    background-color: #f9f9f9;
    border-radius: 8px;
    margin-left: 1rem;
    overflow: hidden;
}

.mobile-category {
    border-bottom: 1px solid #e5e7eb;
}

.mobile-category:last-child {
    border-bottom: none;
}

.mobile-category-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
    padding: 0.75rem 1rem;
    background-color: transparent;
    border: none;
    text-align: left;
    font-weight: 500;
    cursor: pointer;
}

.mobile-category-header:hover {
    background-color: #f3f4f6;
}

.mobile-category-content {
    display: flex;
    flex-direction: column;
    padding: 0.5rem 0;
    background-color: #f0f0f0;
}

.mobile-service-link {
    padding: 0.5rem 1rem 0.5rem 3rem;
    color: #4b5563;
    text-decoration: none;
    transition: background-color 0.2s;
}

.mobile-service-link:hover {
    background-color: #e5e7eb;
    color: #4f46e5;
}

.mobile-mega-footer {
    padding: 1rem;
    border-top: 1px solid #e5e7eb;
    text-align: center;
}

.mobile-view-all {
    display: block;
    padding: 0.75rem;
    background-color: #4f46e5;
    color: white;
    border-radius: 4px;
    font-weight: 500;
    text-align: center;
}

/* Desktop hover styles */
@media (min-width: 1024px) {
    .dropdown:hover .dropdown-content {
        display: block;
    }

    /* Make the mega menu appear when hovering over the services dropdown */
    .services-dropdown:hover .mega-menu {
        display: block;
    }
    
    /* This is the key fix - make the mega menu stay visible when hovering over it */
    .mega-menu:hover {
        display: block;
    }

    /* Ensure main dropdown appears below the button */
    .dropdown {
        padding-bottom: 5px;
    }
    
    /* Reset mobile menu styles on desktop */
    .mobile-menu-container {
        position: static;
        padding-top: 0;
        background-color: transparent;
        overflow-y: visible;
    }
    
    .mobile-menu-content {
        max-height: none;
        overflow-y: visible;
        padding-top: 0;
    }
}

/* Mobile styles */
@media (max-width: 1023px) {
    .dropdown-content {
        position: static;
        box-shadow: none;
        width: 100%;
        border-top: none;
    }

    .dropdown-content.show {
        display: block;
    }
    
    .dropdown-item {
        padding: 0.75rem 1rem;
    }
}

/* General styles */
.dropdown-item {
    padding: 0.5rem 1rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    cursor: pointer;
    background-color: #f9f9f9;
}

.dropdown-item:hover {
    background-color: #f0f0f0;
}

/* Add background to the dropdown content container */
.dropdown-content-container {
    background-color: #f9f9f9;
    border-radius: 4px;
    /* Add a subtle border */
    border: 1px solid rgba(0,0,0,0.1);
}
</style>

