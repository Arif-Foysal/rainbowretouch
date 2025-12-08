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
    redirectOptions: {
      login: '/login',
      callback: '/confirm',
      exclude: [
        '/', '/about', '/blog/**', '/services', '/docs/**', '/pricing', '/changelog/**', '/signup', '/login', '/contact', '/portfolio', '/blog'
      ]
    }
  },
  devtools: {
    enabled: true
  },

  css: ['~/assets/css/main.css'],

  routeRules: {
    '/docs': { redirect: '/docs/getting-started', prerender: false }
  },

  compatibilityDate: '2024-07-11',

  nitro: {
    prerender: {
      routes: [
        '/'
      ],
      crawlLinks: true
    }
  },

  image: {
    provider: 'ipx',
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
