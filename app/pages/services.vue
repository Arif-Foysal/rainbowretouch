<template>
  <UPageHeader
    :title="headerTitle"
    :description="headerDescription"
    headline="Turn raw captures into commercial assets"
  />
  <br /><br />
  <div v-if="pending" class="flex items-center justify-center py-16">
    <UIcon name="i-lucide-loader-2" class="h-8 w-8 animate-spin text-primary" />
  </div>

  <div v-else>
    <UEmpty
      v-if="!hasSections"
      icon="i-lucide-layers"
      title="No services available"
      description="Services will appear here once added in the admin."
    />

    <div
      v-for="group in groupedSections"
      :id="`cat-${group.id}`"
      :key="group.id"
      class="space-y-6 pb-12 scroll-mt-24"
    >
      <div class="space-y-2 flex flex-col items-center text-center mx-auto">
        <h2 class="text-5xl font-bold tracking-tight text-foreground">
          {{ group.title }}
        </h2>
        <p v-if="group.description" class="text-lg text-primary">
          {{ group.description }}
        </p>
      </div>

      <UPageSection
        v-for="section in group.sections"
        :key="section.id"
        :id="section.id"
        :title="section.title"
        :description="section.description || undefined"
        :orientation="section.orientation"
        :reverse="section.reverse"
        :features="section.features"
      >
        <div
          class="relative overflow-hidden rounded-3xl shadow-xl ring-1 ring-default/40"
        >
          <div class="aspect-4/3 w-full">
            <NuxtImg
              :src="section.image || '/imagePoster/1.png'"
              :alt="section.title"
              format="webp"
              loading="lazy"
              sizes="100vw md:600px"
              class="h-full w-full object-cover"
            />
          </div>
        </div>
        <template #footer>
          <UButton
            label="Free Trial"
            to="/contact"
            size="lg"
            trailing-icon="i-lucide-arrow-right"
          />
        </template>
      </UPageSection>
    </div>
  </div>
  <UPageCTA
    v-if="ctaProps"
    v-bind="ctaProps"
    variant="subtle"
    class="overflow-hidden"
  >
    <LazyStarsBg />
  </UPageCTA>
</template>

<script setup lang="ts">
type ServiceImage = {
  image_url: string;
  alt: string | null;
  order_index: number;
  created_at?: string;
};
type ServiceFeature = {
  label: string;
  description: string | null;
  icon?: string | null;
};
type ServiceItem = {
  id: string;
  label: string;
  description: string | null;
  href: string | null;
  order_index: number;
  service_item_images?: ServiceImage[];
  service_item_features?: ServiceFeature[];
};
type ServiceCategory = {
  id: string;
  label: string;
  description: string | null;
  order_index: number;
  service_items?: ServiceItem[];
};

const supabase = useSupabaseClient();

const { data, pending } = await useAsyncData("services-page", async () => {
  const { data, error } = await supabase
    .from("service_categories")
    .select(
      "id, label, description, order_index, service_items(id, label, description, href, order_index, service_item_images(image_url, alt, order_index, created_at), service_item_features(label, description, icon))"
    )
    .order("order_index", { ascending: true })
    .order("order_index", { foreignTable: "service_items", ascending: true });

  if (error) {
    console.error("Error fetching services:", error);
    throw error;
  }

  // Debug logging to check image URLs
  if (data) {
    console.log("Services data fetched:", data.length, "categories");
    data.forEach((cat) => {
      cat.service_items?.forEach((item) => {
        const images = item.service_item_images || [];
        // Sort by created_at desc to see the latest
        images.sort(
          (a: any, b: any) =>
            new Date(b.created_at).getTime() - new Date(a.created_at).getTime()
        );

        const img = images[0]?.image_url;
        if (img) {
          console.log(
            `Service: ${item.label}, Image Count: ${images.length}, Latest: ${img}`
          );
        } else {
          console.warn(
            `Service: ${item.label} has missing image! Count: ${images.length}`
          );
        }
      });
    });
  }

  return data ?? [];
});

const categories = computed<ServiceCategory[]>(
  () => (data.value as ServiceCategory[] | null) ?? []
);

const headerTitle = computed(() => "Our Services");
const headerDescription = computed(
  () =>
    "We streamline your visual workflow with pixel-perfect product editing, restoration, and retouching delivered at scale."
);

const groupedSections = computed(() => {
  return categories.value.map((category) => {
    const sections = (category.service_items || []).map((item, idx) => {
      const anchorFragment = item.href?.split("#")[1]?.trim();

      // Use the latest image
      const images = [...(item.service_item_images || [])];
      // Sort in-place copy
      images.sort((a: any, b: any) => {
        const dateA = a.created_at ? new Date(a.created_at).getTime() : 0;
        const dateB = b.created_at ? new Date(b.created_at).getTime() : 0;
        return dateB - dateA;
      });

      const image = images[0]?.image_url;

      const features = (item.service_item_features || []).map((feature) => ({
        title: feature.label,
        description: feature.description || undefined,
        icon: feature.icon || undefined,
      }));

      return {
        id: anchorFragment || `${category.id}-${item.id}`,
        title: item.label,
        description: item.description,
        orientation: "horizontal" as const,
        reverse: idx % 2 === 1,
        image,
        features,
      };
    });

    return {
      id: category.id,
      title: category.label,
      description: category.description,
      sections,
    };
  });
});

const { data: page } = await useAsyncData("index", () =>
  queryCollection("index").first()
);
const ctaProps = computed(() => page.value?.cta ?? null);
const hasSections = computed(() =>
  groupedSections.value.some((group) => group.sections.length > 0)
);
</script>
