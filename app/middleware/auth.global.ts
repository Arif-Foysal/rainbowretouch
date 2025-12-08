export default defineNuxtRouteMiddleware((to) => {
    const user = useSupabaseUser()

    // Public routes that don't satisfy the "starts with" logic or are exact matches
    const publicRoutes = [
        '/',
        '/login',
        '/signup',
        '/services',
        '/about',
        '/pricing',
        '/contact',
        '/portfolio',
        '/confirm'
    ]

    // Check if route is public
    const isPublic = publicRoutes.includes(to.path) ||
        to.path.startsWith('/blog') ||
        to.path.startsWith('/docs') ||
        to.path.startsWith('/changelog')

    // If user is NOT logged in and tries to access a protected route -> Redirect to Login
    if (!user.value && !isPublic) {
        return navigateTo('/login')
    }

    // If user IS logged in and tries to access Login/Signup -> Redirect to Dashboard
    if (user.value && (to.path === '/login' || to.path === '/signup')) {
        return navigateTo('/dashboard')
    }
})
