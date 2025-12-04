<script setup lang="ts">
const route = useRoute()
const supabase = useSupabaseClient()
const user = useSupabaseUser()
const router = useRouter()
const toast = useToast()

const servicesNavigationChildren = [

  {
    label: 'Image Retouching',
    description: 'Magazine-grade cleanup for editorials, lookbooks, and high-volume campaigns.',
    icon: 'i-lucide-wand',
    children: [
            {
        label: 'Color Grading',
        description: 'Professional color grading to balance exposure, refine skin tones, and create a polished, high-end look.',
        icon: 'i-lucide-palette',
        to: '/services#grading'
      },
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
    label: 'Ecommerce Photo Editing',
    description: 'Optimized images for product listings, ads, and catalogs.',
    icon: 'i-lucide-package-check',
    children: [
    {
      label: 'Background Removal',
      description: 'Precise cutouts with edge refinement and alpha-channel exports for all product types.',
      icon: 'i-lucide-crop',
      to: '/services#background-removal'
    },
    {
      label: 'Ghost Mannequin & Apparel',
      description: 'Create invisible-mannequin shots and stitch interiors for clean product presentation.',
      icon: 'i-lucide-user',
      to: '/services#ghost-mannequin'
    },
    {
      label: 'Color Correction & White Balance',
      description: 'Batch color correction, white-balance, and consistent look across SKUs.',
      icon: 'i-lucide-sliders',
      to: '/services#color-correction'
    },
    {
      label: 'Retouching & Spot Removal',
      description: 'Remove dust, lint, and blemishes while preserving natural texture.',
      icon: 'i-lucide-sparkles',
      to: '/services#retouching'
    },
    {
      label: 'Shadows & Reflections',
      description: 'Natural drop shadows and soft reflections to enhance product depth.',
      icon: 'i-lucide-layers',
      to: '/services#shadows-reflections'
    },
    {
      label: 'Resize, Export & SEO',
      description: 'Resize, crop, and export multi-resolution assets optimized for performance and SEO.',
      icon: 'i-lucide-search',
      to: '/services#resize-export'
    }
    ]
  },
    {
    label: 'Image Restoration & Enhancement',
    description: 'Revive old or damaged photos with expert restoration and enhancement techniques.',
    icon: 'i-lucide-refresh-ccw',
    children: [
      {
        label: 'Damage Repair & Stitching',
        description: 'Reconstruct tears, scratches, and missing sections using content-aware healing and manual retouching.',
        icon: 'i-lucide-wrench',
        to: '/services#damage-repair'
      },
      {
        label: 'Color & Tone Restoration',
        description: 'Recover faded colors, correct discoloration, and rebalance tones for archival prints and scans.',
        icon: 'i-lucide-sliders',
        to: '/services#color-restoration'
      },
      {
        label: 'Dust, Scratch & Spot Removal',
        description: 'Automated and manual cleanup to remove dust, scratches, and surface blemishes while preserving detail.',
        icon: 'i-lucide-sparkles',
        to: '/services#dust-scratch-removal'
      },
      {
        label: 'Tonal Recovery & Contrast',
        description: 'Restore dynamic range and local contrast for depth and clarity in over/under-exposed captures.',
        icon: 'i-lucide-contrast',
        to: '/services#tonal-recovery'
      },
      {
        label: 'Noise Reduction & Sharpening',
        description: 'Advanced denoising paired with detail-preserving sharpening for scanned or low-light images.',
        icon: 'i-lucide-aperture',
        to: '/services#noise-reduction'
      },
      {
        label: 'Photo Reconstruction & Composite Repair',
        description: 'Rebuild heavily damaged images, composite multi-source elements, and recreate missing context.',
        icon: 'i-lucide-image',
        to: '/services#photo-reconstruction'
      }
    ]
  },
  {
  label: 'Creative Composition & Ads',
  description: 'High-end photo manipulation and compositing for advertising, key art, and marketing visuals.',
  icon: 'i-lucide-lightbulb',
  children: [
    {
      label: 'Photo Manipulation',
      description: 'Seamlessly combine multiple images to create surreal, conceptual, or marketing visuals.',
      icon: 'i-lucide-layers',
      to: '/services#manipulation'
    },
    {
      label: 'Automotive Retouching',
      description: 'Specialized reflection management, cleaning, and background replacement for vehicle photography.',
      icon: 'i-lucide-car',
      to: '/services#automotive'
    },
    {
      label: 'Jewelry Retouching',
      description: 'Focus stacking, metal polishing, and gemstone sharpening for macro jewelry photography.',
      icon: 'i-lucide-diamond',
      to: '/services#jewelry'
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
    label: 'Blog',
    icon: 'i-lucide-book-open',
    to: '/blog',
    active: route.path.startsWith('/blog')
  },
  {
    label: 'Pricing',
    to: '/pricing',
    icon: 'i-lucide-tag'
  },
  // {
  //   label: 'Blog',
  //   to: '/blog',
  //   icon: 'i-lucide-book-open'

  // },
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
