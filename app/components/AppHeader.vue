<script setup lang="ts">
import type { NavigationMenuItem } from "@nuxt/ui";

const route = useRoute();
const supabase = useSupabaseClient();
const user = useSupabaseUser();
const router = useRouter();
const toast = useToast();
const { fetchProfile } = useUserProfile();

// Local, reactive admin flag — fetched directly so it can't be stale.
const isAdmin = useState<boolean>("header:isAdmin", () => false);

const refreshAdminFlag = async (uid?: string) => {
  if (!uid) { isAdmin.value = false; return; }
  const { data, error } = await supabase
    .from("profiles")
    .select("role")
    .eq("id", uid)
    .maybeSingle();
  if (error) {
    console.error("[AppHeader] profile fetch failed", error);
    isAdmin.value = false;
    return;
  }
  isAdmin.value = (data as { role?: string } | null)?.role === "admin";
};

watch(
  user,
  async (val) => {
    if (val?.id) {
      await fetchProfile();
      await refreshAdminFlag(val.id);
    } else {
      isAdmin.value = false;
    }
  },
  { immediate: true }
);

// Also re-check on every navigation (covers post-login redirects)
watch(
  () => route.fullPath,
  async () => {
    if (user.value?.id) await refreshAdminFlag(user.value.id);
  }
);

type ServiceItem = {
  id: string;
  label: string;
  description: string | null;
  icon: string | null;
  href: string | null;
  order_index: number;
};

type ServiceNavigationItem = {
  label: string;
  description?: string | null;
  icon?: string | null;
  to?: string;
};

type ServiceNavigationCategory = {
  id?: string;
  label: string;
  description?: string | null;
  icon?: string | null;
  children: ServiceNavigationItem[];
};

type ServiceCategoryRow = {
  id: string;
  label: string;
  description: string | null;
  icon: string | null;
  order_index: number;
  service_items: ServiceItem[] | null;
};

