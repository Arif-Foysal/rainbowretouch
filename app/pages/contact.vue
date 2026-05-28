<script setup lang="ts">
import type { FormError, FormSubmitEvent } from '@nuxt/ui'

const supabase = useSupabaseClient()
const { data: settings } = await useSiteSettings()

const contactInfo = computed(() => settings.value?.contact || {})
const social = computed(() => settings.value?.social || {})
const site = computed(() => settings.value?.site || {})

const socialButtons = computed(() => {
  const map: Array<{ name: string, icon: string, url?: string }> = [
    { name: 'Instagram', icon: 'i-simple-icons-instagram', url: social.value.instagram },
    { name: 'Facebook', icon: 'i-simple-icons-facebook', url: social.value.facebook },
    { name: 'LinkedIn', icon: 'i-simple-icons-linkedin', url: social.value.linkedin },
    { name: 'Behance', icon: 'i-simple-icons-behance', url: social.value.behance },
    { name: 'Dribbble', icon: 'i-simple-icons-dribbble', url: social.value.dribbble },
    { name: 'Twitter', icon: 'i-simple-icons-x', url: social.value.twitter }
  ]
  return map.filter(s => !!s.url)
})

const state = reactive({
  firstName: undefined as string | undefined,
  lastName: undefined as string | undefined,
  email: undefined as string | undefined,
  phone: undefined as string | undefined,
  subject: undefined as string | undefined,
  budget: undefined as string | undefined,
  deadline: undefined as string | undefined,
  message: undefined as string | undefined,
  attachments: [] as File[],
  newsletter: false,
  consent: false
})

type Schema = typeof state

const isSubmitting = ref(false)

const subjects = [
  { label: 'Background Removal / Clipping Path', value: 'background-removal' },
  { label: 'Photo Retouching', value: 'retouching' },
  { label: 'Color Correction', value: 'color-correction' },
  { label: 'Image Manipulation', value: 'manipulation' },
  { label: 'Bulk Project', value: 'bulk' },
  { label: 'Other', value: 'other' }
]

function humanFileSize(bytes: number) {
  const thresh = 1024
  if (Math.abs(bytes) < thresh) return bytes + ' B'
  const units = ['KB', 'MB', 'GB', 'TB']
  let u = -1
  do { bytes /= thresh; ++u } while (Math.abs(bytes) >= thresh && u < units.length - 1)
  return bytes.toFixed(1) + ' ' + units[u]
}

function validate(s: Partial<Schema>): FormError[] {
  const errors: FormError[] = []
  if (!s.firstName) errors.push({ name: 'firstName', message: 'First name is required' })
  if (!s.lastName) errors.push({ name: 'lastName', message: 'Last name is required' })
  if (!s.email) errors.push({ name: 'email', message: 'Email is required' })
  else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(s.email)) errors.push({ name: 'email', message: 'Invalid email' })
  if (!s.subject) errors.push({ name: 'subject', message: 'Please select a project type' })
  if (!s.message || s.message.trim().length < 10) errors.push({ name: 'message', message: 'Message must be at least 10 characters' })
  if (!s.consent) errors.push({ name: 'consent', message: 'You must agree to be contacted' })
  for (const f of state.attachments) {
    if (f.size > 2 * 1024 * 1024) { errors.push({ name: 'attachments', message: `${f.name} too large (max 2 MB)` }); break }
  }
  return errors
}

const toast = useToast()

async function uploadFile(file: File) {
  const filePath = `${Date.now()}-${file.name}`
  const { error } = await supabase.storage.from('contact-attachments').upload(filePath, file, { cacheControl: '3600', upsert: false })
  if (error) throw error
  const { data: pub } = supabase.storage.from('contact-attachments').getPublicUrl(filePath)
  return { url: pub.publicUrl, name: file.name, size: file.size, type: file.type }
}

