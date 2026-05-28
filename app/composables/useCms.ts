/**
 * CMS composables. All reads via Supabase client (RLS enforces public/admin).
 * SSR-friendly via useAsyncData.
 */

type SiteSettingValue = Record<string, any>

export const useSiteSettings = () => {
  const supabase = useSupabaseClient()
  return useAsyncData('cms:site_settings', async () => {
    const { data, error } = await supabase
      .from('site_settings')
      .select('key, value')
    if (error) {
      console.error('site_settings fetch error', error)
      return {} as Record<string, SiteSettingValue>
    }
    const map: Record<string, SiteSettingValue> = {}
    for (const row of (data as any[]) ?? []) map[row.key] = row.value || {}
    return map
  }, { default: () => ({} as Record<string, SiteSettingValue>) })
}

export const useHeroSlides = () => {
  const supabase = useSupabaseClient()
  return useAsyncData('cms:hero_slides', async () => {
    const { data } = await supabase
      .from('hero_slides')
      .select('*')
      .eq('is_active', true)
      .order('order_index', { ascending: true })
    return (data as any[]) ?? []
  }, { default: () => [] as any[] })
}

export const useTestimonials = () => {
  const supabase = useSupabaseClient()
  return useAsyncData('cms:testimonials', async () => {
    const { data } = await supabase
      .from('testimonials')
      .select('*')
      .eq('is_active', true)
      .order('order_index', { ascending: true })
    return (data as any[]) ?? []
  }, { default: () => [] as any[] })
}

export const useFaqs = (category?: string) => {
  const supabase = useSupabaseClient()
  const key = category ? `cms:faqs:${category}` : 'cms:faqs'
  return useAsyncData(key, async () => {
    let q = supabase
      .from('faqs')
      .select('*')
      .eq('is_active', true)
      .order('order_index', { ascending: true })
    if (category) q = q.eq('category', category)
    const { data } = await q
    return (data as any[]) ?? []
  }, { default: () => [] as any[] })
}

export const usePricingPlans = () => {
  const supabase = useSupabaseClient()
  return useAsyncData('cms:pricing_plans', async () => {
    const { data } = await supabase
      .from('pricing_plans')
      .select('*')
      .eq('is_active', true)
      .order('order_index', { ascending: true })
    return (data as any[]) ?? []
  }, { default: () => [] as any[] })
}

export const usePortfolioItems = () => {
  const supabase = useSupabaseClient()
  return useAsyncData('cms:portfolio', async () => {
    const { data } = await supabase
      .from('portfolio_items')
      .select('*')
      .eq('is_active', true)
      .order('order_index', { ascending: true })
    return (data as any[]) ?? []
  }, { default: () => [] as any[] })
}

export const useTeamMembers = () => {
  const supabase = useSupabaseClient()
  return useAsyncData('cms:team', async () => {
    const { data } = await supabase
      .from('team_members')
      .select('*')
      .eq('is_active', true)
      .order('order_index', { ascending: true })
    return (data as any[]) ?? []
  }, { default: () => [] as any[] })
}

export const useBlogPosts = () => {
  const supabase = useSupabaseClient()
  return useAsyncData('cms:blog_posts', async () => {
    const { data } = await supabase
      .from('blog_posts')
      .select('*')
      .eq('is_published', true)
      .order('published_at', { ascending: false })
    return (data as any[]) ?? []
  }, { default: () => [] as any[] })
}
