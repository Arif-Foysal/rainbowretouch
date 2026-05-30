export default defineNuxtRouteMiddleware(async (to) => {
  const user = useSupabaseUser()
  const supabase = useSupabaseClient()

  // Ensure we have the user info if it's missing (race condition fix)
  if (!user.value) {
     const { data } = await supabase.auth.getUser()
     if (data?.user) {
        user.value = data.user as any
     }
  }

  // Define public routes (exact matches)
  const publicRoutes = [
    '/',
    '/login',
    '/signup',
    '/forgot-password',
    '/reset-password',
    '/services',
    '/about',
    '/pricing',
    '/contact',
    '/portfolio',
    '/confirm'
  ]

  // Define public path prefixes
  const publicPrefixes = [
    '/blog',
    '/docs',
    '/changelog',
    '/services/' // Allow nested service routes if they exist
  ]

  // Check if route is public
  const isPublic = publicRoutes.includes(to.path) ||
    publicPrefixes.some(prefix => to.path.startsWith(prefix))

  // If user is NOT logged in and tries to access a protected route -> Redirect to Login
  if (!user.value && !isPublic) {
    return navigateTo('/login')
  }

  // If user IS logged in and tries to access Login/Signup -> Redirect based on role
  if (user.value && (to.path === '/login' || to.path === '/signup')) {
    const { data: profile } = await supabase
      .from('profiles')
      .select('role')
      .eq('id', user.value.id)
      .single()
    const role = (profile as { role?: string } | null)?.role
    return navigateTo(role === 'admin' ? '/admin' : '/dashboard')
  }
})
