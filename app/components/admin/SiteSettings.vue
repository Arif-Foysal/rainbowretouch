<script setup lang="ts">
const supabase = useSupabaseClient()
const toast = useToast()

type FieldType = 'text' | 'textarea' | 'url' | 'json' | 'image' | 'video'

type SettingDef = {
  key: string
  title: string
  description: string
  fields: Array<{ path: string, label: string, type: FieldType, hint?: string, accept?: string, maxMb?: number }>
}

const settingDefs: SettingDef[] = [
  {
    key: 'site',
    title: 'Site Identity',
    description: 'Brand name, tagline, and logo',
    fields: [
      { path: 'name', label: 'Site Name', type: 'text' },
      { path: 'tagline', label: 'Tagline', type: 'text' },
      { path: 'description', label: 'Description', type: 'textarea' },
      { path: 'logo_url', label: 'Logo URL', type: 'url' }
    ]
  },
  {
    key: 'contact',
    title: 'Contact Information',
    description: 'Email, phone, address, hours',
    fields: [
      { path: 'email', label: 'Email', type: 'text' },
      { path: 'phone', label: 'Phone (display)', type: 'text' },
      { path: 'phone_link', label: 'Phone (dial digits only)', type: 'text', hint: 'Used in tel: links' },
      { path: 'whatsapp', label: 'WhatsApp number (digits only with country code)', type: 'text' },
      { path: 'address_line1', label: 'Address line 1', type: 'text' },
      { path: 'address_line2', label: 'Address line 2', type: 'text' },
      { path: 'hours_weekday', label: 'Weekday hours', type: 'text' },
      { path: 'hours_weekend', label: 'Weekend hours', type: 'text' }
    ]
  },
  {
    key: 'social',
    title: 'Social Links',
    description: 'Leave blank to hide an icon',
    fields: [
      { path: 'instagram', label: 'Instagram', type: 'url' },
      { path: 'facebook', label: 'Facebook', type: 'url' },
      { path: 'linkedin', label: 'LinkedIn', type: 'url' },
      { path: 'twitter', label: 'Twitter / X', type: 'url' },
      { path: 'behance', label: 'Behance', type: 'url' },
      { path: 'dribbble', label: 'Dribbble', type: 'url' }
    ]
  },
  {
    key: 'hero_video',
    title: 'Home — Hero Video',
    description: 'Full-bleed video at the top of the homepage. Leave video URL blank to use the poster image only.',
    fields: [
      { path: 'video_url', label: 'Hero Video', type: 'video', accept: 'video/mp4,video/webm,video/quicktime', maxMb: 100, hint: 'Upload an .mp4 / .webm / .mov file (max 100 MB) or paste a URL' },
      { path: 'poster_url', label: 'Poster image', type: 'image', accept: 'image/*', maxMb: 5, hint: 'Shown before the video loads, or if no video is set' },
      { path: 'headline', label: 'Small headline (eyebrow)', type: 'text' },
      { path: 'title', label: 'Title', type: 'text' },
      { path: 'description', label: 'Description', type: 'textarea' },
      { path: 'button_text', label: 'Button Label', type: 'text' },
      { path: 'button_link', label: 'Button Link', type: 'text' },
      { path: 'overlay_opacity', label: 'Overlay darkness (0 – 1)', type: 'text', hint: 'e.g. 0.45 — darker improves text readability' }
    ]
  },
  {
    key: 'home_hero',
    title: 'Home — Section under hero',
    description: 'The headline of the section that appears below the hero video',
    fields: [
      { path: 'headline', label: 'Headline (small)', type: 'text' },
      { path: 'title', label: 'Title', type: 'text' },
      { path: 'description', label: 'Description', type: 'textarea' }
    ]
  },
  {
    key: 'cta',
    title: 'Call to Action',
    description: 'Used at the bottom of multiple pages',
    fields: [
      { path: 'title', label: 'Title', type: 'text' },
      { path: 'description', label: 'Description', type: 'textarea' },
      { path: 'primary_label', label: 'Primary button label', type: 'text' },
      { path: 'primary_link', label: 'Primary button link', type: 'text' },
      { path: 'secondary_label', label: 'Secondary button label', type: 'text' },
      { path: 'secondary_link', label: 'Secondary button link', type: 'text' }
    ]
  },
  {
    key: 'about',
    title: 'About Page',
    description: 'About hero and stats',
    fields: [
      { path: 'headline', label: 'Headline', type: 'text' },
      { path: 'title', label: 'Title', type: 'text' },
      { path: 'description', label: 'Description', type: 'textarea' },
      { path: 'hero_image_url', label: 'Hero image URL', type: 'url' },
      { path: 'stats', label: 'Stats (JSON: [{value, label, icon}, ...])', type: 'json', hint: 'Array of {value, label, icon} objects. icon is a Lucide name like "i-lucide-award".' }
    ]
  },
  {
    key: 'seo',
    title: 'SEO Defaults',
    description: 'Default title and description for pages',
    fields: [
      { path: 'default_title', label: 'Default Title', type: 'text' },
      { path: 'default_description', label: 'Default Description', type: 'textarea' }
    ]
  },
  {
    key: 'payments',
    title: 'Footer — Payment Methods',
    description: 'Logos shown at the top of the footer',
    fields: [
      { path: 'items', label: 'Payment methods (JSON: [{name, icon, color}])', type: 'json', hint: 'Each item: { "name": "Visa", "icon": "i-simple-icons-visa", "color": "#1A1F71" }. Leave empty to use defaults.' }
    ]
  },
  {
    key: 'clients',
    title: 'Home — Renowned Clients',
    description: 'Logo strip of clients shown on the home page',
    fields: [
      { path: 'headline', label: 'Headline', type: 'text' },
      { path: 'title', label: 'Title', type: 'text' },
      { path: 'items', label: 'Logos (JSON: [{name, logo_url, link}])', type: 'json', hint: 'Each item: { "name": "Acme", "logo_url": "https://...", "link": "https://acme.com" }' }
    ]
  },
  {
    key: 'home_features',
    title: 'Home — Feature Cards',
    description: 'The "Why clients love us" section',
    fields: [
      { path: 'headline', label: 'Headline', type: 'text' },
      { path: 'title', label: 'Title', type: 'text' },
      { path: 'description', label: 'Description', type: 'textarea' },
      { path: 'items', label: 'Items (JSON: [{title, description, icon}])', type: 'json' }
    ]
  }
]