const fallbackServicesNavigation: ServiceNavigationCategory[] = [
  {
    label: "Background Removal-",
    description:
      "Professional clipping paths, multi-path services, and shadow effects.",
    icon: "i-lucide-wand",
    children: [
      {
        label: "Clipping Path",
        description:
          "Simple, medium, complex, and super complex clipping path services.",
        icon: "i-lucide-scissors",
        to: "/services#clipping-path",
      },
      {
        label: "Multi Path",
        description: "Multiple clipping paths in a single image.",
        icon: "i-lucide-layers",
        to: "/services#multi-path",
      },
      {
        label: "Image Cut Out",
        description: "Precise image cut out services for various needs.",
        icon: "i-lucide-wand",
        to: "/services#image-cut-out",
      },
      {
        label: "Ghost Mannequin",
        description: "3D mannequin effect and ghost mannequin services.",
        icon: "i-lucide-user",
        to: "/services#ghost-mannequin",
      },
      {
        label: "Shadow Services",
        description: "Natural shadows, reflections, and drop shadow effects.",
        icon: "i-lucide-layers",
        to: "/services#shadow-services",
      },
    ],
  },
  {
    label: "Photo Retouching",
    description:
      "Retouching, color correction, and exposure enhancement services.",
    icon: "i-lucide-sparkles",
    children: [
      {
        label: "Portrait Retouching",
        description: "Professional retouching for portraits and headshots.",
        icon: "i-lucide-sparkles",
        to: "/services#portrait-retouching",
      },
      {
        label: "Headshot Retouching",
        description: "Enhance headshots with expert retouching.",
        icon: "material-symbols:person-pin",
        to: "/services#headshot-retouching",
      },
      {
        label: "Fashion Photo Retouch",
        description: "Professional retouching for fashion photography.",
        icon: "i-lucide-sparkles",
        to: "/services#fashion-photo-retouch",
      },
      {
        label: "Newborn Photo Retouch",
        description: "Specialized retouching for newborn photography.",
        icon: "i-lucide-baby",
        to: "/services#newborn-photo-retouch",
      },
      {
        label: "Ecommerce Product Photo Retouch",
        description: "Enhance product images for e-commerce and catalogs.",
        icon: "i-lucide-palette",
        to: "/services#ecommerce-product-photo-retouch",
      },
      {
        label: "Jewelry Retouching",
        description: "Specialized jewelry photo enhancement.",
        icon: "i-lucide-diamond",
        to: "/services#jewelry-retouch",
      },
      {
        label: "Weeding Photo Retouch",
        description: "Professional retouching for wedding photographs.",
        icon: "i-lucide-sun",
        to: "/services#weeding-photo-retouch",
      },
      {
        label: "High End Retouch",
        description: "Advanced retouching techniques for high-end photography.",
        icon: "i-lucide-star",
        to: "/services#high-end-retouch",
      },
    ],
  },
  {
    label: "Image Enhancement",
    description:
      "Retouching, color correction, and exposure enhancement services.",
    icon: "i-lucide-sparkles",
    children: [
      {
        label: "Lightroom Image Editing",
        description: "Professional retouching for all photo types.",
        icon: "i-lucide-sparkles",
        to: "/services#lightroom-image-editing",
      },
      {
        label: "Color Correction",
        description: "Professional color grading and correction.",
        icon: "i-lucide-palette",
        to: "/services#color-correction",
      },
      {
        label: "Exposure Correction",
        description: "Fix over/under-exposed images.",
        icon: "i-lucide-sun",
        to: "/services#exposure-correction",
      },
      {
        label: "Real Estate Photo Enhancement",
        description: "Enhance real estate photos for better appeal.",
        icon: "i-lucide-home",
        to: "/services#real-estate-photo-enhancement",
      },
    ],
  },
  {
    label: "Image Masking",
    description: "Masking, photo restoration, and image manipulation services.",
    icon: "i-lucide-layers",
    children: [
      {
        label: "Layer Masking",
        description: "Professional masking services for all needs.",
        icon: "i-lucide-layers",
        to: "/services#layer-masking",
      },
      {
        label: "Multi Masking",
        description: "Advanced multi-layer masking techniques.",
        icon: "i-lucide-refresh-ccw",
        to: "/services#multi-masking",
      },
      {
        label: "Alpha Channel Masking",
        description: "Precise alpha channel masking for complex images.",
        icon: "i-lucide-pen-tool",
        to: "/services#alpha-channel-masking",
      },
      {
        label: "Hair Masking",
        description: "Expert hair masking for detailed cutouts.",
        icon: "i-lucide-wand-2",
        to: "/services#hair-masking",
      },
      {
        label: "Product Masking",
        description: "Specialized masking for product images.",
        icon: "i-lucide-box",
        to: "/services#product-masking",
      },
    ],
  },
  {
    label: "Advanced Design",
    description:
      "Advanced design services including masking, photo restoration, and image manipulation.",
    icon: "i-lucide-layers",
    children: [
      {
        label: "Image Manupulation ",
        description: "Creative image manipulation and compositing services.",
        icon: "i-lucide-layers",
        to: "/services#image-manipulation",
      },
      {
        label: "AI Image Generation & Editing",
        description: "Leverage AI to create and edit stunning images.",
        icon: "simple-icons:codemagic",
        to: "/services#ai-image-generation-editing",
      },
      {
        label: "Object Removal ",
        description: "Seamless removal of unwanted objects from images.",
        icon: "streamline-ultimate:scissors-2-bold",
        to: "/services#object-removal",
      },
      {
        label: "Virtual Staging ",
        description:
          "Enhance property images with virtual furniture and decor.",
        icon: "i-lucide-wand-2",
        to: "/services#virtual-staging",
      },
      {
        label: "Photo Restoration ",
        description: "Restore old and damaged photos to their former glory.",
        icon: "i-lucide-image",
        to: "/services#photo-restoration",
      },
    ],
  },
  {
    label: "Web Application Development",
    description:
      "Building responsive and dynamic web applications with modern web technologies.",
    icon: "material-symbols:web-traffic",
    children: [
      {
        label: "Front End Development",
        description:
          "Creating visually appealing and user-friendly interfaces.",
        icon: "i-lucide-pen-tool",
        to: "/services#front-end-development",
      },
      {
        label: "API Development",
        description:
          "Building robust and scalable APIs for seamless integration.",
        icon: "i-lucide-film",
        to: "/services#api-development",
      },
      {
        label: "Full Stack Development",
        description: "Comprehensive web solutions from front end to back end.",
        icon: "i-lucide-code",
        to: "/services#full-stack-development",
      },
    ],
  },
];

