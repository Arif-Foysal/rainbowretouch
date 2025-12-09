type UserProfile = {
  id: string
  email?: string | null
  full_name?: string | null
  avatar_url?: string | null
  role?: 'user' | 'admin' | null
}

export const useUserProfile = () => {
  const supabase = useSupabaseClient<any>()
  const user = useSupabaseUser()

  const profile = useState<UserProfile | null>('userProfile', () => null)
  const isAdmin = computed(() => profile.value?.role === 'admin')
  const loading = useState('userProfileLoading', () => false)

  const fetchProfile = async (explicitUserId?: string) => {
    let userId = explicitUserId || user.value?.id

    if (!userId) {
      const { data: authData } = await supabase.auth.getUser()
      if (authData?.user?.id) {
         userId = authData.user.id
      } else {
         profile.value = null
         return null
      }
    }

    // Return existing profile if we have it and it matches the requested user
    if (profile.value && profile.value.id === userId && !explicitUserId) {
      return profile.value
    }

    loading.value = true
    try {
      const { data, error } = await supabase
        .from('profiles')
        .select('*')
        .eq('id', userId)
        .single()

      if (error) {
        console.error('Error fetching profile:', error)
        return null
      }

      profile.value = (data as UserProfile) || null
      return data
    } finally {
      loading.value = false
    }
  }

  const updateProfile = async (updates: Partial<UserProfile>) => {
    if (!user.value) return { error: new Error('No user') }

    const { data, error } = await supabase
      .from('profiles')
      .update(updates)
      .eq('id', user.value.id)
      .select()
      .single()

    if (!error && data) {
      profile.value = data as UserProfile
    }

    return { data, error }
  }

  return {
    profile: readonly(profile),
    isAdmin, // Allow this to be reactive
    loading: readonly(loading),
    fetchProfile,
    updateProfile
  }
}
