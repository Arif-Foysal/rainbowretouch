<script setup>
import { ref } from 'vue';

import Navbar from '@/components/Navbar.vue';
import Hero from '@/components/Hero.vue';
import Tail from '@/components/Tail.vue';
import WithStats from './components/WithStats.vue';
import Testimonial from './components/Testimonial.vue';

import About from './pages/About.vue';
import Services from '@/pages/Services.vue';
import Home from './pages/Home.vue';
import Pricing from './pages/Pricing.vue';
import Contact from './pages/Contact.vue';
import Blog from './pages/Blog.vue';
import Portfolio from './pages/Portfolio.vue';
import Workflow from './pages/Workflow.vue';

import Modal from '@/components/Modal.vue';
import UploadForm from '@/components/UploadForm.vue';

const pages = [
    {
        title: 'Home',
        component: Home
    },
    {
        title: 'About',
        component: About
    },
    {
        title: 'Services',
        component: Services
    },
    {
        title: 'Pricing',
        component: Pricing
    },
    {
        title: 'Portfolio',
        component: Portfolio
    },
    {
        title: 'Blog',
        component: Blog
    },
    {
        title: 'Workflow',
        component: Workflow
    },
    {
        title: 'Contact',
        component: Contact
    }
];

const currentPageIndex = ref(0);
// const currentPage = ref(pages.value[currentPageIndex.value]);


function changePage(index) {
    currentPageIndex.value = index;
    window.scrollTo(0, 0); // Reset scroll position to top
}


const showContactModal = ref(false)

const openContactModal = () => {
  showContactModal.value = true
}

</script>

<template>
<Navbar 
    :pages="pages"
    :currentPageIndex="currentPageIndex"
    v-on:update:current-page-index="changePage"
    @open-contact-modal="openContactModal"
 />
 <component :is="pages[currentPageIndex].component"/>
 <div>


 </div>
 <Modal 
      v-model="showContactModal" 
      title="Free Trial" 
      size="lg"
    >
      <UploadForm :showSubmitButton="true" />
    </Modal>
 <Tail/>
</template>

<style scoped>

</style>
