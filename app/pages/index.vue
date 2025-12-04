<script setup lang="ts">
const { data: page } = await useAsyncData('index', () => queryCollection('index').first())

const title = page.value?.seo?.title || page.value?.title
const description = page.value?.seo?.description || page.value?.description

useSeoMeta({
  titleTemplate: '',
  title,
  ogTitle: title,
  description,
  ogDescription: description
})
// definePageMeta({
//   auth: false // This page requires no authentication
// })

const card_items = ref([
  {
    title: 'Fast Turnaround',
    description: 'Get high-quality, professional results within 24 hours.',
    icon: 'i-lucide-clock'          // optional icon names (use your icon system)
  },
  {
    title: 'No Subscription',
    description: 'Pay per image — no subscriptions required.',
    icon: 'i-lucide-credit-card'
  },
  {
    title: 'Unlimited Changes',
    description: "We revise until you're satisfied.",
    icon: 'i-lucide-repeat'
  },
  {
    title: 'Work Directly 1:1',
    description: 'One-on-one collaboration with a top editor.',
    icon: 'i-lucide-user'
  },
  {
    title: 'Double Check',
    description: 'We always double-check work before delivery.',
    icon: 'i-lucide-check-circle'
  },
  {
    title: 'You Keep Copyright',
    description: 'Edited images are returned to you — you retain full copyright.',
    icon: 'i-lucide-shield-check'
  }
])



</script>

<template>
  <div v-if="page">
    <Hero />
    <UPageSection headline="High Quality" :title="'Image Manipulation Services'"
      :description="'Transform your images with sharp, natural-looking edits.'">
      <Carousel />

    </UPageSection>

    <CardGroup headline="How We Work" title="Why clients love our image editing"
      description="Fast and customer-focused image editing services." orientation="vertical" :items="card_items" />

           <UPageSection
    title="Our Services"
    description="Explore the range of professional photo editing services we offer."
    headline="Services"
/>
    <UPageSection v-for="(section, index) in page.sections" :key="index" :title="section.title"
      :description="section.description" :orientation="section.orientation" :reverse="section.reverse"
      :features="section.features">
      <ImagePlaceholder />
    </UPageSection>
    <!-- </UPageSection>  -->
 

    <UPageSection v-motion-slide-visible-bottom :title="page.features.title" :description="page.features.description">
      <UPageGrid>
        <UPageCard v-for="(item, index) in page.features.items" :key="index" v-bind="item" spotlight />
      </UPageGrid>
    </UPageSection>

    <Features />


    <UPageSection :title="'Rainbow Retouch Timeline'" :description="page.features.description">

      <Changelog />
    </UPageSection>
    <UPageSection id="testimonials" :headline="page.testimonials.headline" :title="page.testimonials.title"
      :description="page.testimonials.description">
      <UPageColumns class="xl:columns-4">
        <UPageCard v-for="(testimonial, index) in page.testimonials.items" :key="index" variant="subtle"
          :description="testimonial.quote"
          :ui="{ description: 'before:content-[open-quote] after:content-[close-quote]' }">
          <template #footer>
            <UUser v-bind="testimonial.user" size="lg" />
          </template>
        </UPageCard>
      </UPageColumns>
    </UPageSection>

    <USeparator />

    <UPageCTA v-bind="page.cta" variant="naked" class="overflow-hidden">
      <LazyStarsBg />
    </UPageCTA>
  </div>
</template>
