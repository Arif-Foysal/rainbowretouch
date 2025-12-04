<script setup lang="ts">
const route = useRoute()
const supabase = useSupabaseClient()
const user = useSupabaseUser()
const router = useRouter()
const toast = useToast()

const servicesNavigationChildren = [

  {
    label: 'Photo Retouching',
    description: 'Magazine-grade cleanup for editorials, lookbooks, and high-volume campaigns.',
    icon: 'i-lucide-wand',
    children: [
      {
        label: 'Beauty & Skin Polish',
        description: 'Advanced dodge and burn plus texture recovery for close-ups.',
        icon: 'i-lucide-sparkles',
        to: '/services#beauty-polish'
      },
      {
        label: 'Garment Detailing',
        description: 'Wrinkle removal, edge cleanup, and fabric reshaping.',
        icon: 'i-lucide-scissors',
        to: '/services#garment-detail'
      },
      {
        label: 'Environmental Cleanup',
        description: 'Remove props, distractions, and uneven lighting on set.',
        icon: 'i-lucide-brush',
        to: '/services#environment-cleanup'
      }
    ]
  },
  {
    label: 'AI-Powered Automations',
    description: 'Smart batch workflows with manual QA for every deliverable.',
    icon: 'i-lucide-cpu',
    children: [
      {
        label: 'AI Upscaling',
        description: '4x upscale with grain-matched finishing per asset.',
        icon: 'i-lucide-zoom-in',
        to: '/services#ai-upscale'
      },
      {
        label: 'Background Isolation',
        description: 'Smart cutouts delivered with layered PSD masks.',
        icon: 'i-lucide-crop',
        to: '/services#background-isolation'
      },
      {
        label: 'Batch Tone Matching',
        description: 'Unify lighting across multi-look shoots automatically.',
        icon: 'i-lucide-equalizer',
        to: '/services#tone-matching'
      }
    ]
  },
  {
    label: 'Creative Delivery',
    description: 'Final-mile assets and systems to keep teams shipping fast.',
    icon: 'i-lucide-package-check',
    children: [
      {
        label: 'Color Grading Looks',
        description: 'Custom LUTs and presets per campaign narrative.',
        icon: 'i-lucide-palette',
        to: '/services#grading'
      },
      {
        label: 'Template Systems',
        description: 'Reusable PSD and Canva kits tailored to your marketing stack.',
        icon: 'i-lucide-layers',
        to: '/services#templates'
      },
      {
        label: 'Motion Touchups',
        description: 'Last-mile cleanup on cinemagraphs and animated loops.',
        icon: 'i-lucide-clapperboard',
        to: '/services#motion'
      }
    ]
  }
]

const activeServiceCategory = ref(servicesNavigationChildren[0])
const activeServiceCategoryLabel = computed(() => activeServiceCategory.value?.label || '')
const setActiveServiceCategory = (category: (typeof servicesNavigationChildren)[number]) => {
  activeServiceCategory.value = category
}

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
    slot: 'services',
    type: 'trigger',
    to: '/services',
    active: route.path.startsWith('/services'),
    icon: 'i-lucide-image-plus',
    children: servicesNavigationChildren
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
  },
  {
    label: 'Pricing',
    to: '/pricing',
    icon: 'i-lucide-tag'
  },
  {
    label: 'Blog',
    to: '/blog'
  },
  {
    label: 'Contact',
    to: '/contact',
    icon: 'i-lucide-mail'
  }
])

const isAuthenticated = computed(() => Boolean(user.value))

