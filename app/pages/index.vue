<script setup lang="ts">
const supabase = useSupabaseClient()

const [
  { data: settings },
  { data: testimonials },
  { data: pricingPlans },
  { data: faqs },
  { data: portfolio },
  { data: serviceCategories }
] = await Promise.all([
  useSiteSettings(),
  useTestimonials(),
  usePricingPlans(),
  useFaqs(),
  usePortfolioItems(),
  useAsyncData('home:service_categories', async () => {
    const { data } = await supabase
      .from('service_categories')
      .select('id, label, description, icon, order_index, service_items(id, label, icon, href, order_index, service_item_images(image_url, order_index))')
      .order('order_index', { ascending: true })
      .order('order_index', { foreignTable: 'service_items', ascending: true })
    return (data as any[]) ?? []
  }, { default: () => [] as any[] })
])

const seo = computed(() => settings.value?.seo || {})
const homeHero = computed(() => settings.value?.home_hero || {})
const homeFeatures = computed(() => settings.value?.home_features || { items: [] })
const cta = computed(() => settings.value?.cta || {})
const about = computed(() => settings.value?.about || {})

const title = computed(() => seo.value.default_title || 'Rainbow Retouch')
const description = computed(() => seo.value.default_description || '')

useSeoMeta({
  titleTemplate: '',
  title,
  ogTitle: title,
  description,
  ogDescription: description
})

const ctaLinks = computed(() => {
  const links: any[] = []
  if (cta.value.primary_label) {
    links.push({ label: cta.value.primary_label, to: cta.value.primary_link || '/contact', trailingIcon: 'i-lucide-arrow-right' })
  }
  if (cta.value.secondary_label) {
    links.push({ label: cta.value.secondary_label, to: cta.value.secondary_link || '/portfolio', variant: 'subtle', icon: 'i-lucide-image' })
  }
  return links
})

const serviceCards = computed(() =>
  serviceCategories.value.map((cat: any) => {
    const firstItem = cat.service_items?.[0]
    const firstImg = firstItem?.service_item_images?.[0]?.image_url
    const itemCount = cat.service_items?.length || 0
    return {
      id: cat.id,
      title: cat.label,
      description: cat.description,
      icon: cat.icon || 'i-lucide-sparkles',
      image: firstImg,
      itemCount,
      to: `/services#${cat.id}`
    }
  })
)

const stats = computed(() => about.value?.stats || [])
const clientsBlock = computed(() => settings.value?.clients || { items: [] })
const clientItems = computed<any[]>(() => clientsBlock.value?.items || [])

const processBlock = computed(() => settings.value?.process_steps || {})
const processSteps = computed<any[]>(() => processBlock.value?.items || [])

const featuredPortfolio = computed(() => (portfolio.value || []).slice(0, 6))
const topTestimonials = computed(() => (testimonials.value || []).slice(0, 3))
const topFaqs = computed(() => (faqs.value || []).slice(0, 5))
const topPlans = computed(() => (pricingPlans.value || []).slice(0, 3))

const accordionItems = computed(() => topFaqs.value.map((f: any) => ({ label: f.question, content: f.answer })))

const planProps = (plan: any) => ({
  title: plan.title,
  description: plan.description,
  price: plan.price_standard,
  features: plan.features || [],
  highlight: plan.is_highlighted,
  button: {
    label: plan.button_label || 'Get Started',
    to: plan.button_link || '/contact',
    color: plan.is_highlighted ? 'primary' : 'neutral',
    variant: plan.is_highlighted ? 'solid' : 'subtle'
  }
})
</script>

