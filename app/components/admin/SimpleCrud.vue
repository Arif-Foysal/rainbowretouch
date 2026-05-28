<script setup lang="ts">
type FieldType = 'text' | 'textarea' | 'number' | 'boolean' | 'image' | 'json-array' | 'select'

type Field = {
  key: string
  label: string
  type: FieldType
  required?: boolean
  placeholder?: string
  options?: Array<{ label: string, value: string }>
  storageBucket?: string
  hint?: string
}

const props = defineProps<{
  table: string
  title: string
  itemLabel: string
  fields: Field[]
  searchField?: string
  orderBy?: { column: string, ascending?: boolean }
  imageField?: string
}>()

const supabase = useSupabaseClient()
const toast = useToast()

const rows = ref<any[]>([])
const loading = ref(true)
const search = ref('')

const isModalOpen = ref(false)
const isDeleting = ref(false)
const isSaving = ref(false)
const mode = ref<'create' | 'edit'>('create')
const form = ref<Record<string, any>>({})
const uploadFiles = ref<File[]>([])

const fetchRows = async () => {
  loading.value = true
  const order = props.orderBy || { column: 'order_index', ascending: true }
  const { data, error } = await supabase
    .from(props.table)
    .select('*')
    .order(order.column, { ascending: order.ascending !== false })
  if (error) {
    toast.add({ title: 'Error', description: error.message, color: 'error' })
    rows.value = []
  } else {
    rows.value = (data as any[]) ?? []
  }
  loading.value = false
}

onMounted(fetchRows)
watch(() => props.table, fetchRows)

const filtered = computed(() => {
  const q = search.value.trim().toLowerCase()
  if (!q) return rows.value
  const sf = props.searchField || props.fields.find(f => f.type === 'text')?.key || 'title'
  return rows.value.filter(r => {
    return props.fields.some(f => {
      if (f.type === 'image' || f.type === 'boolean' || f.type === 'json-array') return false
      const v = r[f.key]
      return v != null && String(v).toLowerCase().includes(q)
    })
  })
})

const resetForm = () => {
  const blank: Record<string, any> = {}
  for (const f of props.fields) {
    if (f.type === 'boolean') blank[f.key] = false
    else if (f.type === 'json-array') blank[f.key] = []
    else if (f.type === 'number') blank[f.key] = 0
    else blank[f.key] = ''
  }
  if (!('order_index' in blank) && props.fields.some(f => f.key === 'order_index')) {
    blank.order_index = (rows.value.length || 0) + 1
  }
  if ('is_active' in blank) blank.is_active = true
  form.value = blank
  uploadFiles.value = []
}

const openCreate = () => {
  resetForm()
  if ('order_index' in form.value) form.value.order_index = (rows.value.length || 0) + 1
  mode.value = 'create'
  isModalOpen.value = true
}

const openEdit = (row: any) => {
  const v: Record<string, any> = {}
  for (const f of props.fields) {
    if (f.type === 'json-array') {
      v[f.key] = Array.isArray(row[f.key]) ? [...row[f.key]] : []
    } else {
      v[f.key] = row[f.key] ?? (f.type === 'boolean' ? false : '')
    }
  }
  v.id = row.id
  form.value = v
  uploadFiles.value = []
  mode.value = 'edit'
  isModalOpen.value = true
}

const handleImageUpload = async (field: Field): Promise<string | null> => {
  const file = uploadFiles.value[0]
  if (!file) return form.value[field.key] || null
  const bucket = field.storageBucket || 'site-content'
  const path = `${props.table}/${Date.now()}-${file.name}`
  const { error: upErr } = await supabase.storage.from(bucket).upload(path, file, { cacheControl: '3600', upsert: false })
  if (upErr) throw upErr
  const { data: pub } = supabase.storage.from(bucket).getPublicUrl(path)
  return pub.publicUrl
}

