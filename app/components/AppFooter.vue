<script setup lang="ts">
const columns = [{
  label: 'Services',
  children: [{
    label: 'Brand Identity',
    to: '/services#branding'
  }, {
    label: 'UI/UX Design',
    to: '/services#ui-ux'
  }, {
    label: 'Illustration',
    to: '/services#illustration'
  }, {
    label: 'Motion Graphics',
    to: '/services#motion'
  }]
}, {
  label: 'Company',
  children: [{
    label: 'About Us',
    to: '/about'
  }, {
    label: 'Portfolio',
    to: '/portfolio'
  }, {
    label: 'Pricing',
    to: '/pricing'
  }, {
    label: 'Contact',
    to: '/contact'
  }]
}, {
  label: 'Resources',
  children: [{
    label: 'Blog',
    to: '/blog'
  }, {
    label: 'Case Studies',
    to: '/blog'
  }, {
    label: 'Design Tips',
    to: '/blog'
  }, {
    label: 'FAQs',
    to: '/contact'
  }]
}]

const paymentIcons = [
  { name: 'Stripe', icon: 'i-simple-icons-stripe' },
  { name: 'PayPal', icon: 'i-simple-icons-paypal' },
  { name: 'Visa', icon: 'i-simple-icons-visa' },
  { name: 'Mastercard', icon: 'i-simple-icons-mastercard' },
  { name: 'Apple Pay', icon: 'i-simple-icons-applepay' }
]

const toast = useToast()

const email = ref('')
const loading = ref(false)

function onSubmit() {
  loading.value = true

  toast.add({
    title: 'Subscribed!',
    description: 'You\'ve been subscribed to our newsletter.'
  })
}
</script>

<template>
  <USeparator
    icon="i-simple-icons-nuxtdotjs"
    class="h-px"
  />

  <UFooter :ui="{ top: 'border-b border-default' }">
    <template #top>
      <UContainer>
        <UFooterColumns :columns="columns">
          <template #right>
            <div class="space-y-4">
              <form @submit.prevent="onSubmit">
                <UFormField
                  name="email"
                  label="Subscribe to our newsletter"
                  size="lg"
                >
                  <UInput
                    v-model="email"
                    type="email"
                    class="w-full"
                    placeholder="Enter your email"
                  >
                    <template #trailing>
                      <UButton
                        type="submit"
                        size="xs"
                        color="neutral"
                        label="Subscribe"
                      />
                    </template>
                  </UInput>
                </UFormField>
              </form>
              
              <div class="flex items-center gap-3 flex-wrap">
                <span class="text-xs text-muted">We accept:</span>
                <div class="flex items-center gap-2">
                  <UIcon
                    v-for="payment in paymentIcons"
                    :key="payment.name"
                    :name="payment.icon"
                    class="w-6 h-6 text-gray-400 hover:text-gray-600 dark:hover:text-gray-200 transition-colors"
                    :title="payment.name"
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
        Rainbow Retouch © {{ new Date().getFullYear() }} • All rights reserved
      </p>
    </template>

    <template #right>
      <UButton
        to="https://instagram.com"
        target="_blank"
        icon="i-simple-icons-instagram"
        aria-label="Rainbow Retouch on Instagram"
        color="neutral"
        variant="ghost"
      />
      <UButton
        to="https://dribbble.com"
        target="_blank"
        icon="i-simple-icons-dribbble"
        aria-label="Rainbow Retouch on Dribbble"
        color="neutral"
        variant="ghost"
      />
      <UButton
        to="https://behance.net"
        target="_blank"
        icon="i-simple-icons-behance"
        aria-label="Rainbow Retouch on Behance"
        color="neutral"
        variant="ghost"
      />
      <UButton
        to="https://linkedin.com"
        target="_blank"
        icon="i-simple-icons-linkedin"
        aria-label="Rainbow Retouch on LinkedIn"
        color="neutral"
        variant="ghost"
      />
    </template>
  </UFooter>
</template>
