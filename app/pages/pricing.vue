<script setup lang="ts">
const { data: plans } = await usePricingPlans()
const { data: faqs } = await useFaqs()
const { data: settings } = await useSiteSettings()

const seo = computed(() => settings.value?.seo || {})
const title = computed(() => 'Pricing — ' + (seo.value.default_title || 'Rainbow Retouch'))
const description = computed(() => 'Flexible pricing plans for professional photo editing services.')

useSeoMeta({
  title,
  ogTitle: title,
  description,
  ogDescription: description
})

defineOgImageComponent('Saas')

const pricingType = ref('0')

const items = ref([
  { label: 'Standard', value: '0' },
  { label: 'Bulk', value: '1' }
])

const accordionItems = computed(() =>
  faqs.value.map((f: any) => ({ label: f.question, content: f.answer }))
)

const planProps = (plan: any) => ({
  title: plan.title,
  description: plan.description,
  price: pricingType.value === '1' ? plan.price_bulk : plan.price_standard,
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
    <UPageHero
      title="Professional Editing at Competitive Rates"
      description="Whether you need single image edits or bulk project services, we have flexible pricing options to suit your needs."
    >
      <template #links>
        <UTabs
          v-model="pricingType"
          :items="items"
          color="neutral"
          size="xs"
          class="w-48"
          :ui="{
            list: 'ring ring-accented rounded-full',
            indicator: 'rounded-full',
            trigger: 'w-1/2'
          }"
        />
      </template>
    </UPageHero>

    <UContainer>
      <UEmpty
        v-if="!plans.length"
        icon="i-lucide-tag"
        title="No pricing plans yet"
        description="Pricing plans will appear here once added in admin."
      />
      <UPricingPlans v-else scale>
        <UPricingPlan
          v-for="plan in plans"
          :key="plan.id"
          v-bind="(planProps(plan) as any)"
        />
      </UPricingPlans>
    </UContainer>

    <UPageSection
      v-if="accordionItems.length"
      title="Frequently asked questions"
      description="Everything you need to know about our pricing and services."
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
  </div>
</template>