const { data: servicesData } = await useAsyncData(
  "services-navigation",
  async () => {
    const { data, error } = await supabase
      .from("service_categories")
      .select(
        "id, label, description, icon, order_index, service_items(id, label, description, icon, href, order_index)"
      )
      .order("order_index", { ascending: true })
      .order("order_index", { foreignTable: "service_items", ascending: true });

    if (error) {
      console.error("Error fetching services navigation:", error);
      return fallbackServicesNavigation;
    }

    const typedData = data as ServiceCategoryRow[] | null;

    if (!typedData?.length) {
      return fallbackServicesNavigation;
    }

    return typedData.map((category) => ({
      id: category.id,
      label: category.label,
      description: category.description,
      icon: category.icon,
      children: (category.service_items || []).map((item) => ({
        label: item.label,
        description: item.description,
        icon: item.icon,
        to: item.href || "/services",
      })),
    }));
  }
);

const servicesNavigationChildren = computed<ServiceNavigationCategory[]>(() => {
  return servicesData.value?.length
    ? servicesData.value
    : fallbackServicesNavigation;
});

const activeServiceCategory = ref<ServiceNavigationCategory | null>(null);
const activeServiceCategoryLabel = computed(
  () => activeServiceCategory.value?.label || ""
);

watch(
  () => servicesNavigationChildren.value,
  (categories) => {
    if (!categories.length) {
      activeServiceCategory.value = null;
      return;
    }

    const currentLabel = activeServiceCategory.value?.label;
    const matchingCategory = currentLabel
      ? categories.find((category) => category.label === currentLabel)
      : null;

    activeServiceCategory.value = matchingCategory || categories[0] || null;
  },
  { immediate: true }
);

const setActiveServiceCategory = (category: ServiceNavigationCategory) => {
  activeServiceCategory.value = category;
};

const items = computed<NavigationMenuItem[]>(() => {
  const servicesChildren = servicesNavigationChildren.value;

  return [
    {
      label: "Home",
      icon: "i-lucide-home",
      to: "/",
      active: route.path === "/",
    },
    {
      label: "About",
      to: "/about",
      active: route.path === "/about",
      icon: "i-lucide-store",
    },
    {
      label: "Services",
      slot: "services",
      type: "trigger",
      to: "/services",
      active: route.path.startsWith("/services"),
      icon: "i-lucide-image-plus",
      children: servicesChildren,
    },
    {
      label: "Portfolio",
      to: "/portfolio",
      active: route.path === "/portfolio",
      icon: "i-lucide-briefcase",
    },
    {
      label: "Blog",
      icon: "i-lucide-book-open",
      to: "/blog",
      active: route.path.startsWith("/blog"),
    },
    {
      label: "Pricing",
      to: "/pricing",
      icon: "i-lucide-tag",
    },
    {
      label: "Contact",
      to: "/contact",
      icon: "i-lucide-mail",
    },
  ] as NavigationMenuItem[];
});

const isAuthenticated = computed(() => Boolean(user.value));

const handleLogout = async () => {
  await supabase.auth.signOut();
  toast.add({
    title: "Logged out",
    description: "You have been signed out successfully.",
    color: "neutral",
  });
  router.push("/login");
};
</script>

