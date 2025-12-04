// https://nuxt.com/docs/api/configuration/nuxt-config
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
        '/', '/about', '/blog/**', '/services', '/docs/**', '/pricing', '/changelog/**', '/signup', '/login', '/contact', '/portfolio'
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

  eslint: {
    config: {
      stylistic: {
        commaDangle: 'never',
        braceStyle: '1tbs'
      }
    }
  }
})
