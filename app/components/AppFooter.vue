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

const defaultPaymentIcons = [
  { name: 'Stripe', icon: 'i-simple-icons-stripe', color: '#635BFF' },
  { name: 'PayPal', icon: 'i-simple-icons-paypal', color: '#003087' },
  { name: 'Visa', icon: 'i-simple-icons-visa', color: '#1A1F71' },
  { name: 'Mastercard', icon: 'i-simple-icons-mastercard', color: '#EB001B' },
  { name: 'Apple Pay', icon: 'i-simple-icons-applepay', color: '#000000' },
  { name: 'Google Pay', icon: 'i-simple-icons-googlepay', color: '#4285F4' }
]

const paymentIcons = computed(() => {
  const custom = settings.value?.payments?.items as Array<{ name: string, icon: string, color?: string }> | undefined
  return (custom && custom.length) ? custom : defaultPaymentIcons
})

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

  <!-- PAYMENT STRIP — top of footer, large, colorful, centered -->
  <section class="bg-muted/20 border-b border-default py-6 sm:py-8">
    <UContainer>
      <p class="text-center text-xs sm:text-sm uppercase tracking-wider text-muted mb-4">
        We accept secure payments via
      </p>
      <div class="flex flex-wrap items-center justify-center gap-4 sm:gap-6">
        <div
          v-for="p in paymentIcons"
          :key="p.name"
          class="flex items-center justify-center h-12 sm:h-14 px-4 sm:px-5 rounded-xl bg-white dark:bg-gray-900 shadow-sm ring-1 ring-gray-200 dark:ring-gray-800 hover:shadow-md transition-shadow"
          :title="p.name"
        >
          <UIcon
            :name="p.icon"
            class="w-9 h-9 sm:w-11 sm:h-11"
            :style="{ color: p.color || undefined }"
          />
        </div>
      </div>
    </UContainer>
  </section>

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
