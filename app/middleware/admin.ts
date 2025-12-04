export default defineNuxtRouteMiddleware(async () => {
  const supabase = useSupabaseClient()

  // Always fetch the authenticated user from Supabase to avoid undefined refs
  const { data: userData, error: userError } = await supabase.auth.getUser()

  if (userError || !userData?.user) {
    return navigateTo('/login')
  }

  const user = userData.user

  // Fetch user profile to check role
  const { data: profile, error } = await supabase
    .from('profiles')
    .select('role')
    .eq('id', user.id)
    .single()

  if (error || !profile) {
    console.error('Error fetching profile:', error)
    return navigateTo('/dashboard')
  }

  const role = (profile as { role?: string }).role

  // If not admin, redirect to dashboard
  if (role !== 'admin') {
    return navigateTo('/dashboard')
  }
})