const handleLogout = async () => {
  await supabase.auth.signOut()
  toast.add({
    title: 'Logged out',
    description: 'You have been signed out successfully.',
    color: 'neutral'
  })
  router.push('/login')
}
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
    >
      <template #services-content="{ item }">
        <div class="w-full max-w-5xl p-6">
          <div class="flex flex-col gap-6 md:flex-row">
            <div class="space-y-2 md:w-1/3">
              <button
                v-for="category in item.children"
                :key="category.label"
                type="button"
                class="group flex w-full items-center justify-between rounded-2xl border px-4 py-3 text-left transition focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary/60"
                :class="activeServiceCategoryLabel === category.label
                  ? 'border-primary/40 bg-primary/5 text-primary'
                  : 'border-transparent hover:border-primary/20 hover:bg-muted/30'"
                @mouseenter="setActiveServiceCategory(category)"
                @focus="setActiveServiceCategory(category)"
              >
                <div>
                  <p class="font-semibold">
                    {{ category.label }}
                  </p>
                  <p class="text-sm text-muted">
                    {{ category.description }}
                  </p>
                </div>
                <UIcon
                  name="i-lucide-chevron-right"
                  class="h-8 w-8 text-muted transition-transform duration-200 group-hover:translate-x-0.5"
                  :class="activeServiceCategoryLabel === category.label ? 'rotate-90 text-primary' : ''"
                />
              </button>
            </div>

            <div class="md:flex-1">
              <Transition
                enter-active-class="transition duration-200 ease-out"
                enter-from-class="opacity-0 translate-y-2"
                enter-to-class="opacity-100 translate-y-0"
                leave-active-class="transition duration-150 ease-in"
                leave-from-class="opacity-100 translate-y-0"
                leave-to-class="opacity-0 -translate-y-2"
                mode="out-in"
              >
                <div :key="activeServiceCategoryLabel" class="space-y-4">
                  <div class="flex items-center gap-3">
                    <div class="flex h-12 w-12 items-center justify-center rounded-2xl bg-primary/10 text-primary">
                      <UIcon :name="activeServiceCategory?.icon || 'i-lucide-image-plus'" class="h-5 w-5" />
                    </div>
                    <div>
                      <p class="text-lg font-semibold">{{ activeServiceCategory?.label }}</p>
                      <p class="text-sm text-muted">{{ activeServiceCategory?.description }}</p>
                    </div>
                  </div>

                  <ul class="grid gap-3 md:grid-cols-2">
                    <li v-for="service in activeServiceCategory?.children || []" :key="service.label">
                      <NuxtLink
                        :to="service.to || '/services'"
                        class="group flex flex-col rounded-xl border border-default p-4 transition hover:border-primary/40 hover:bg-primary/5"
                      >
                        <div class="flex items-center gap-2 text-sm font-semibold">
                          <UIcon v-if="service.icon" :name="service.icon" class="h-8 w-8 text-primary" />
                          <span>{{ service.label }}</span>
                        </div>
                        <p v-if="service.description" class="mt-1 text-xs text-muted">
                          {{ service.description }}
                        </p>
                      </NuxtLink>
                    </li>
                  </ul>
                </div>
              </Transition>
            </div>
          </div>
        </div>
      </template>
    </UNavigationMenu>

    <template #right>
      <UColorModeButton />

      <UButton
        icon="i-lucide-log-in"
        color="neutral"
        variant="ghost"
        to="/login"
        class="lg:hidden"
        v-if="!isAuthenticated"
      />

      <UButton
        icon="i-lucide-log-out"
        color="neutral"
        variant="ghost"
        class="lg:hidden"
        v-else
        @click="handleLogout"
      />

      <UButton
        label="Sign in"
        color="neutral"
        variant="outline"
        to="/login"
        class="hidden lg:inline-flex"
        v-if="!isAuthenticated"
      />

      <UButton
        label="Sign up"
        color="neutral"
        trailing-icon="i-lucide-arrow-right"
        class="hidden lg:inline-flex"
        to="/signup"
        v-if="!isAuthenticated"
      />

      <UButton
        label="Log out"
        color="neutral"
        variant="outline"
        icon="i-lucide-log-out"
        class="hidden lg:inline-flex"
        v-else
        @click="handleLogout"
      />
    </template>

    <template #body>
      <UNavigationMenu
        :items="items"
        orientation="vertical"
        class="-mx-2.5"
      />

      <USeparator class="my-6" />

      <template v-if="!isAuthenticated">
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
      <template v-else>
        <UButton
          label="Log out"
          color="neutral"
          variant="subtle"
          block
          @click="handleLogout"
        />
      </template>
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
