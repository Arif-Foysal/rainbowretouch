<script setup lang="ts">
const colorMode = useColorMode()
const route = useRoute()
const { seo } = useSeoSettings()

const themeColor = computed(() => {
  if (seo.value?.icons?.theme_color) return seo.value.icons.theme_color
  return colorMode.value === 'dark' ? '#020618' : '#ffffff'
})

const robotsContent = computed(() => {
  const r = seo.value?.robots || {}
  const parts: string[] = []
  parts.push(r.index === false ? 'noindex' : 'index')
  parts.push(r.follow === false ? 'nofollow' : 'follow')
  if (r.extra) parts.push(r.extra)
  return parts.join(', ')
})

const canonicalUrl = computed(() => {
  const base = (seo.value?.meta?.canonical_base || '').replace(/\/$/, '')
  return base ? `${base}${route.path}` : undefined
})

const headLinks = computed(() => {
  const links: any[] = []
  links.push({ rel: 'icon', href: seo.value?.icons?.favicon || '/favicon.ico' })
  if (seo.value?.icons?.apple_touch_icon) {
    links.push({ rel: 'apple-touch-icon', href: seo.value.icons.apple_touch_icon })
  }
  if (canonicalUrl.value) {
    links.push({ rel: 'canonical', href: canonicalUrl.value })
  }
  return links
})

const headMeta = computed(() => {
  const meta: any[] = [
    { charset: 'utf-8' },
    { name: 'viewport', content: 'width=device-width, initial-scale=1' },
    { key: 'theme-color', name: 'theme-color', content: themeColor.value },
    { name: 'robots', content: robotsContent.value }
  ]
  const m = seo.value?.meta || {}
  if (m.keywords) meta.push({ name: 'keywords', content: m.keywords })
  if (m.author) meta.push({ name: 'author', content: m.author })

  const v = seo.value?.verification || {}
  if (v.google) meta.push({ name: 'google-site-verification', content: v.google })
  if (v.bing) meta.push({ name: 'msvalidate.01', content: v.bing })
  if (v.pinterest) meta.push({ name: 'p:domain_verify', content: v.pinterest })
  if (v.facebook) meta.push({ name: 'facebook-domain-verification', content: v.facebook })
  if (v.yandex) meta.push({ name: 'yandex-verification', content: v.yandex })
  return meta
})

const headScripts = computed(() => {
  const scripts: any[] = []
  const a = seo.value?.analytics || {}
  if (a.gtm_id) {
    scripts.push({
      key: 'gtm',
      innerHTML: `(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src='https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);})(window,document,'script','dataLayer','${a.gtm_id}');`
    })
  }
  if (a.ga4_id) {
    scripts.push({ key: 'ga4-loader', src: `https://www.googletagmanager.com/gtag/js?id=${a.ga4_id}`, async: true })
    scripts.push({
      key: 'ga4-init',
      innerHTML: `window.dataLayer=window.dataLayer||[];function gtag(){dataLayer.push(arguments);}gtag('js',new Date());gtag('config','${a.ga4_id}');`
    })
  }
  if (a.plausible_domain && a.plausible_src) {
    scripts.push({ key: 'plausible', src: a.plausible_src, defer: true, 'data-domain': a.plausible_domain })
  }

  const s = seo.value?.schema || {}
  if (s.enabled !== false && s.name) {
    const ld: any = {
      '@context': 'https://schema.org',
      '@type': s.type || 'Organization',
      name: s.name
    }
    if (s.url) ld.url = s.url
    if (s.logo_url) ld.logo = s.logo_url
    if (s.phone || s.email) {
      ld.contactPoint = {
        '@type': 'ContactPoint',
        ...(s.phone ? { telephone: s.phone } : {}),
        ...(s.email ? { email: s.email } : {})
      }
    }
    if (s.street || s.city || s.region || s.postal_code || s.country) {
      ld.address = {
        '@type': 'PostalAddress',
        ...(s.street ? { streetAddress: s.street } : {}),
        ...(s.city ? { addressLocality: s.city } : {}),
        ...(s.region ? { addressRegion: s.region } : {}),
        ...(s.postal_code ? { postalCode: s.postal_code } : {}),
        ...(s.country ? { addressCountry: s.country } : {})
      }
    }
    if (Array.isArray(s.sameAs) && s.sameAs.length) ld.sameAs = s.sameAs
    scripts.push({ key: 'ld-org', type: 'application/ld+json', innerHTML: JSON.stringify(ld) })
  }
  return scripts
})

useHead({
  meta: headMeta,
  link: headLinks,
  script: headScripts,
  htmlAttrs: { lang: 'en' }
})

const seoMeta = computed(() => {
  const m = seo.value?.meta || {}
  const og = seo.value?.og || {}
  const tw = seo.value?.twitter || {}
  const o: Record<string, any> = {
    titleTemplate: m.title_template || '%s',
    ogType: og.type || 'website',
    twitterCard: tw.card || 'summary_large_image'
  }
  if (m.default_title) o.title = m.default_title
  if (m.default_description) {
    o.description = m.default_description
    o.ogDescription = m.default_description
  }
  if (og.site_name) o.ogSiteName = og.site_name
  if (og.locale) o.ogLocale = og.locale
  if (og.default_image) o.ogImage = og.default_image
  if (tw.site) o.twitterSite = tw.site
  if (tw.creator) o.twitterCreator = tw.creator
  const twImg = tw.default_image || og.default_image
  if (twImg) o.twitterImage = twImg
  return o
})

watchEffect(() => useSeoMeta(seoMeta.value))

const { data: navigation } = await useAsyncData('navigation', () => queryCollectionNavigation('docs'), {
  transform: data => data.find(item => item.path === '/docs')?.children || []
})
const { data: files } = useLazyAsyncData('search', () => queryCollectionSearchSections('docs'), {
  server: false
})

const links = [{
  label: 'Docs',
  icon: 'i-lucide-book',
  to: '/docs/getting-started'
}, {
  label: 'Pricing',
  icon: 'i-lucide-credit-card',
  to: '/pricing'
}, {
  label: 'Blog',
  icon: 'i-lucide-pencil',
  to: '/blog'
}, {
  label: 'Changelog',
  icon: 'i-lucide-history',
  to: '/changelog'
}]

provide('navigation', navigation)
</script>

<template>
  <UApp>
    <NuxtLoadingIndicator />

    <NuxtLayout>
      <NuxtPage />
    </NuxtLayout>

    <ClientOnly>
      <LazyUContentSearch
        :files="files"
        shortcut="meta_k"
        :navigation="navigation"
        :links="links"
        :fuse="{ resultLimit: 42 }"
      />
    </ClientOnly>
  </UApp>
</template>
