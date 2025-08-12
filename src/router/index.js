
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
import Login from '@/pages/Login.vue';
import Register from '@/pages/Register.vue';
import Profile from '@/pages/Profile.vue';
import DebugCsrf from '@/pages/DebugCsrf.vue';
import Dashboard from '@/pages/Dashboard.vue';
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
        path: '/login',
        name: 'Login',
        component: Login,
    },
    {
        path: '/register',
        name: 'Register',
        component: Register,
    },
    {
        path: '/profile',
        name: 'Profile',
        component: Profile,
        meta: { requiresAuth: true },
    },
    {
        path: '/debug-csrf',
        name: 'DebugCsrf',
        component: DebugCsrf,
    },
    {
        path: '/services/Ecommerce-Photo-Editing',
        name: 'Ecommerce',
        component: Services_Ecomm,
    },
    {
        path: '/services/Background-Removal',
        name: 'BackgroundRemoval',
        component: Services_BgRemoval,
    },
    {
        path: '/services/Photo-Retouching',
        name: 'PhotoRetouching',
        component: Services_PhotoRetouching,
    },
    {
        path: '/services/Digital-Marketing',
        name: 'DigitalMarketing',
        component: Services_DigitalMarketing,
    },
    // Catch-all route for 404 Not Found - must be last
    {
        path: '/:pathMatch(.*)*',
        name: 'NotFound',
        component: NotFound,
    },
    {
        path: '/dashboard',
        name: 'Dashboard',
        component: Dashboard,
        meta: { requiresAuth: true },
    },
    {
        path: '/analytics',
        name: 'Analytics',
        component: () => import('@/pages/Analytics.vue'),
        meta: { requiresAuth: true },
    },
    {
        path: '/reports',
        name: 'Reports',
        component: () => import('@/pages/Reports.vue'),
        meta: { requiresAuth: true },
    },
    {
        path: '/orders',
        name: 'Orders',
        component: () => import('@/pages/Orders.vue'),
        meta: { requiresAuth: true },
    },
    {
        path: '/users',
        name: 'Users',
        component: () => import('@/pages/Users.vue'),
        meta: { requiresAuth: true },
    },
    {
        path: '/uploads',
        name: 'Uploads',
        component: () => import('@/pages/Upload.vue'),
        meta: { requiresAuth: true },
    },
    {
        path: '/settings',
        name: 'Settings',
        component: () => import('@/pages/Settings.vue'),
        meta: { requiresAuth: true },
    }
];

const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL),
    routes,
});

// Navigation guard to check auth status for protected routes
router.beforeEach((to, from, next) => {
    // Check if the route requires authentication
    if (to.matched.some(record => record.meta.requiresAuth)) {
        // Check if user is authenticated
        const token = localStorage.getItem('auth_token');
        if (!token) {
            // User is not authenticated, redirect to login
            next({ name: 'Login' });
        } else {
            // User is authenticated, proceed
            next();
        }
    } else {
        // Route doesn't require auth, proceed
        next();
    }
});

export default router;