<template>
  <div>
    <Hero />

    <!-- TRUST STRIP -->
    <section v-if="stats.length" class="border-y border-default bg-muted/30 py-6 sm:py-8">
      <UContainer>
        <div class="grid grid-cols-2 gap-4 sm:grid-cols-4 sm:gap-6 text-center">
          <div v-for="(stat, i) in stats" :key="i" class="flex flex-col items-center">
            <div
              v-if="stat.icon"
              class="mb-2 flex h-12 w-12 items-center justify-center rounded-full bg-primary/10 text-primary"
            >
              <UIcon :name="stat.icon" class="h-6 w-6" />
            </div>
            <div class="text-2xl sm:text-4xl font-bold text-primary">
              {{ stat.value }}
            </div>
            <p class="mt-1 text-xs sm:text-sm text-muted uppercase tracking-wider">
              {{ stat.label }}
            </p>
          </div>
        </div>
      </UContainer>
    </section>

    <!-- RENOWNED CLIENTS -->
    <section v-if="clientItems.length" class="py-10 sm:py-14 bg-background">
      <UContainer>
        <div class="text-center mb-6 sm:mb-8">
          <p v-if="clientsBlock.headline" class="text-xs sm:text-sm uppercase tracking-wider text-primary font-semibold">
            {{ clientsBlock.headline }}
          </p>
          <h2 v-if="clientsBlock.title" class="mt-2 text-2xl sm:text-3xl font-bold">
            {{ clientsBlock.title }}
          </h2>
        </div>
        <div class="flex flex-wrap items-center justify-center gap-x-8 gap-y-6 sm:gap-x-12">
          <component
            :is="c.link ? 'a' : 'div'"
            v-for="(c, i) in clientItems"
            :key="i"
            :href="c.link || undefined"
            :target="c.link ? '_blank' : undefined"
            rel="noopener noreferrer"
            class="grayscale opacity-70 hover:opacity-100 hover:grayscale-0 transition-all duration-300"
          >
            <NuxtImg
              :src="c.logo_url"
              :alt="c.name || 'Client logo'"
              height="48"
              format="webp"
              loading="lazy"
              class="h-10 sm:h-12 w-auto object-contain"
            />
          </component>
        </div>
      </UContainer>
    </section>

    <!-- VALUE PROPS -->
    <UPageSection
      v-if="homeFeatures.items?.length"
      :headline="homeFeatures.headline"
      :title="homeFeatures.title"
      :description="homeFeatures.description"
    >
      <div class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        <div
          v-for="(item, i) in homeFeatures.items"
          :key="i"
          class="group rounded-2xl border border-default p-5 transition hover:border-primary/40 hover:shadow-md"
        >
          <div class="flex items-center justify-center w-11 h-11 rounded-xl bg-primary/10 text-primary group-hover:bg-primary group-hover:text-white transition">
            <UIcon :name="item.icon || 'i-lucide-check'" class="w-5 h-5" />
          </div>
          <h3 class="mt-4 text-base font-semibold text-highlighted">
            {{ item.title }}
          </h3>
          <p class="mt-1 text-sm text-muted leading-relaxed">
            {{ item.description }}
          </p>
        </div>
      </div>
    </UPageSection>

    <!-- SERVICES GRID -->
    <UPageSection
      title="Our Services"
      description="From clipping paths to high-end retouching — built for e-commerce, agencies, and photographers."
      headline="Services"
    >
      <UEmpty
        v-if="!serviceCards.length"
        icon="i-lucide-layers"
        title="No services yet"
        description="Add categories and services in admin to display them here."
      />
      <div v-else class="grid gap-5 sm:grid-cols-2 lg:grid-cols-3">
        <NuxtLink
          v-for="card in serviceCards"
          :key="card.id"
          :to="card.to"
          class="group flex flex-col overflow-hidden rounded-2xl border border-default bg-background transition hover:border-primary/50 hover:shadow-xl focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary"
        >
          <div class="relative aspect-[16/10] w-full overflow-hidden bg-muted/40">
            <NuxtImg
              v-if="card.image"
              :src="card.image"
              :alt="card.title"
              class="h-full w-full object-cover transition-transform duration-500 group-hover:scale-105"
              format="webp"
              loading="lazy"
              sizes="sm:100vw md:50vw lg:33vw"
            />
            <div v-else class="flex h-full w-full items-center justify-center text-muted">
              <UIcon :name="card.icon" class="h-12 w-12" />
            </div>
            <div class="absolute left-3 top-3 flex h-9 w-9 items-center justify-center rounded-lg bg-background/90 text-primary backdrop-blur-sm shadow">
              <UIcon :name="card.icon" class="h-5 w-5" />
            </div>
            <span
              v-if="card.itemCount"
              class="absolute right-3 top-3 rounded-full bg-background/90 px-2.5 py-1 text-xs font-medium text-default shadow backdrop-blur-sm"
            >{{ card.itemCount }} service{{ card.itemCount === 1 ? '' : 's' }}</span>
          </div>
          <div class="flex flex-1 flex-col gap-2 p-5">
            <h3 class="text-lg font-semibold text-highlighted transition-colors group-hover:text-primary">
              {{ card.title }}
            </h3>
            <p v-if="card.description" class="text-sm text-muted line-clamp-2">
              {{ card.description }}
            </p>
            <div class="mt-auto flex items-center gap-1.5 pt-3 text-sm font-medium text-primary">
              <span>Explore</span>
              <UIcon name="i-lucide-arrow-right" class="h-4 w-4 transition-transform group-hover:translate-x-0.5" />
            </div>
          </div>
        </NuxtLink>
      </div>

      <div class="mt-10 flex justify-center">
        <UButton to="/services" size="xl" color="primary" trailing-icon="i-lucide-arrow-right">
          View All Services
        </UButton>
      </div>
    </UPageSection>

    <!-- PROCESS -->
    <UPageSection
      v-if="processSteps.length"
      :headline="processBlock.headline"
      :title="processBlock.title"
      :description="processBlock.description"
    >
      <div class="grid gap-5 sm:grid-cols-2 lg:grid-cols-4">
        <div
          v-for="(step, i) in processSteps"
          :key="i"
          class="relative rounded-2xl border border-default bg-background p-6"
        >
          <div class="absolute -top-3 left-6 flex h-7 w-7 items-center justify-center rounded-full bg-primary text-sm font-bold text-white shadow">
            {{ i + 1 }}
          </div>
          <UIcon :name="step.icon" class="h-8 w-8 text-primary" />
          <h3 class="mt-4 text-base font-semibold text-highlighted">
            {{ step.title }}
          </h3>
          <p class="mt-1 text-sm text-muted leading-relaxed">
            {{ step.description }}
          </p>
        </div>
      </div>
    </UPageSection>

    <!-- PORTFOLIO TEASER -->
    <UPageSection
      v-if="featuredPortfolio.length"
      headline="Recent work"
      title="See the craft up close"
      description="A small slice of recent commercial, fashion, and product retouching."
    >
      <div class="grid grid-cols-2 gap-3 sm:gap-4 sm:grid-cols-3">
        <NuxtLink
          v-for="item in featuredPortfolio"
          :key="item.id"
          to="/portfolio"
          class="group relative overflow-hidden rounded-xl aspect-square block bg-muted/40"
        >
          <NuxtImg
            :src="item.image_url"
            :alt="item.title || 'Portfolio'"
            class="h-full w-full object-cover transition-transform duration-700 group-hover:scale-110"
            format="webp"
            loading="lazy"
          />
          <div class="absolute inset-0 flex items-end bg-gradient-to-t from-black/70 via-black/0 to-transparent opacity-0 transition group-hover:opacity-100">
            <p v-if="item.title" class="p-3 text-sm font-medium text-white">
              {{ item.title }}
            </p>
          </div>
        </NuxtLink>
      </div>

      <div class="mt-8 flex justify-center">
        <UButton to="/portfolio" size="lg" color="neutral" variant="outline" trailing-icon="i-lucide-arrow-right">
          View Full Portfolio
        </UButton>
      </div>
    </UPageSection>

    <!-- TESTIMONIALS -->
    <UPageSection
      v-if="topTestimonials.length"
      id="testimonials"
      headline="Loved by photographers & brands"
      title="What clients say"
      description="Real feedback from teams who trust us with their visual brand."
    >
      <div class="grid gap-5 lg:grid-cols-3">
        <div
          v-for="t in topTestimonials"
          :key="t.id"
          class="flex flex-col rounded-2xl border border-default bg-background p-6 shadow-sm"
        >
          <div class="flex gap-0.5 text-yellow-400">
            <UIcon v-for="n in 5" :key="n" name="i-lucide-star" class="h-4 w-4 fill-yellow-400" />
          </div>
          <blockquote class="mt-4 flex-1 text-sm leading-relaxed text-default before:content-[open-quote] after:content-[close-quote]">
            {{ t.quote }}
          </blockquote>
          <div class="mt-5 flex items-center gap-3 border-t border-default pt-4">
            <UAvatar :src="t.avatar_url || undefined" :alt="t.author_name" size="md" />
            <div class="min-w-0">
              <p class="text-sm font-semibold text-highlighted truncate">
                {{ t.author_name }}
              </p>
              <p class="text-xs text-muted truncate">
                {{ t.author_role }}
              </p>
            </div>
          </div>
        </div>
      </div>
    </UPageSection>

    <!-- PRICING TEASER -->
    <UPageSection
      v-if="topPlans.length"
      headline="Simple, transparent pricing"
      title="Pick the plan that fits"
      description="Pay per image or get bulk discounts on large batches. No subscriptions, no surprises."
    >
      <UPricingPlans scale>
        <UPricingPlan
          v-for="plan in topPlans"
          :key="plan.id"
          v-bind="planProps(plan)"
        />
      </UPricingPlans>

      <div class="mt-8 flex justify-center">
        <UButton to="/pricing" size="lg" color="neutral" variant="outline" trailing-icon="i-lucide-arrow-right">
          See full pricing
        </UButton>
      </div>
    </UPageSection>

    <!-- FAQ -->
    <UPageSection
      v-if="accordionItems.length"
      headline="Frequently asked"
      title="Got questions? We've got answers."
      description="Still wondering something? Send us a message — we reply within an hour."
    >
      <UAccordion
        :items="accordionItems"
        :unmount-on-hide="false"
        :default-value="['0']"
        type="multiple"
        class="max-w-3xl mx-auto"
        :ui="{
          trigger: 'text-base text-highlighted',
          body: 'text-base text-muted'
        }"
      />
    </UPageSection>

    <USeparator />

    <!-- FINAL CTA -->
    <UPageCTA
      v-if="cta.title"
      :title="cta.title"
      :description="cta.description"
      :links="ctaLinks"
      variant="naked"
      class="overflow-hidden"
    >
      <LazyStarsBg />
    </UPageCTA>
  </div>
</template>
