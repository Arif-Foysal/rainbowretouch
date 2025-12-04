<script setup lang="ts">
const route = useRoute()

const items = computed(() => [
{
  label: 'Home',
  icon: 'i-lucide-home',
  to: '/',
  active: route.path === '/'
}, 
{
  label: 'About',
  to: '/about',
  active: route.path === '/about',
  icon: 'i-lucide-store'

},
{
  label: 'Services',
  to: '/services',
  active: route.path === '/services',
  icon: 'i-lucide-image-plus',
  children: [
      {
        label: 'Introduction',
        description: 'Fully styled and customizable components for Nuxt.',
        icon: 'i-lucide-house'
      },
      {
        label: 'Installation',
        description: 'Learn how to install and configure Nuxt UI in your application.',
        icon: 'i-lucide-cloud-download'
      },
      {
        label: 'Icons',
        icon: 'i-lucide-smile',
        description: 'You have nothing to do, @nuxt/icon will handle it automatically.'
      },
      {
        label: 'Colors',
        icon: 'i-lucide-swatch-book',
        description: 'Choose a primary and a neutral color from your Tailwind CSS theme.'
      },
      {
        label: 'Theme',
        icon: 'i-lucide-cog',
        description: 'You can customize components by using the `class` / `ui` props or in your app.config.ts.'
      }
    ]
},
{
  label: 'Portfolio',
  to: '/portfolio',
  active: route.path === '/portfolio',
  icon: 'i-lucide-briefcase'
},
{
  label: 'Docs',
  icon: 'i-lucide-book-open',
  to: '/docs',
  active: route.path.startsWith('/docs')
}, {
  label: 'Pricing',
  to: '/pricing',
  icon: 'i-lucide-tag',
  
}, {
  label: 'Blog',
  to: '/blog'
},
{
  label: 'Contact',
  to: '/contact',
  icon: 'i-lucide-mail'
}
])
</script>

<template>
  <UHeader>
    <template #left>
      <NuxtLink to="/">
        <AppLogo class="w-auto h-14 shrink-0" />
        <!-- <Logo/> -->
      </NuxtLink>
      <!-- <TemplateMenu /> -->
    </template>

    <UNavigationMenu
      :items="items"
      variant="pill"
      
    />

    <template #right>
      <UColorModeButton />

      <UButton
        icon="i-lucide-log-in"
        color="neutral"
        variant="ghost"
        to="/login"
        class="lg:hidden"
      />

      <UButton
        label="Sign in"
        color="neutral"
        variant="outline"
        to="/login"
        class="hidden lg:inline-flex"
      />

      <UButton
        label="Sign up"
        color="neutral"
        trailing-icon="i-lucide-arrow-right"
        class="hidden lg:inline-flex"
        to="/signup"
      />
    </template>

    <template #body>
      <UNavigationMenu
        :items="items"
        orientation="vertical"
        class="-mx-2.5"
      />

      <USeparator class="my-6" />

      <UButton
        label="Sign in"
        color="neutral"
        variant="subtle"
        to="/login"
        block
        class="mb-3"
      />
      <UButton
        label="Sign up"
        color="neutral"
        to="/signup"
        block
      />
    </template>
  </UHeader>
</template>

<!-- <style scoped>
/* Make services dropdown children wider */
:deep(.navigation-menu-content) {
  min-width: 1000px;
  width: max-content;
}

:deep(.navigation-menu-content .navigation-menu-item) {
  min-width: 100%;
  width: auto;
}

/* Ensure the dropdown content has proper spacing */
:deep(.navigation-menu-content) {
  padding: 0.75rem;
}
</style> -->