const values = ref<Record<string, any>>({})
const loading = ref(true)
const savingKey = ref<string | null>(null)
const uploading = ref<Record<string, boolean>>({})

async function uploadAsset(file: File, settingKey: string, fieldPath: string, maxMb = 50): Promise<string | null> {
  if (file.size > maxMb * 1024 * 1024) {
    toast.add({ title: 'File too large', description: `Max ${maxMb} MB`, color: 'error' })
    return null
  }
  const uploadKey = `${settingKey}.${fieldPath}`
  uploading.value[uploadKey] = true
  try {
    const ext = file.name.includes('.') ? file.name.split('.').pop() : 'bin'
    const path = `${settingKey}/${fieldPath}-${Date.now()}.${ext}`
    const { error } = await supabase.storage
      .from('site-content')
      .upload(path, file, { cacheControl: '31536000', upsert: false, contentType: file.type })
    if (error) throw error
    const { data: pub } = supabase.storage.from('site-content').getPublicUrl(path)
    return pub?.publicUrl || null
  } catch (e: any) {
    toast.add({ title: 'Upload failed', description: e.message || String(e), color: 'error' })
    return null
  } finally {
    uploading.value[uploadKey] = false
  }
}

async function onFileChosen(e: Event, settingKey: string, fieldPath: string, maxMb = 50) {
  const target = e.target as HTMLInputElement
  const file = target.files?.[0]
  if (!file) return
  const url = await uploadAsset(file, settingKey, fieldPath, maxMb)
  if (url) {
    updateField(settingKey, fieldPath, url)
    toast.add({ title: 'Uploaded', description: 'File uploaded — remember to click Save.', color: 'success' })
  }
  target.value = ''
}

const fetchAll = async () => {
  loading.value = true
  const { data, error } = await supabase.from('site_settings').select('key, value')
  if (error) {
    toast.add({ title: 'Error', description: error.message, color: 'error' })
  } else {
    const m: Record<string, any> = {}
    for (const row of (data as any[]) ?? []) m[row.key] = row.value || {}
    for (const def of settingDefs) {
      if (!m[def.key]) m[def.key] = {}
    }
    values.value = m
  }
  loading.value = false
}

onMounted(fetchAll)

const updateField = (settingKey: string, path: string, value: any) => {
  if (!values.value[settingKey]) values.value[settingKey] = {}
  values.value[settingKey][path] = value
}

const saveSetting = async (def: SettingDef) => {
  savingKey.value = def.key
  const payload = values.value[def.key] || {}

  for (const f of def.fields) {
    if (f.type === 'json' && typeof payload[f.path] === 'string') {
      try {
        payload[f.path] = JSON.parse(payload[f.path])
      } catch {
        toast.add({ title: 'Invalid JSON', description: `Field "${f.label}" is not valid JSON.`, color: 'error' })
        savingKey.value = null
        return
      }
    }
  }

  const { error } = await (supabase as any)
    .from('site_settings')
    .upsert({ key: def.key, value: payload, updated_at: new Date().toISOString() }, { onConflict: 'key' })

  savingKey.value = null
  if (error) {
    toast.add({ title: 'Error', description: error.message, color: 'error' })
  } else {
    toast.add({ title: 'Saved', description: `${def.title} updated.`, color: 'success' })
    await fetchAll()
  }
}

const renderJsonValue = (v: any) => {
  if (typeof v === 'string') return v
  if (v == null) return ''
  try { return JSON.stringify(v, null, 2) } catch { return '' }
}
</script>

