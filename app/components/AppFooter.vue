<script setup lang="ts">
const { data: settings } = await useSiteSettings()

const site = computed(() => settings.value?.site || {})
const social = computed(() => settings.value?.social || {})
const contactInfo = computed(() => settings.value?.contact || {})

const columns = computed(() => [
  {
    label: 'Services',
    children: [
      { label: 'Background Removal', to: '/services#background-removal' },
      { label: 'Photo Retouching', to: '/services#retouching' },
      { label: 'Image Enhancement', to: '/services#enhancement' },
      { label: 'Image Masking', to: '/services#masking' }
    ]
  },
  {
    label: 'Company',
    children: [
      { label: 'About Us', to: '/about' },
      { label: 'Portfolio', to: '/portfolio' },
      { label: 'Pricing', to: '/pricing' },
      { label: 'Contact', to: '/contact' }
    ]
  },
  {
    label: 'Resources',
    children: [
      { label: 'Blog', to: '/blog' },
      { label: 'FAQs', to: '/pricing#faq' },
      ...(contactInfo.value.email ? [{ label: contactInfo.value.email, to: `mailto:${contactInfo.value.email}` }] : []),
      ...(contactInfo.value.phone ? [{ label: contactInfo.value.phone, to: `tel:${contactInfo.value.phone_link || contactInfo.value.phone}` }] : [])
    ]
  }
])

const paymentIcons = [
  { name: 'Stripe', icon: 'i-simple-icons-stripe' },
  { name: 'PayPal', icon: 'i-simple-icons-paypal' },
  { name: 'Visa', icon: 'i-simple-icons-visa' },
  { name: 'Mastercard', icon: 'i-simple-icons-mastercard' },
  { name: 'Apple Pay', icon: 'i-simple-icons-applepay' }
]

const socials = computed(() =>
  [
    { icon: 'i-simple-icons-instagram', url: social.value.instagram, name: 'Instagram' },
    { icon: 'i-simple-icons-facebook', url: social.value.facebook, name: 'Facebook' },
    { icon: 'i-simple-icons-linkedin', url: social.value.linkedin, name: 'LinkedIn' },
    { icon: 'i-simple-icons-behance', url: social.value.behance, name: 'Behance' },
    { icon: 'i-simple-icons-dribbble', url: social.value.dribbble, name: 'Dribbble' },
    { icon: 'i-simple-icons-x', url: social.value.twitter, name: 'Twitter' }
  ].filter(s => !!s.url)
)

const toast = useToast()
const email = ref('')

function onSubmit() {
  if (!email.value) return
  toast.add({ title: 'Subscribed!', description: 'Thanks for subscribing.' })
  email.value = ''
}
</script>

<template>
  <USeparator class="h-px" />

  <UFooter :ui="{ top: 'border-b border-default' }">
    <template #top>
      <UContainer>
        <UFooterColumns :columns="columns">
          <template #right>
            <div class="space-y-4">
              <form @submit.prevent="onSubmit">
                <UFormField name="email" label="Subscribe to our newsletter" size="lg">
                  <UInput v-model="email" type="email" class="w-full" placeholder="Enter your email">
                    <template #trailing>
                      <UButton type="submit" size="xs" color="neutral" label="Subscribe" />
                    </template>
                  </UInput>
                </UFormField>
              </form>
              <div class="flex items-center gap-3 flex-wrap">
                <span class="text-xs text-muted">We accept:</span>
                <div class="flex items-center gap-2">
                  <UIcon
                    v-for="p in paymentIcons"
                    :key="p.name"
                    :name="p.icon"
                    class="w-6 h-6 text-gray-400"
                    :title="p.name"
                  />
                </div>
              </div>
            </div>
          </template>
        </UFooterColumns>
      </UContainer>
    </template>

    <template #left>
      <p class="text-muted text-sm">
        {{ site.name || 'Rainbow Retouch' }} © {{ new Date().getFullYear() }} • All rights reserved
      </p>
    </template>

    <template #right>
      <UButton
        v-for="s in socials"
        :key="s.name"
        :to="s.url"
        target="_blank"
        :icon="s.icon"
        :aria-label="s.name"
        color="neutral"
        variant="ghost"
      />
    </template>
  </UFooter>
</template>
