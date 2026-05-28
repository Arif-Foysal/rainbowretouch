<script setup lang="ts">
definePageMeta({ middleware: 'admin', layout: 'admin' })

const supabase = useSupabaseClient<any>()
const toast = useToast()

type SeoGroup = 'meta' | 'og' | 'twitter' | 'robots' | 'icons' | 'verification' | 'analytics' | 'schema'

const loading = ref(true)
const saving = ref<SeoGroup | null>(null)
const seo = ref<Record<SeoGroup, any>>({
  meta: {}, og: {}, twitter: {}, robots: {}, icons: {}, verification: {}, analytics: {}, schema: {}
})
const sameAsRaw = ref('')

const fetchAll = async () => {
  loading.value = true
  const { data } = await supabase
    .from('site_settings')
    .select('value')
    .eq('key', 'seo')
    .maybeSingle()
  const v = (data?.value || {}) as Record<SeoGroup, any>
  for (const k of Object.keys(seo.value) as SeoGroup[]) {
    seo.value[k] = v[k] || {}
  }
  if (!('index' in (seo.value.robots || {}))) seo.value.robots.index = true
  if (!('follow' in (seo.value.robots || {}))) seo.value.robots.follow = true
  if (!('enabled' in (seo.value.schema || {}))) seo.value.schema.enabled = true
  sameAsRaw.value = Array.isArray(seo.value.schema?.sameAs)
    ? seo.value.schema.sameAs.join('\n')
    : ''
  loading.value = false
}
onMounted(fetchAll)

const save = async (group: SeoGroup) => {
  saving.value = group
  if (group === 'schema') {
    seo.value.schema.sameAs = sameAsRaw.value
      .split('\n').map(s => s.trim()).filter(Boolean)
  }

  const { data: existing } = await supabase
    .from('site_settings')
    .select('value')
    .eq('key', 'seo')
    .maybeSingle()
  const merged = { ...((existing?.value || {}) as Record<string, any>), [group]: seo.value[group] }

  const { error } = await supabase
    .from('site_settings')
    .upsert({ key: 'seo', value: merged, updated_at: new Date().toISOString() }, { onConflict: 'key' })
  saving.value = null
  if (error) {
    toast.add({ title: 'Error', description: error.message, color: 'error' })
  } else {
    toast.add({ title: 'Saved', description: `${groupLabels[group]} updated.`, color: 'success' })
  }
}

const groupLabels: Record<SeoGroup, string> = {
  meta: 'Default meta',
  og: 'Open Graph',
  twitter: 'Twitter card',
  robots: 'Robots',
  icons: 'Icons & theme',
  verification: 'Site verification',
  analytics: 'Analytics',
  schema: 'Organization schema'
}

const uploading = ref<string | null>(null)
async function uploadAsset(file: File, group: SeoGroup, fieldPath: string, maxMb = 5) {
  if (file.size > maxMb * 1024 * 1024) {
    toast.add({ title: 'Too large', description: `Max ${maxMb} MB`, color: 'error' })
    return
  }
  uploading.value = `${group}.${fieldPath}`
  const ext = file.name.split('.').pop() || 'png'
  const path = `seo/${group}-${fieldPath}-${Date.now()}.${ext}`
  const { error } = await supabase.storage.from('site-content').upload(path, file, { upsert: true, contentType: file.type })
  if (error) {
    toast.add({ title: 'Upload failed', description: error.message, color: 'error' })
    uploading.value = null
    return
  }
  const { data: pub } = supabase.storage.from('site-content').getPublicUrl(path)
  seo.value[group][fieldPath] = pub.publicUrl
  uploading.value = null
  toast.add({ title: 'Uploaded', description: 'Click Save to apply.', color: 'success' })
}
const onFile = (e: Event, group: SeoGroup, field: string, maxMb = 5) => {
  const f = (e.target as HTMLInputElement).files?.[0]
  if (f) uploadAsset(f, group, field, maxMb)
  ;(e.target as HTMLInputElement).value = ''
}
</script>

