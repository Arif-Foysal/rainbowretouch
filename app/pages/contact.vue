<template>
  <div class="min-h-screen">
    <!-- Hero Section -->
    <br />

    <UContainer class="py-12">
      <!-- Main Content Grid -->
      <div class="grid lg:grid-cols-3 gap-8 items-start">
        <!-- Contact Form Card -->
        <div class="lg:col-span-2">
          <UCard variant="subtle" class="p-2">
            <template #header>
              <h2 class="text-3xl">Start Your Project</h2>
              <p class="text-sm text-gray-500 mt-1">Tell us about your goals and we'll propose the best approach.</p>
            </template>

            <UForm :validate="validate" :state="state" class="space-y-6" @submit="onSubmit" novalidate>
              <!-- Name Fields -->
              <div class="grid sm:grid-cols-2 gap-4">
                <UFormField label="First Name" name="firstName" required>
                  <UInput
                    v-model="state.firstName"
                    placeholder="Jane"
                    icon="i-heroicons-user"
                    class="w-full"
                    aria-label="First name"
                  />
                </UFormField>

                <UFormField label="Last Name" name="lastName" required>
                  <UInput
                    v-model="state.lastName"
                    placeholder="Doe"
                    icon="i-heroicons-user"
                    class="w-full"
                    aria-label="Last name"
                  />
                </UFormField>
              </div>

              <!-- Email -->
              <UFormField label="Business Email" name="email" required>
                <UInput
                  v-model="state.email"
                  type="email"
                  placeholder="hello@yourcompany.com"
                  icon="i-heroicons-envelope"
                  class="w-full"
                  aria-label="Business email"
                />
              </UFormField>

              <!-- Phone (Optional) -->
              <UFormField label="Phone Number" name="phone" hint="Optional">
                <UInput
                  v-model="state.phone"
                  type="tel"
                  placeholder="+880 1XX-XXX-XXXX"
                  icon="i-heroicons-phone"
                  class="w-full"
                  aria-label="Phone number"
                />
              </UFormField>

              <!-- Subject/Topic -->
              <UFormField label="Project Type" name="subject" required>
                <USelectMenu
                  v-model="state.subject"
                  :items="subjects"
                  placeholder="Select a project type"
                  icon="i-heroicons-briefcase"
                  class="w-full"
                  aria-label="Project type"
                />
              </UFormField>

              <!-- Budget & Deadline -->
              <div class="grid sm:grid-cols-2 gap-4">
                <UFormField label="Estimated Budget (USD)" name="budget">
                  <UInput
                    v-model="state.budget"
                    type="text"
                    placeholder="e.g., 1500 - 5000"
                    icon="i-heroicons-currency-dollar"
                    class="w-full"
                    aria-label="Estimated budget"
                  />
                </UFormField>

                <UFormField label="Project Deadline" name="deadline" hint="Optional">
                  <UInput
                    v-model="state.deadline"
                    type="date"
                    class="w-full"
                    aria-label="Project deadline"
                  />
                </UFormField>
              </div>

              <!-- Message -->
              <UFormField label="Project Brief" name="message" required>
                <UTextarea
                  v-model="state.message"
                  placeholder="Describe your project, goals, target audience, examples you like..."
                  :rows="6"
                  class="w-full"
                  aria-label="Project brief"
                />
              </UFormField>

              <!-- File upload -->
              <UFormField label="Attach Images" name="attachments" hint="Optional — max 2MB each. SVG, PNG, JPG, GIF">
                <UFileUpload
                  v-model="state.attachments"
                  color="neutral"
                  highlight
                  label="Drop your image here"
                  description="SVG, PNG, JPG or GIF (max. 2MB)"
                  class="w-full min-h-48"
                  accept=".svg,.png,.jpg,.jpeg,.gif"
                  :max-file-size="2 * 1024 * 1024"
                  multiple
                />
                <div v-if="state.attachments.length" class="mt-2 space-y-1">
                  <div
                    v-for="(f, i) in state.attachments"
                    :key="i"
                    class="flex items-center justify-between bg-gray-50 p-2 rounded"
                  >
                    <div class="text-sm truncate max-w-xs">{{ f.name }}</div>
                    <div class="text-xs text-gray-500">{{ humanFileSize(f.size) }}</div>
                  </div>
                </div>
              </UFormField>

              <!-- Newsletter Checkbox -->
              <UFormField name="newsletter">
                <UCheckbox v-model="state.newsletter" label="Join our design newsletter (case studies & free resources)" />
              </UFormField>

              <!-- Consent -->
              <UFormField name="consent" required>
                <UCheckbox
                  v-model="state.consent"
                  :label="`I agree to the Privacy Policy and to be contacted about this project.`"
                />
              </UFormField>

              <!-- Submit Button -->
              <div class="flex gap-3">
                <UButton type="submit" size="lg" :loading="isSubmitting">Send Request</UButton>
                <UButton variant="outline" size="lg" @click="resetForm">Clear</UButton>
              </div>
            </UForm>
          </UCard>
        </div>

        <!-- Contact Information Sidebar -->
        <div class="space-y-6">
          <!-- Contact Info Card -->
          <UCard variant="subtle">
            <template #header>
              <h3 class="text-3xl ">Contact</h3>
              <p class="text-sm text-gray-500 mt-1">Prefer direct contact? Reach our team below.</p>
            </template>

            <div class="space-y-6">
              <!-- Agency Logo / Photo -->
              <div class="flex justify-center">
                <img
                  src="/agency-logo.png"
                  alt="Agency logo"
                  class="w-full rounded-md object-contain"
                  v-if="hasLogo"
                />
              </div>

              <!-- Contact Details -->
              <div class="space-y-4">
                <!-- Email -->
                <div class="flex items-start gap-3">
                  <UIcon name="i-heroicons-envelope" class="w-5 h-5 text-primary mt-1" />
                  <div>
                    <p class="font-medium">Email</p>
                    <a href="mailto:hello@rainbowretouch.com" class="text-primary hover:underline">hello@rainbowretouch.com</a>
                  </div>
                </div>

                <!-- Phone -->
                <div class="flex items-start gap-3">
                  <UIcon name="i-heroicons-phone" class="w-5 h-5 text-primary mt-1" />
                  <div>
                    <p class="font-medium">Phone</p>
                    <a href="tel:+8801707820797" class="text-primary hover:underline">+880 (170) 782-0797</a>
                  </div>
                </div>

                <!-- Address -->
                <div class="flex items-start gap-3">
                  <UIcon name="i-heroicons-map-pin" class="w-5 h-5 text-primary mt-1" />
                  <div>
                    <p class="font-medium">Studio</p>
                    <p class="text-gray-600 dark:text-gray-400">
                      123 Creative Lane<br />
                      Design City, DC 12345
                    </p>
                  </div>
                </div>

                <!-- Hours -->
                <div class="flex items-start gap-3">
                  <UIcon name="i-heroicons-clock" class="w-5 h-5 text-primary mt-1" />
                  <div>
                    <p class="font-medium">Hours</p>
                    <p class="text-gray-600 dark:text-gray-400">
                      Mon – Fri: 9:00 AM – 6:00 PM<br />
                      Sat: 10:00 AM – 4:00 PM • Sun: Closed
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </UCard>

          <!-- Services / Quick Links Card -->
          <UCard variant="subtle">
            <template #header>
              <h3 class="text-xl font-semibold">Our Services</h3>
            </template>

            <ul class="space-y-2 text-sm text-gray-600">
              <li>Brand Identity & Logos</li>
              <li>UI / UX & Product Design</li>
              <li>Marketing & Social Creatives</li>
              <li>Packaging & Print</li>
            </ul>

            <div class="mt-4">
                
              <UButton to="/" variant="outline" size="sm">View Portfolio</UButton>
            </div>
          </UCard>

          <!-- Social Links Card -->
          <UCard variant="subtle">
            <template #header>
              <h3 class="text-xl font-semibold">Follow Us</h3>
            </template>

            <div class="flex gap-3">
              <UButton icon="i-simple-icons-instagram" variant="soft" color="neutral" to="https://instagram.com" target="_blank" square />
              <UButton icon="i-simple-icons-dribbble" variant="soft" color="neutral" to="https://dribbble.com" target="_blank" square />
              <UButton icon="i-simple-icons-behance" variant="soft" color="neutral" to="https://behance.net" target="_blank" square />
              <UButton icon="i-simple-icons-linkedin" variant="soft" color="neutral" to="https://linkedin.com" target="_blank" square />
            </div>
          </UCard>
        </div>
      </div>
    </UContainer>
  </div>