async function onSubmit(_e: FormSubmitEvent<Schema>) {
  isSubmitting.value = true
  try {
    let uploadedFiles: any[] = []
    if (state.attachments.length) {
      uploadedFiles = await Promise.all(state.attachments.map(f => uploadFile(f)))
    }
    const { error } = await supabase.from('contact_requests').insert({
      first_name: state.firstName,
      last_name: state.lastName,
      email: state.email,
      phone: state.phone,
      subject: state.subject,
      budget: state.budget,
      deadline: state.deadline || null,
      message: state.message,
      attachments: uploadedFiles.length ? uploadedFiles : null,
      newsletter: state.newsletter,
      consent: state.consent
    } as any)
    if (error) throw error
    toast.add({
      title: 'Request received',
      description: 'Thanks — we will reply within 24 hours.',
      color: 'success',
      icon: 'i-heroicons-check-circle'
    })
    resetForm()
  } catch (err) {
    console.error(err)
    toast.add({
      title: 'Submission failed',
      description: 'Please try again or email us directly.',
      color: 'error',
      icon: 'i-heroicons-x-circle'
    })
  } finally {
    isSubmitting.value = false
  }
}

function resetForm() {
  state.firstName = state.lastName = state.email = state.phone = state.subject = state.budget = state.deadline = state.message = undefined
  state.attachments = []
  state.newsletter = false
  state.consent = false
}

useHead({
  title: 'Contact — Rainbow Retouch',
  meta: [{ name: 'description', content: 'Contact us — we reply within 24 hours.' }]
})
</script>

