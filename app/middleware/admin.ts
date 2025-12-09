export default defineNuxtRouteMiddleware(async (to, from) => {
  const { isAdmin, fetchProfile } = useUserProfile()

  // Ensure we have the latest profile data
  await fetchProfile()

  if (!isAdmin.value) {
    return navigateTo('/dashboard')
  }
})
