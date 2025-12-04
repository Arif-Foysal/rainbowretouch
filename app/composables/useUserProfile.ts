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

  const fetchProfile = async () => {
    if (!user.value) {
      profile.value = null
      return null
    }

    const { data, error } = await supabase
      .from('profiles')
      .select('*')
      .eq('id', user.value.id)
      .single()

    if (error) {
      console.error('Error fetching profile:', error)
      return null
    }

    profile.value = (data as UserProfile) || null
    return data
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
    isAdmin: readonly(isAdmin),
    fetchProfile,
    updateProfile
  }
}