</template>

<script setup lang="ts">
import type { FormError, FormSubmitEvent } from '@nuxt/ui'
import { ref, reactive } from 'vue'
import { useSupabaseClient } from '#imports'

const supabase = useSupabaseClient()

/* ---------- State ---------- */
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
const fileInput = ref<HTMLInputElement | null>(null)
const hasLogo = true // toggle if you have agency logo image

/* ---------- Options ---------- */
const subjects = [
  { label: 'Brand Identity', value: 'brand' },
  { label: 'Product / UI Design', value: 'ui-ux' },
  { label: 'Marketing / Social', value: 'marketing' },
  { label: 'Packaging / Print', value: 'print' },
  { label: 'Illustration', value: 'illustration' },
  { label: 'Other', value: 'other' }
]

/* ---------- Utils ---------- */
function humanFileSize(bytes: number) {
  const thresh = 1024
  if (Math.abs(bytes) < thresh) return bytes + ' B'
  const units = ['KB', 'MB', 'GB', 'TB']
  let u = -1
  do {
    bytes /= thresh
    ++u
  } while (Math.abs(bytes) >= thresh && u < units.length - 1)
  return bytes.toFixed(1) + ' ' + units[u]
}

/* ---------- Validation ---------- */
function validate(statePartial: Partial<Schema>): FormError[] {
  const errors: FormError[] = []

  if (!statePartial.firstName) errors.push({ name: 'firstName', message: 'First name is required' })
  if (!statePartial.lastName) errors.push({ name: 'lastName', message: 'Last name is required' })

  if (!statePartial.email) {
    errors.push({ name: 'email', message: 'Email is required' })
  } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(statePartial.email as string)) {
    errors.push({ name: 'email', message: 'Invalid email format' })
  }

  if (!statePartial.subject) errors.push({ name: 'subject', message: 'Please select a project type' })

  if (!statePartial.message || (statePartial.message as string).trim().length < 10) {
    errors.push({ name: 'message', message: 'Please provide a brief description (at least 10 characters)' })
  }

  if (!statePartial.consent) errors.push({ name: 'consent', message: 'You must agree to be contacted' })

  // File size validation (max 2 MB per file)
  for (const f of state.attachments) {
    if (f.size > 2 * 1024 * 1024) {
      errors.push({ name: 'attachments', message: `${f.name} is too large (max 2 MB)` })
      break
    }
  }

  return errors
}