const save = async () => {
  for (const f of props.fields) {
    if (f.required && !form.value[f.key] && f.type !== 'image') {
      toast.add({ title: 'Validation', description: `${f.label} is required.`, color: 'error' })
      return
    }
  }

  isSaving.value = true
  try {
    const payload: Record<string, any> = {}
    for (const f of props.fields) {
      let v = form.value[f.key]
      if (f.type === 'image') {
        try {
          v = await handleImageUpload(f)
        } catch (e: any) {
          throw new Error(`Image upload failed: ${e.message || e}`)
        }
      }
      if (f.type === 'number') v = Number(v) || 0
      if (f.type === 'boolean') v = !!v
      if (f.type === 'json-array' && typeof v === 'string') {
        v = (v as string).split('\n').map(s => s.trim()).filter(Boolean)
      }
      if (f.type !== 'image' || v) payload[f.key] = v ?? null
    }

    let error
    if (mode.value === 'create') {
      ({ error } = await (supabase as any).from(props.table).insert(payload))
    } else {
      ({ error } = await (supabase as any).from(props.table).update(payload).eq('id', form.value.id))
    }
    if (error) throw error

    toast.add({
      title: mode.value === 'create' ? `${props.itemLabel} created` : `${props.itemLabel} updated`,
      color: 'success'
    })
    isModalOpen.value = false
    await fetchRows()
  } catch (e: any) {
    toast.add({ title: 'Error', description: e.message || 'Save failed', color: 'error' })
  } finally {
    isSaving.value = false
  }
}

const remove = async (row: any) => {
  if (!confirm(`Delete this ${props.itemLabel.toLowerCase()}?`)) return
  isDeleting.value = true
  const { error } = await supabase.from(props.table).delete().eq('id', row.id)
  isDeleting.value = false
  if (error) {
    toast.add({ title: 'Error', description: error.message, color: 'error' })
  } else {
    toast.add({ title: `${props.itemLabel} deleted`, color: 'success' })
    await fetchRows()
  }
}

const displayPrimary = (row: any) => {
  const titleField = props.fields.find(f => ['title', 'label', 'name', 'question', 'quote'].includes(f.key))
  if (titleField) return row[titleField.key] || '(untitled)'
  const first = props.fields.find(f => f.type === 'text')
  return first ? row[first.key] : '(item)'
}

const displaySecondary = (row: any) => {
  for (const k of ['description', 'excerpt', 'answer', 'role', 'author_name']) {
    if (row[k]) return row[k]
  }
  return ''
}
</script>

