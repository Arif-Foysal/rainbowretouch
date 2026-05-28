export type SeoSettings = {
  meta?: {
    default_title?: string
    title_template?: string
    default_description?: string
    keywords?: string
    author?: string
    canonical_base?: string
  }
  og?: {
    site_name?: string
    type?: string
    locale?: string
    default_image?: string
  }
  twitter?: {
    card?: string
    site?: string
    creator?: string
    default_image?: string
  }
  robots?: {
    index?: boolean
    follow?: boolean
    extra?: string
  }
  icons?: {
    favicon?: string
    apple_touch_icon?: string
    theme_color?: string
  }
  verification?: {
    google?: string
    bing?: string
    pinterest?: string
    facebook?: string
    yandex?: string
  }
  analytics?: {
    ga4_id?: string
    gtm_id?: string
    plausible_domain?: string
    plausible_src?: string
  }
  schema?: {
    enabled?: boolean
    type?: string
    name?: string
    logo_url?: string
    url?: string
    phone?: string
    email?: string
    street?: string
    city?: string
    region?: string
    postal_code?: string
    country?: string
    sameAs?: string[]
  }
}

export const useSeoSettings = () => {
  const { data: settings } = useSiteSettings()
  const seo = computed<SeoSettings>(() => (settings.value?.seo || {}) as SeoSettings)
  return { seo }
}
