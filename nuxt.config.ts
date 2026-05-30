// https://nuxt.com/docs/api/configuration/nuxt-config
const supabaseUrl = process.env.SUPABASE_URL

if (!supabaseUrl) {
  console.warn('SUPABASE_URL is missing in process.env!')
} else {
  console.log('Nuxt Config: Found SUPABASE_URL, extracting hostname...')
}

const supabaseDomain = supabaseUrl ? new URL(supabaseUrl).hostname : null
console.log('Nuxt Config: Added Supabase domain to image provider:', supabaseDomain)

export default defineNuxtConfig({
  modules: [
    '@nuxt/eslint',
    '@nuxt/image',
    '@nuxt/ui',
    '@nuxt/content',
    '@vueuse/nuxt',
    'nuxt-og-image',
    '@nuxtjs/supabase',
    '@vueuse/motion/nuxt'
  ],
  supabase: {
    redirect: false
  },
  devtools: {
    enabled: true
  },

  css: ['~/assets/css/main.css'],

  routeRules: {
    '/docs': { redirect: '/docs/getting-started', prerender: false },
    // CMS-driven pages: 60s SWR cache so admin edits go live without a redeploy
    // and Supabase isn't hit on every request.
    '/': { swr: 60 },
    '/about': { swr: 60 },
    '/services': { swr: 60 },
    '/services/**': { swr: 60 },
    '/portfolio': { swr: 60 },
    '/pricing': { swr: 60 },
    '/contact': { swr: 60 },
    '/blog': { swr: 60 },
    '/blog/**': { swr: 60 },
    // Admin / auth / user surfaces stay fully dynamic
    '/admin': { swr: false },
    '/admin-chat': { swr: false },
    '/admin-seo': { swr: false },
    '/admin-chat/**': { swr: false },
    '/dashboard': { swr: false },
    '/login': { swr: false },
    '/signup': { swr: false },
    '/forgot-password': { swr: false },
    '/reset-password': { swr: false }
  },

  compatibilityDate: '2024-07-11',

  sourcemap: { server: true, client: false },

  nitro: {
    prerender: {
      crawlLinks: false
    }
  },

  image: {
    provider: 'netlify',
    domains: ['jxrnbucgmfmgovgkjkoo.supabase.co', 'picsum.photos', supabaseDomain].filter((d): d is string => !!d)
  },

  eslint: {
    config: {
      stylistic: {
        commaDangle: 'never',
        braceStyle: '1tbs'
      }
    }
  }
})