/* ---------- File handling ---------- */
function onFilesSelected(e: Event) {
  const target = e.target as HTMLInputElement
  if (!target?.files) return
  const selected = Array.from(target.files)

  // filter and validate
  const allowed = ['image/png', 'image/jpeg', 'image/gif', 'image/svg+xml']
  const maxSize = 2 * 1024 * 1024 // 2 MB

  const validFiles: File[] = []
  for (const f of selected) {
    if (!allowed.includes(f.type) && !f.name.endsWith('.zip')) {
      // skip unsupported types
      // you could show a toast here if you want
      continue
    }
    if (f.size > maxSize) {
      // skip oversized files
      continue
    }
    validFiles.push(f)
  }

  state.attachments = state.attachments.concat(validFiles)
  // reset input so same file can be reselected later
  if (fileInput.value) fileInput.value.value = ''
}

/* ---------- Toast & Submission ---------- */
const toast = useToast()

// Helper: upload a file to Supabase Storage and return the public URL
async function uploadFile(file: File): Promise<{ url: string, name: string, size: number, type: string }> {
  const filePath = `${Date.now()}-${file.name}`
  const { data, error } = await supabase.storage.from('contact-attachments').upload(filePath, file, {
    cacheControl: '3600',
    upsert: false
  })
  if (error) throw error
  // Get public URL
  const { data: publicUrlData } = supabase.storage.from('contact-attachments').getPublicUrl(filePath)
  return {
    url: publicUrlData.publicUrl,
    name: file.name,
    size: file.size,
    type: file.type
  }
}

async function onSubmit(event: FormSubmitEvent<Schema>) {
  isSubmitting.value = true
  try {
    // 1. Upload files to Supabase Storage
    let uploadedFiles = []
    if (state.attachments.length) {
      uploadedFiles = await Promise.all(
        state.attachments.map(f => uploadFile(f))
      )
    }
    // 2. Insert form data into Supabase
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
    })
    if (error) throw error
    toast.add({
      title: 'Request received',
      description: 'Thanks — our team received your brief. We will reply within 24 hours to schedule a call.',
      color: 'success',
      icon: 'i-heroicons-check-circle'
    })
    resetForm()
    console.log('Form submitted:', event.data)
  } catch (err) {
    console.error(err)
    toast.add({
      title: 'Submission failed',
      description: 'Something went wrong while sending your request — please try again or email hello@rainbowretouch.com directly.',
      color: 'error',
      icon: 'i-heroicons-x-circle'
    })
  } finally {
    isSubmitting.value = false
  }
}

/* ---------- Reset ---------- */
function resetForm() {
  state.firstName = undefined
  state.lastName = undefined
  state.email = undefined
  state.phone = undefined
  state.subject = undefined
  state.budget = undefined
  state.deadline = undefined
  state.message = undefined
  state.attachments = []
  state.newsletter = false
  state.consent = false
}

/* ---------- SEO ---------- */
useHead({
  title: 'Contact — Rainbow Retouch',
  meta: [
    { name: 'description', content: "Contact Rainbow Retouch — let's talk about your design project. We'll reply within 24 hours." }
  ]
})
</script>

<style scoped>
/* Optional small tweaks for better spacing on the contact form */
.form-radio {
  width: 1rem;
  height: 1rem;
}
</style>