<template>
  <UCard>
    <template #header>
      <div class="flex flex-wrap items-center justify-between gap-3">
        <div class="flex items-center gap-3">
          <h3 class="text-base font-semibold text-highlighted">
            {{ title }}
          </h3>
          <UBadge :label="`${rows.length}`" color="primary" variant="subtle" />
        </div>
        <div class="flex flex-wrap items-center gap-2">
          <UInput
            v-model="search"
            icon="i-lucide-search"
            placeholder="Search…"
            class="w-full sm:w-64"
            size="sm"
          />
          <UButton size="sm" icon="i-lucide-plus" color="primary" :label="`Add ${itemLabel}`" @click="openCreate" />
        </div>
      </div>
    </template>

    <div v-if="loading" class="flex items-center justify-center py-12">
      <UIcon name="i-lucide-loader-2" class="h-8 w-8 animate-spin text-primary" />
    </div>
    <UEmpty
      v-else-if="!filtered.length"
      icon="i-lucide-inbox"
      title="No items"
      :description="`Click 'Add ${itemLabel}' to create one.`"
    />
    <ul v-else class="divide-y divide-default">
      <li
        v-for="row in filtered"
        :key="row.id"
        class="flex items-start gap-3 py-3 sm:py-4"
      >
        <div
          v-if="imageField && row[imageField]"
          class="hidden sm:block h-14 w-14 shrink-0 overflow-hidden rounded-lg bg-muted/50"
        >
          <img :src="row[imageField]" alt="" class="h-full w-full object-cover">
        </div>
        <div class="min-w-0 flex-1">
          <p class="font-medium text-highlighted line-clamp-1">
            {{ displayPrimary(row) }}
          </p>
          <p class="text-xs sm:text-sm text-muted line-clamp-2">
            {{ displaySecondary(row) }}
          </p>
          <div class="mt-1 flex flex-wrap items-center gap-2">
            <UBadge
              v-if="'is_active' in row"
              :label="row.is_active ? 'Active' : 'Hidden'"
              :color="row.is_active ? 'success' : 'neutral'"
              variant="subtle"
              size="xs"
            />
            <UBadge
              v-if="'is_published' in row"
              :label="row.is_published ? 'Published' : 'Draft'"
              :color="row.is_published ? 'success' : 'neutral'"
              variant="subtle"
              size="xs"
            />
            <UBadge
              v-if="'order_index' in row"
              :label="`#${row.order_index}`"
              color="neutral"
              variant="subtle"
              size="xs"
            />
          </div>
        </div>
        <div class="flex shrink-0 items-center gap-1">
          <UButton size="xs" icon="i-lucide-pencil" variant="ghost" color="neutral" @click="openEdit(row)" />
          <UButton size="xs" icon="i-lucide-trash" variant="ghost" color="error" :loading="isDeleting" @click="remove(row)" />
        </div>
      </li>
    </ul>
  </UCard>

  <UModal v-model:open="isModalOpen" :ui="{ content: 'sm:max-w-2xl' }">
    <template #content>
      <UCard>
        <template #header>
          <h3 class="text-base font-semibold">
            {{ mode === 'create' ? `Create ${itemLabel}` : `Edit ${itemLabel}` }}
          </h3>
        </template>

        <div class="space-y-4 max-h-[70vh] overflow-y-auto pr-1">
          <UFormField v-for="f in fields" :key="f.key" :label="f.label" :hint="f.hint" :required="f.required">
            <UInput
              v-if="f.type === 'text'"
              v-model="form[f.key]"
              :placeholder="f.placeholder"
              class="w-full"
            />
            <UInput
              v-else-if="f.type === 'number'"
              v-model.number="form[f.key]"
              type="number"
              class="w-full"
            />
            <UTextarea
              v-else-if="f.type === 'textarea'"
              v-model="form[f.key]"
              :placeholder="f.placeholder"
              :rows="5"
              class="w-full"
            />
            <USelectMenu
              v-else-if="f.type === 'select'"
              v-model="form[f.key]"
              :items="f.options || []"
              value-key="value"
              class="w-full"
            />
            <UCheckbox
              v-else-if="f.type === 'boolean'"
              v-model="form[f.key]"
              :label="f.label"
            />
            <div v-else-if="f.type === 'image'" class="space-y-2">
              <UInput v-model="form[f.key]" placeholder="https://…" class="w-full" />
              <UFileUpload
                v-model="uploadFiles"
                color="neutral"
                highlight
                label="Or upload an image"
                description="PNG, JPG, WEBP, GIF — max 5 MB"
                class="w-full min-h-32"
                accept="image/*"
                :max-file-size="5 * 1024 * 1024"
              />
              <img v-if="form[f.key] && !uploadFiles.length" :src="form[f.key]" alt="" class="max-h-32 rounded">
            </div>
            <UTextarea
              v-else-if="f.type === 'json-array'"
              :model-value="Array.isArray(form[f.key]) ? form[f.key].join('\n') : form[f.key]"
              :rows="6"
              placeholder="One item per line"
              class="w-full"
              @update:model-value="(v: string) => form[f.key] = v.split('\n').map(s => s.trim()).filter(Boolean)"
            />
          </UFormField>
        </div>

        <template #footer>
          <div class="flex justify-end gap-2">
            <UButton color="neutral" variant="ghost" label="Cancel" @click="isModalOpen = false" />
            <UButton color="primary" :loading="isSaving" :label="mode === 'create' ? 'Create' : 'Save changes'" @click="save" />
          </div>
        </template>
      </UCard>
    </template>
  </UModal>
</template>
