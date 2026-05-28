<script setup lang="ts">
const { data: settings } = await useSiteSettings()
const { data: team } = await useTeamMembers()

const about = computed(() => settings.value?.about || {})
const cta = computed(() => settings.value?.cta || {})

const ctaLinks = computed(() => {
  const links: any[] = []
  if (cta.value.primary_label) links.push({ label: cta.value.primary_label, to: cta.value.primary_link || '/contact', trailingIcon: 'i-lucide-arrow-right' })
  if (cta.value.secondary_label) links.push({ label: cta.value.secondary_label, to: cta.value.secondary_link || '/portfolio', variant: 'subtle' })
  return links
})

useSeoMeta({
  title: 'About — Rainbow Retouch',
  description: 'Meet the team behind Rainbow Retouch — a professional photo editing studio.'
})
</script>

<template>
  <UApp>
    <div v-motion-pop-visible>
      <UPageHero
        :headline="about.headline || 'About Us'"
        :title="about.title || 'Creative Minds. Stunning Designs.'"
        :description="about.description"
        :links="[
          { label: 'Get in Touch', color: 'primary', size: 'xl', to: '/contact' },
          { label: 'View Portfolio', color: 'neutral', variant: 'outline', size: 'xl', to: '/portfolio' }
        ]"
        orientation="horizontal"
      >
        <UCard
          v-if="about.hero_image_url"
          variant="subtle"
          class="rounded-2xl overflow-hidden"
        >
          <img
            :src="about.hero_image_url"
            alt="About hero"
            class="w-full h-auto rounded-xl"
          >
        </UCard>
      </UPageHero>
    </div>

    <UPageSection
      v-if="about.values?.length"
      :headline="about.values_headline"
      :title="about.values_title"
      :description="about.values_description"
      orientation="vertical"
      :features="about.values"
    />

    <UPageSection
      v-if="team.length"
      headline="The Team"
      title="Meet Our Creative Wizards"
      description="A diverse team of talented designers, each bringing unique perspectives."
      orientation="vertical"
    >
      <UPageGrid>
        <UCard
          v-for="member in team"
          :key="member.id"
          variant="outline"
          class="text-center"
        >
          <div class="flex flex-col items-center space-y-4">
            <UAvatar
              :src="member.avatar_url || undefined"
              :alt="member.name"
              size="3xl"
            />
            <div>
              <h3 class="text-xl font-bold text-highlighted">
                {{ member.name }}
              </h3>
              <p class="text-muted">
                {{ member.role }}
              </p>
            </div>
            <p v-if="member.bio" class="text-sm text-muted">
              {{ member.bio }}
            </p>
          </div>
        </UCard>
      </UPageGrid>
    </UPageSection>

    <CardGroup />

    <UPageSection v-if="about.stats?.length" orientation="vertical">
      <div class="grid gap-8 grid-cols-2 md:grid-cols-4 text-center">
        <div v-for="(stat, i) in about.stats" :key="i">
          <div class="text-3xl sm:text-5xl font-bold text-primary mb-2">
            {{ stat.value }}
          </div>
          <p class="text-muted text-sm sm:text-base">
            {{ stat.label }}
          </p>
        </div>
      </div>
    </UPageSection>

    <UPageCTA
      v-if="cta.title"
      :title="cta.title"
      :description="cta.description"
      :links="ctaLinks"
      variant="subtle"
      class="overflow-hidden"
    >
      <LazyStarsBg />
    </UPageCTA>
  </UApp>
</template>