<template>
  <div class="space-y-6">
    <div v-if="loading" class="flex items-center justify-center py-16">
      <UIcon name="i-lucide-loader-2" class="h-8 w-8 animate-spin text-primary" />
    </div>

    <template v-else>
      <UCard v-for="def in settingDefs" :key="def.key">
        <template #header>
          <div class="flex flex-wrap items-center justify-between gap-3">
            <div>
              <h3 class="text-base font-semibold text-highlighted">
                {{ def.title }}
              </h3>
              <p class="text-xs text-muted">
                {{ def.description }}
              </p>
            </div>
            <UButton
              :loading="savingKey === def.key"
              icon="i-lucide-save"
              size="sm"
              color="primary"
              label="Save"
              @click="saveSetting(def)"
            />
          </div>
        </template>

        <div class="grid gap-4 sm:grid-cols-2">
          <UFormField
            v-for="f in def.fields"
            :key="f.path"
            :label="f.label"
            :hint="f.hint"
            :class="f.type === 'textarea' || f.type === 'json' ? 'sm:col-span-2' : ''"
          >
            <UInput
              v-if="f.type === 'text' || f.type === 'url'"
              :model-value="values[def.key]?.[f.path] ?? ''"
              class="w-full"
              @update:model-value="(v: string) => updateField(def.key, f.path, v)"
            />
            <UTextarea
              v-else-if="f.type === 'textarea'"
              :model-value="values[def.key]?.[f.path] ?? ''"
              :rows="3"
              class="w-full"
              @update:model-value="(v: string) => updateField(def.key, f.path, v)"
            />
            <UTextarea
              v-else-if="f.type === 'json'"
              :model-value="renderJsonValue(values[def.key]?.[f.path])"
              :rows="6"
              class="w-full font-mono text-xs"
              @update:model-value="(v: string) => updateField(def.key, f.path, v)"
            />
            <div v-else-if="f.type === 'image'" class="space-y-2">
              <UInput
                :model-value="values[def.key]?.[f.path] ?? ''"
                placeholder="https://… or upload below"
                class="w-full"
                @update:model-value="(v: string) => updateField(def.key, f.path, v)"
              />
              <div class="flex items-center gap-3">
                <label class="inline-flex cursor-pointer items-center gap-2 rounded-md border border-default px-3 py-1.5 text-sm hover:border-primary/60">
                  <UIcon name="i-lucide-upload" class="h-4 w-4" />
                  <span>{{ uploading[`${def.key}.${f.path}`] ? 'Uploading…' : 'Upload image' }}</span>
                  <input
                    type="file"
                    class="hidden"
                    :accept="f.accept || 'image/*'"
                    :disabled="uploading[`${def.key}.${f.path}`]"
                    @change="(e) => onFileChosen(e, def.key, f.path, f.maxMb || 5)"
                  >
                </label>
                <UButton
                  v-if="values[def.key]?.[f.path]"
                  size="xs"
                  color="neutral"
                  variant="ghost"
                  icon="i-lucide-x"
                  label="Clear"
                  @click="updateField(def.key, f.path, '')"
                />
              </div>
              <img
                v-if="values[def.key]?.[f.path]"
                :src="values[def.key][f.path]"
                alt=""
                class="mt-1 max-h-40 rounded border border-default object-contain"
              >
            </div>
            <div v-else-if="f.type === 'video'" class="space-y-2">
              <UInput
                :model-value="values[def.key]?.[f.path] ?? ''"
                placeholder="https://… or upload below"
                class="w-full"
                @update:model-value="(v: string) => updateField(def.key, f.path, v)"
              />
              <div class="flex items-center gap-3">
                <label class="inline-flex cursor-pointer items-center gap-2 rounded-md border border-default px-3 py-1.5 text-sm hover:border-primary/60">
                  <UIcon name="i-lucide-upload" class="h-4 w-4" />
                  <span>{{ uploading[`${def.key}.${f.path}`] ? 'Uploading…' : 'Upload video' }}</span>
                  <input
                    type="file"
                    class="hidden"
                    :accept="f.accept || 'video/*'"
                    :disabled="uploading[`${def.key}.${f.path}`]"
                    @change="(e) => onFileChosen(e, def.key, f.path, f.maxMb || 100)"
                  >
                </label>
                <UButton
                  v-if="values[def.key]?.[f.path]"
                  size="xs"
                  color="neutral"
                  variant="ghost"
                  icon="i-lucide-x"
                  label="Clear"
                  @click="updateField(def.key, f.path, '')"
                />
              </div>
              <video
                v-if="values[def.key]?.[f.path]"
                :src="values[def.key][f.path]"
                controls
                muted
                class="mt-1 max-h-48 w-full rounded border border-default bg-black object-contain"
              />
            </div>
          </UFormField>
        </div>
      </UCard>
    </template>
  </div>
</template>
