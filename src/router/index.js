
import { createRouter, createWebHistory } from 'vue-router';
import Home from '../pages/Home.vue';
import About from '../pages/About.vue';
import Services from '../pages/Services.vue';
import Contact from '../pages/Contact.vue';
import Pricing from '../pages/Pricing.vue';
import Blog from '@/pages/Blog.vue';
import Portfolio from '@/pages/Portfolio.vue';  
import Workflow from '@/pages/Workflow.vue';
import Services_Ecomm from '@/pages/Services_Ecomm.vue';
import NotFound from '@/pages/NotFound.vue';
import Services_BgRemoval from '@/pages/Services_BgRemoval.vue';
import Services_PhotoRetouching from '@/pages/Services_PhotoRetouching.vue';
import Services_DigitalMarketing from '@/pages/Services_DigitalMarketing.vue';
import path from 'path';

const routes = [
    {
        path: '/',
        name: 'Home',
        component: Home,
    },
    {
        path: '/about',
        name: 'About',
        component: About,
    },
    {
        path: '/services',
        name: 'Services',
        component: Services,
    },
    {
        path: '/contact',
        name: 'Contact',
        component: Contact,
    },
    {
        path: '/pricing',
        name: 'Pricing',
        component: Pricing,
    },
    {
        path: '/blog',
        name: 'Blog',
        component: Blog,
    },
    {
        path: '/portfolio',
        name: 'Portfolio',
        component: Portfolio,
    },
    {
        path: '/workflow',
        name: 'Workflow',
        component: Workflow,
    },
    {
        path: '/services',
        name: 'Services',
        component: Services, // Default component
    },

    {
        path: '/services/Ecommerce-Photo-Editing',
        name: 'Ecommerce',
        component: Services_Ecomm, // Default component
    },
    {
        path: '/services/Background-Removal',
        name: 'BackgroundRemoval',
        component: Services_BgRemoval, // Default component
    },

        // Catch-all route for 404 Not Found
    {
            path: '/:pathMatch(.*)*',
            name: 'NotFound',
            component: NotFound,
    },
    {
        path: '/services/Photo-Retouching',
        name: 'PhotoRetouching',
        component: Services_PhotoRetouching, // Default component
    },
    {
        path: '/services/Digital-Marketing',
        name: 'DigitalMarketing',
        component: Services_DigitalMarketing, // Default component
    }

];

const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL),
    routes,
});

export default router;