<template>
  <div class="min-h-screen">
    <UContainer class="py-8 sm:py-12">
      <div class="grid lg:grid-cols-3 gap-6 lg:gap-8 items-start">
        <div class="lg:col-span-2">
          <UCard variant="subtle" class="p-2">
            <template #header>
              <h2 class="text-2xl sm:text-3xl font-semibold">
                Start Your Project
              </h2>
              <p class="text-sm text-muted mt-1">
                Tell us about your goals and we'll propose the best approach.
              </p>
            </template>

            <UForm :validate="validate" :state="state" class="space-y-5 sm:space-y-6" novalidate @submit="onSubmit">
              <div class="grid sm:grid-cols-2 gap-4">
                <UFormField label="First Name" name="firstName" required>
                  <UInput v-model="state.firstName" placeholder="Jane" icon="i-heroicons-user" class="w-full" />
                </UFormField>
                <UFormField label="Last Name" name="lastName" required>
                  <UInput v-model="state.lastName" placeholder="Doe" icon="i-heroicons-user" class="w-full" />
                </UFormField>
              </div>

              <UFormField label="Business Email" name="email" required>
                <UInput v-model="state.email" type="email" placeholder="hello@yourcompany.com" icon="i-heroicons-envelope" class="w-full" />
              </UFormField>

              <UFormField label="Phone Number" name="phone" hint="Optional">
                <UInput v-model="state.phone" type="tel" placeholder="+880 1XX-XXX-XXXX" icon="i-heroicons-phone" class="w-full" />
              </UFormField>

              <UFormField label="Project Type" name="subject" required>
                <USelectMenu v-model="(state.subject as any)" :items="(subjects as any)" placeholder="Select a project type" icon="i-heroicons-briefcase" class="w-full" />
              </UFormField>

              <div class="grid sm:grid-cols-2 gap-4">
                <UFormField label="Estimated Budget (USD)" name="budget">
                  <UInput v-model="state.budget" type="text" placeholder="e.g., 1500 - 5000" icon="i-heroicons-currency-dollar" class="w-full" />
                </UFormField>
                <UFormField label="Project Deadline" name="deadline" hint="Optional">
                  <UInput v-model="state.deadline" type="date" class="w-full" />
                </UFormField>
              </div>

              <UFormField label="Project Brief" name="message" required>
                <UTextarea v-model="state.message" placeholder="Describe your project, goals, examples you like..." :rows="6" class="w-full" />
              </UFormField>

              <UFormField label="Attach Images" name="attachments" hint="Optional — max 2MB each">
                <UFileUpload
                  v-model="state.attachments"
                  color="neutral"
                  highlight
                  label="Drop your image here"
                  description="SVG, PNG, JPG or GIF (max. 2MB)"
                  class="w-full min-h-40"
                  accept=".svg,.png,.jpg,.jpeg,.gif"
                  :max-file-size="2 * 1024 * 1024"
                  multiple
                />
                <div v-if="state.attachments.length" class="mt-2 space-y-1">
                  <div v-for="(f, i) in state.attachments" :key="i" class="flex items-center justify-between bg-muted/30 p-2 rounded">
                    <div class="text-sm truncate max-w-xs">
                      {{ f.name }}
                    </div>
                    <div class="text-xs text-muted">
                      {{ humanFileSize(f.size) }}
                    </div>
                  </div>
                </div>
              </UFormField>

              <UFormField name="newsletter">
                <UCheckbox v-model="state.newsletter" label="Send me design tips and case studies" />
              </UFormField>

              <UFormField name="consent" required>
                <UCheckbox v-model="state.consent" label="I agree to the Privacy Policy and to be contacted about this project." />
              </UFormField>

              <div class="flex flex-wrap gap-3">
                <UButton type="submit" size="lg" :loading="isSubmitting">
                  Send Request
                </UButton>
                <UButton variant="outline" size="lg" @click="resetForm">
                  Clear
                </UButton>
              </div>
            </UForm>
          </UCard>
        </div>

        <div class="space-y-6">
          <UCard variant="subtle">
            <template #header>
              <h3 class="text-2xl sm:text-3xl font-semibold">
                Contact
              </h3>
              <p class="text-sm text-muted mt-1">
                Prefer direct contact? Reach our team below.
              </p>
            </template>

            <div class="space-y-6">
              <div v-if="site.logo_url" class="flex justify-center">
                <img :src="site.logo_url" alt="Logo" class="max-h-24 object-contain">
              </div>

              <div class="space-y-4">
                <div v-if="contactInfo.email" class="flex items-start gap-3">
                  <UIcon name="i-heroicons-envelope" class="w-5 h-5 text-primary mt-1" />
                  <div class="min-w-0">
                    <p class="font-medium">
                      Email
                    </p>
                    <a :href="`mailto:${contactInfo.email}`" class="text-primary hover:underline break-all">{{ contactInfo.email }}</a>
                  </div>
                </div>

                <div v-if="contactInfo.phone" class="flex items-start gap-3">
                  <UIcon name="i-heroicons-phone" class="w-5 h-5 text-primary mt-1" />
                  <div>
                    <p class="font-medium">
                      Phone
                    </p>
                    <a :href="`tel:${contactInfo.phone_link || contactInfo.phone}`" class="text-primary hover:underline">{{ contactInfo.phone }}</a>
                  </div>
                </div>

                <div v-if="contactInfo.address_line1" class="flex items-start gap-3">
                  <UIcon name="i-heroicons-map-pin" class="w-5 h-5 text-primary mt-1" />
                  <div>
                    <p class="font-medium">
                      Studio
                    </p>
                    <p class="text-muted">
                      {{ contactInfo.address_line1 }}<br>
                      <span v-if="contactInfo.address_line2">{{ contactInfo.address_line2 }}</span>
                    </p>
                  </div>
                </div>

                <div v-if="contactInfo.hours_weekday" class="flex items-start gap-3">
                  <UIcon name="i-heroicons-clock" class="w-5 h-5 text-primary mt-1" />
                  <div>
                    <p class="font-medium">
                      Hours
                    </p>
                    <p class="text-muted">
                      {{ contactInfo.hours_weekday }}<br>
                      <span v-if="contactInfo.hours_weekend">{{ contactInfo.hours_weekend }}</span>
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </UCard>

          <UCard v-if="socialButtons.length" variant="subtle">
            <template #header>
              <h3 class="text-xl font-semibold">
                Follow Us
              </h3>
            </template>
            <div class="flex gap-3 flex-wrap">
              <UButton
                v-for="s in socialButtons"
                :key="s.name"
                :icon="s.icon"
                :to="s.url"
                target="_blank"
                variant="soft"
                color="neutral"
                square
                :aria-label="s.name"
              />
            </div>
          </UCard>
        </div>
      </div>
    </UContainer>
  </div>
</template>