<template>
  <TopBar />
  <UHeader>
    <template #left>
      <NuxtLink to="/">
        <AppLogo class="w-auto h-14 shrink-0" />
        <!-- <Logo/> -->
      </NuxtLink>
      <!-- <TemplateMenu /> -->
    </template>

    <UNavigationMenu :items="items" variant="pill">
      <template #services-content="{ item }">
        <div class="w-full max-w-5xl p-6">
          <div class="flex flex-col gap-6 md:flex-row">
            <div class="space-y-2 md:w-1/3">
              <button
                v-for="category in (item as any)?.children || []"
                :key="category.label"
                type="button"
                class="group flex w-full items-center justify-between rounded-2xl border px-4 py-3 text-left transition focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary/60"
                :class="
                  activeServiceCategoryLabel === category.label
                    ? 'border-primary/40 bg-primary/5 text-primary'
                    : 'border-transparent hover:border-primary/20 hover:bg-muted/30'
                "
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
                  :class="
                    activeServiceCategoryLabel === category.label
                      ? 'rotate-90 text-primary'
                      : ''
                  "
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
                    <div
                      class="flex h-12 w-12 items-center justify-center rounded-2xl bg-primary/10 text-primary"
                    >
                      <UIcon
                        :name="
                          activeServiceCategory?.icon || 'i-lucide-image-plus'
                        "
                        class="h-5 w-5"
                      />
                    </div>
                    <div>
                      <p class="text-lg font-semibold">
                        {{ activeServiceCategory?.label }}
                      </p>
                      <p class="text-sm text-muted">
                        {{ activeServiceCategory?.description }}
                      </p>
                    </div>
                  </div>

                  <ul class="grid gap-3 md:grid-cols-2">
                    <li
                      v-for="service in activeServiceCategory?.children || []"
                      :key="service.label"
                    >
                      <NuxtLink
                        :to="service.to || '/services'"
                        class="group flex flex-col rounded-xl border border-default p-4 transition hover:border-primary/40 hover:bg-primary/5"
                      >
                        <div
                          class="flex items-center gap-2 text-sm font-semibold"
                        >
                          <UIcon
                            v-if="service.icon"
                            :name="service.icon"
                            class="h-8 w-8 text-primary"
                          />
                          <span>{{ service.label }}</span>
                        </div>
                        <p
                          v-if="service.description"
                          class="mt-1 text-xs text-muted"
                        >
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

      <ClientOnly>
        <div class="flex items-center gap-2">
          <UButton
            icon="i-lucide-log-in"
            color="neutral"
            variant="ghost"
            to="/login"
            class="lg:hidden"
            v-if="!isAuthenticated"
          />

          <!-- Mobile: admin shield icon -->
          <UButton
            v-if="isAuthenticated && isAdmin"
            icon="i-lucide-shield-check"
            color="primary"
            variant="solid"
            to="/admin"
            class="lg:hidden"
            aria-label="Admin dashboard"
          />

          <!-- Mobile: log out icon -->
          <UButton
            v-if="isAuthenticated"
            icon="i-lucide-log-out"
            color="neutral"
            variant="ghost"
            class="lg:hidden"
            aria-label="Log out"
            @click="handleLogout"
          />

          <UButton
            v-if="!isAuthenticated"
            label="Sign in"
            color="neutral"
            variant="outline"
            to="/login"
            class="hidden lg:inline-flex"
          />

          <UButton
            v-if="!isAuthenticated"
            label="Sign up"
            color="neutral"
            trailing-icon="i-lucide-arrow-right"
            class="hidden lg:inline-flex"
            to="/signup"
          />

          <!-- Desktop: admin button BEFORE log out, solid primary -->
          <UButton
            v-if="isAuthenticated && isAdmin"
            label="Admin"
            color="primary"
            variant="solid"
            icon="i-lucide-shield-check"
            to="/admin"
            class="hidden lg:inline-flex"
          />

          <UButton
            v-if="isAuthenticated"
            label="Log out"
            color="neutral"
            variant="outline"
            icon="i-lucide-log-out"
            class="hidden lg:inline-flex"
            @click="handleLogout"
          />
        </div>
      </ClientOnly>
    </template>

    <template #body>
      <UNavigationMenu :items="items" orientation="vertical" class="-mx-2.5" />

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
        <UButton label="Sign up" color="neutral" to="/signup" block />
      </template>
      <template v-else>
        <UButton
          v-if="isAdmin"
          label="Admin Dashboard"
          color="primary"
          icon="i-lucide-shield-check"
          to="/admin"
          block
          class="mb-3"
        />
        <UButton label="Dashboard" color="neutral" variant="subtle" to="/dashboard" block class="mb-3" />
        <UButton
          label="Log out"
          color="neutral"
          variant="ghost"
          icon="i-lucide-log-out"
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