<template>
  <div class="min-h-dvh">
    <header class="border-b border-default bg-background px-4 sm:px-6 py-3 flex items-center gap-3 sticky top-0 z-10">
      <NuxtLink to="/admin" class="text-sm text-muted hover:text-highlighted flex items-center gap-1">
        <UIcon name="i-lucide-arrow-left" class="w-4 h-4" /> <span class="hidden sm:inline">Back to admin</span>
      </NuxtLink>
      <h1 class="text-base font-semibold ml-2">SEO Settings</h1>
    </header>

    <main class="max-w-3xl mx-auto p-4 sm:p-6 space-y-6">
      <div v-if="loading" class="flex items-center justify-center py-16">
        <UIcon name="i-lucide-loader-2" class="h-8 w-8 animate-spin text-primary" />
      </div>

      <template v-else>
        <!-- DEFAULT META -->
        <UCard>
          <template #header>
            <h2 class="font-semibold">Default meta</h2>
            <p class="text-xs text-muted mt-0.5">Applied site-wide; per-page <code>useSeoMeta</code> overrides win.</p>
          </template>
          <div class="space-y-4">
            <UFormField label="Default title">
              <UInput v-model="seo.meta.default_title" placeholder="Rainbow Retouch" />
            </UFormField>
            <UFormField label="Title template" help="Use %s for the page title. e.g. '%s — Rainbow Retouch'">
              <UInput v-model="seo.meta.title_template" placeholder="%s — Rainbow Retouch" />
            </UFormField>
            <UFormField label="Default description">
              <UTextarea v-model="seo.meta.default_description" :rows="3" />
            </UFormField>
            <UFormField label="Keywords" help="Comma-separated">
              <UInput v-model="seo.meta.keywords" />
            </UFormField>
            <UFormField label="Author">
              <UInput v-model="seo.meta.author" />
            </UFormField>
            <UFormField label="Canonical base URL" help="e.g. https://rainbowretouch.com (no trailing slash)">
              <UInput v-model="seo.meta.canonical_base" />
            </UFormField>
          </div>
          <template #footer>
            <UButton :loading="saving === 'meta'" @click="save('meta')">Save</UButton>
          </template>
        </UCard>

        <!-- OPEN GRAPH -->
        <UCard>
          <template #header>
            <h2 class="font-semibold">Open Graph</h2>
            <p class="text-xs text-muted mt-0.5">Used by Facebook, LinkedIn, Slack, etc.</p>
          </template>
          <div class="space-y-4">
            <UFormField label="Site name">
              <UInput v-model="seo.og.site_name" />
            </UFormField>
            <UFormField label="Type" help="Usually 'website' for marketing sites">
              <UInput v-model="seo.og.type" placeholder="website" />
            </UFormField>
            <UFormField label="Locale">
              <UInput v-model="seo.og.locale" placeholder="en_US" />
            </UFormField>
            <UFormField label="Default OG image URL" help="1200×630 recommended">
              <UInput v-model="seo.og.default_image" placeholder="https://..." />
              <div class="mt-2 flex items-center gap-2">
                <label class="text-xs cursor-pointer text-primary hover:underline">
                  <input type="file" accept="image/*" class="hidden" @change="onFile($event, 'og', 'default_image')">
                  Upload image
                </label>
                <span v-if="uploading === 'og.default_image'" class="text-xs text-muted">Uploading…</span>
              </div>
              <img v-if="seo.og.default_image" :src="seo.og.default_image" class="mt-2 max-h-32 rounded border border-default" />
            </UFormField>
          </div>
          <template #footer>
            <UButton :loading="saving === 'og'" @click="save('og')">Save</UButton>
          </template>
        </UCard>

        <!-- TWITTER -->
        <UCard>
          <template #header>
            <h2 class="font-semibold">Twitter / X card</h2>
          </template>
          <div class="space-y-4">
            <UFormField label="Card type" help="summary | summary_large_image | app | player">
              <UInput v-model="seo.twitter.card" placeholder="summary_large_image" />
            </UFormField>
            <UFormField label="Site @handle">
              <UInput v-model="seo.twitter.site" placeholder="@rainbowretouch" />
            </UFormField>
            <UFormField label="Creator @handle">
              <UInput v-model="seo.twitter.creator" placeholder="@founder" />
            </UFormField>
            <UFormField label="Default Twitter image URL">
              <UInput v-model="seo.twitter.default_image" />
              <div class="mt-2 flex items-center gap-2">
                <label class="text-xs cursor-pointer text-primary hover:underline">
                  <input type="file" accept="image/*" class="hidden" @change="onFile($event, 'twitter', 'default_image')">
                  Upload image
                </label>
                <span v-if="uploading === 'twitter.default_image'" class="text-xs text-muted">Uploading…</span>
              </div>
              <img v-if="seo.twitter.default_image" :src="seo.twitter.default_image" class="mt-2 max-h-32 rounded border border-default" />
            </UFormField>
          </div>
          <template #footer>
            <UButton :loading="saving === 'twitter'" @click="save('twitter')">Save</UButton>
          </template>
        </UCard>

        <!-- ROBOTS -->
        <UCard>
          <template #header>
            <h2 class="font-semibold">Robots</h2>
          </template>
          <div class="space-y-4">
            <UFormField>
              <UCheckbox v-model="seo.robots.index" label="Allow search engines to index pages" />
            </UFormField>
            <UFormField>
              <UCheckbox v-model="seo.robots.follow" label="Allow search engines to follow links" />
            </UFormField>
            <UFormField label="Extra directives" help="e.g. 'max-snippet:-1, max-image-preview:large'">
              <UInput v-model="seo.robots.extra" />
            </UFormField>
          </div>
          <template #footer>
            <UButton :loading="saving === 'robots'" @click="save('robots')">Save</UButton>
          </template>
        </UCard>

        <!-- ICONS / THEME -->
        <UCard>
          <template #header>
            <h2 class="font-semibold">Icons & theme</h2>
          </template>
          <div class="space-y-4">
            <UFormField label="Favicon URL" help="Defaults to /favicon.ico">
              <UInput v-model="seo.icons.favicon" />
              <div class="mt-2 flex items-center gap-2">
                <label class="text-xs cursor-pointer text-primary hover:underline">
                  <input type="file" accept="image/*,image/x-icon" class="hidden" @change="onFile($event, 'icons', 'favicon', 1)">
                  Upload favicon
                </label>
                <span v-if="uploading === 'icons.favicon'" class="text-xs text-muted">Uploading…</span>
              </div>
            </UFormField>
            <UFormField label="Apple touch icon URL" help="180×180 PNG">
              <UInput v-model="seo.icons.apple_touch_icon" />
              <div class="mt-2 flex items-center gap-2">
                <label class="text-xs cursor-pointer text-primary hover:underline">
                  <input type="file" accept="image/png" class="hidden" @change="onFile($event, 'icons', 'apple_touch_icon', 1)">
                  Upload icon
                </label>
                <span v-if="uploading === 'icons.apple_touch_icon'" class="text-xs text-muted">Uploading…</span>
              </div>
            </UFormField>
            <UFormField label="Theme color" help="Browser chrome color on mobile">
              <UInput v-model="seo.icons.theme_color" placeholder="#ffffff" />
            </UFormField>
          </div>
          <template #footer>
            <UButton :loading="saving === 'icons'" @click="save('icons')">Save</UButton>
          </template>
        </UCard>

        <!-- VERIFICATION -->
        <UCard>
          <template #header>
            <h2 class="font-semibold">Site verification</h2>
            <p class="text-xs text-muted mt-0.5">Paste the content value (not the full meta tag).</p>
          </template>
          <div class="space-y-4">
            <UFormField label="Google Search Console">
              <UInput v-model="seo.verification.google" />
            </UFormField>
            <UFormField label="Bing Webmaster">
              <UInput v-model="seo.verification.bing" />
            </UFormField>
            <UFormField label="Pinterest">
              <UInput v-model="seo.verification.pinterest" />
            </UFormField>
            <UFormField label="Facebook domain">
              <UInput v-model="seo.verification.facebook" />
            </UFormField>
            <UFormField label="Yandex">
              <UInput v-model="seo.verification.yandex" />
            </UFormField>
          </div>
          <template #footer>
            <UButton :loading="saving === 'verification'" @click="save('verification')">Save</UButton>
          </template>
        </UCard>

        <!-- ANALYTICS -->
        <UCard>
          <template #header>
            <h2 class="font-semibold">Analytics</h2>
            <p class="text-xs text-muted mt-0.5">Scripts injected only when IDs are set.</p>
          </template>
          <div class="space-y-4">
            <UFormField label="Google Analytics 4 measurement ID" help="e.g. G-XXXXXXXXXX">
              <UInput v-model="seo.analytics.ga4_id" />
            </UFormField>
            <UFormField label="Google Tag Manager container ID" help="e.g. GTM-XXXXXXX">
              <UInput v-model="seo.analytics.gtm_id" />
            </UFormField>
            <UFormField label="Plausible domain" help="e.g. rainbowretouch.com">
              <UInput v-model="seo.analytics.plausible_domain" />
            </UFormField>
            <UFormField label="Plausible script src">
              <UInput v-model="seo.analytics.plausible_src" placeholder="https://plausible.io/js/script.js" />
            </UFormField>
          </div>
          <template #footer>
            <UButton :loading="saving === 'analytics'" @click="save('analytics')">Save</UButton>
          </template>
        </UCard>

        <!-- SCHEMA -->
        <UCard>
          <template #header>
            <h2 class="font-semibold">Organization schema (JSON-LD)</h2>
            <p class="text-xs text-muted mt-0.5">Rich-results metadata. Injected as a &lt;script type=&quot;application/ld+json&quot;&gt; tag.</p>
          </template>
          <div class="space-y-4">
            <UFormField>
              <UCheckbox v-model="seo.schema.enabled" label="Enable JSON-LD output" />
            </UFormField>
            <UFormField label="Schema type" help="Organization | LocalBusiness | Person">
              <UInput v-model="seo.schema.type" placeholder="Organization" />
            </UFormField>
            <UFormField label="Name">
              <UInput v-model="seo.schema.name" />
            </UFormField>
            <UFormField label="Logo URL">
              <UInput v-model="seo.schema.logo_url" />
            </UFormField>
            <UFormField label="URL" help="Canonical site URL">
              <UInput v-model="seo.schema.url" />
            </UFormField>
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <UFormField label="Phone">
                <UInput v-model="seo.schema.phone" />
              </UFormField>
              <UFormField label="Email">
                <UInput v-model="seo.schema.email" />
              </UFormField>
            </div>
            <UFormField label="Street">
              <UInput v-model="seo.schema.street" />
            </UFormField>
            <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
              <UFormField label="City">
                <UInput v-model="seo.schema.city" />
              </UFormField>
              <UFormField label="Region / State">
                <UInput v-model="seo.schema.region" />
              </UFormField>
              <UFormField label="Postal code">
                <UInput v-model="seo.schema.postal_code" />
              </UFormField>
            </div>
            <UFormField label="Country">
              <UInput v-model="seo.schema.country" />
            </UFormField>
            <UFormField label="sameAs URLs" help="One URL per line — social profiles, Wikipedia, etc.">
              <UTextarea v-model="sameAsRaw" :rows="4" placeholder="https://twitter.com/yourbrand
https://www.linkedin.com/company/yourbrand" />
            </UFormField>
          </div>
          <template #footer>
            <UButton :loading="saving === 'schema'" @click="save('schema')">Save</UButton>
          </template>
        </UCard>
      </template>
    </main>
  </div>
</template>
