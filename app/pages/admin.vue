<script setup lang="ts">
definePageMeta({
  middleware: 'admin'
})

const supabase = useSupabaseClient()
const { profile, fetchProfile } = useUserProfile()
const toast = useToast()

const formatNumber = (value: number) => value.toLocaleString()
const formatCurrency = (value: number) => new Intl.NumberFormat('en-US', {
  style: 'currency',
  currency: 'USD',
  maximumFractionDigits: 0
}).format(value)

type AdminProfile = {
  id: string
  email: string
  full_name?: string | null
  avatar_url?: string | null
  role?: 'user' | 'admin' | null
  created_at?: string
}

type ContactAttachment = {
  url?: string | null
  name?: string | null
}

type ContactRequest = {
  id: string
  first_name: string
  last_name: string
  email: string
  phone?: string | null
  subject: string
  budget?: string | null
  deadline?: string | null
  message: string
  attachments: ContactAttachment[]
  created_at?: string | null
}

// Fetch profile on mount
onMounted(async () => {
  await fetchProfile()
})

// Fetch all users (admin only)
const users = ref<AdminProfile[]>([])
const loading = ref(true)
const contactLoading = ref(true)
const contactRequests = ref<ContactRequest[]>([])
const totalUsers = ref(0)
const activeProjects = ref(0)
const totalRevenue = ref(0)
const pendingOrders = ref(0)
const stats = computed(() => [
  {
    label: 'Total Users',
    value: formatNumber(totalUsers.value),
    icon: 'i-lucide-users'
  },
  {
    label: 'Active Projects',
    value: formatNumber(activeProjects.value),
    icon: 'i-lucide-folder'
  },
  {
    label: 'Total Revenue',
    value: formatCurrency(totalRevenue.value),
    icon: 'i-lucide-dollar-sign'
  },
  {
    label: 'Pending Orders',
    value: formatNumber(pendingOrders.value),
    icon: 'i-lucide-clock'
  }
])
const isAttachmentModalOpen = ref(false)
const selectedAttachment = ref<{
  url?: string | null
  name?: string | null
  requestId?: string
  contactName?: string
} | null>(null)

const fetchUsers = async () => {
  loading.value = true
  const { data, error } = await supabase
    .from('profiles')
    .select('*')
    .order('created_at', { ascending: false })

  if (error) {
    toast.add({
      title: 'Error',
      description: 'Failed to fetch users',
      color: 'error'
    })
  } else {
    users.value = (data ?? []) as AdminProfile[]
    totalUsers.value = users.value.length
  }
  loading.value = false
}

onMounted(() => {
  fetchUsers()
  fetchContactRequests()
})

const logout = async () => {
  await supabase.auth.signOut()
  navigateTo('/login')
}

const openAttachmentModal = (attachment: ContactAttachment, request: ContactRequest) => {
  selectedAttachment.value = {
    ...attachment,
    requestId: request.id,
    contactName: `${request.first_name} ${request.last_name}`.trim()
  }
  isAttachmentModalOpen.value = true
}

const closeAttachmentModal = () => {
  isAttachmentModalOpen.value = false
  selectedAttachment.value = null
}

const downloadSelectedAttachment = () => {
  const attachment = selectedAttachment.value
  if (!attachment?.url) return

  const link = document.createElement('a')
  link.href = attachment.url
  link.setAttribute('download', attachment.name || 'attachment')
  link.setAttribute('target', '_blank')
  document.body.appendChild(link)
  link.click()
  document.body.removeChild(link)
}

const extractBudgetValue = (budget?: string | null) => {
  if (!budget) return 0
  const matches = budget.match(/[\d,.]+/g)
  if (!matches?.length) return 0
  const numbers = matches
    .map(num => Number(num.replace(/,/g, '')))
    .filter(value => !Number.isNaN(value))

  if (!numbers.length) return 0
  const [first = 0, second = first] = numbers
  if (numbers.length >= 2) {
    return (first + second) / 2
  }
  return first
}

const fetchContactRequests = async () => {
  contactLoading.value = true
  const { data, error } = await supabase
    .from('contact_requests')
    .select('*')
    .order('created_at', { ascending: false })

  if (error) {
    toast.add({
      title: 'Error',
      description: 'Failed to fetch contact requests',
      color: 'error'
    })
    contactRequests.value = []
  } else {
    const mappedRequests = (data ?? []).map((request: any) => {
      const attachmentsArray = Array.isArray(request.attachments)
        ? request.attachments
        : request.attachments
          ? [request.attachments]
          : []

      const attachments = attachmentsArray.map((attachment: any, index: number) => {
        if (typeof attachment === 'string') {
          return { url: attachment, name: `Attachment ${index + 1}` }
        }
        return {
          url: attachment?.url || attachment?.path || null,
          name: attachment?.name || attachment?.filename || `Attachment ${index + 1}`
        }
      })

      return {
        ...request,
        attachments
      } as ContactRequest
    })

    contactRequests.value = mappedRequests

    const now = new Date()
    activeProjects.value = mappedRequests.filter((request) => {
      if (!request.deadline) return true
      const deadlineDate = new Date(request.deadline)
      return deadlineDate >= now
    }).length

    pendingOrders.value = mappedRequests.filter((request) => !request.deadline).length

    totalRevenue.value = mappedRequests.reduce((sum, request) => {
      return sum + extractBudgetValue(request.budget)
    }, 0)
  }

  contactLoading.value = false
}
</script>

<template>
  <div class="min-h-screen bg-background">
    <UContainer class="py-8">
      <!-- Header -->
      <div class="flex items-center justify-between mb-8">
        <div>
          <h1 class="text-4xl font-bold text-highlighted">Admin Dashboard</h1>
          <p class="text-muted mt-2">Welcome back, {{ profile?.email }}</p>
        </div>
        <UButton
          label="Logout"
          color="neutral"
          variant="outline"
          icon="i-lucide-log-out"
          @click="logout"
        />
      </div>

      <!-- Stats Grid -->
      <UPageGrid class="gap-4 mb-8">
        <UCard v-for="stat in stats" :key="stat.label" class="p-6">
          <div class="flex items-center justify-between">
            <div>
              <p class="text-sm text-muted">{{ stat.label }}</p>
              <p class="text-3xl font-bold text-highlighted mt-1">{{ stat.value }}</p>
            </div>
            <UIcon :name="stat.icon" class="w-8 h-8 text-primary" />
          </div>
        </UCard>
      </UPageGrid>

      <!-- Users Table -->
      <UCard>
        <template #header>
          <div class="flex items-center justify-between">
            <h2 class="text-2xl font-bold text-highlighted">All Users</h2>
            <UBadge :label="`${users.length} users`" color="primary" />
          </div>
        </template>

        <div v-if="loading" class="flex items-center justify-center py-12">
          <UIcon name="i-lucide-loader-2" class="w-8 h-8 animate-spin text-primary" />
        </div>

        <div v-else class="divide-y divide-default">
          <div
            v-for="userItem in users"
            :key="userItem.id"
            class="py-4 flex items-center justify-between"
          >
            <div class="flex items-center gap-4">
              <UAvatar
                :src="userItem.avatar_url || undefined"
                :alt="userItem.full_name || userItem.email || 'User avatar'"
                size="md"
              />
              <div>
                <p class="font-semibold text-highlighted">
                  {{ userItem.full_name || 'No name' }}
                </p>
                <p class="text-sm text-muted">{{ userItem.email || 'No email' }}</p>
              </div>
            </div>
            <div class="flex items-center gap-3">
              <UBadge
                :label="userItem.role || 'user'"
                :color="userItem.role === 'admin' ? 'primary' : 'neutral'"
              />
              <p class="text-xs text-muted">
                Joined {{ userItem.created_at ? new Date(userItem.created_at).toLocaleDateString() : 'N/A' }}
              </p>
            </div>
          </div>
        </div>
      </UCard>

      <!-- Contact Requests -->
      <UCard class="mt-10">
        <template #header>
          <div class="flex items-center justify-between">
            <div>
              <h2 class="text-2xl font-bold text-highlighted">Contact Requests</h2>
              <p class="text-sm text-muted">Latest inquiries from the contact form</p>
            </div>
            <UBadge :label="`${contactRequests.length} requests`" color="neutral" />
          </div>
        </template>

        <div v-if="contactLoading" class="flex items-center justify-center py-12">
          <UIcon name="i-lucide-loader-2" class="w-8 h-8 animate-spin text-primary" />
        </div>

        <div v-else>
          <UEmpty
            v-if="!contactRequests.length"
            icon="i-lucide-inbox"
            title="No contact requests yet"
            description="New requests will appear here as soon as clients reach out."
          />

          <div v-else class="space-y-6">
            <div
              v-for="request in contactRequests"
              :key="request.id"
              class="border border-default rounded-2xl p-5 hover:border-primary/40 transition-colors"
            >
              <div class="flex flex-wrap items-start justify-between gap-4">
                <div>
                  <p class="text-sm text-muted uppercase tracking-wide">Contact</p>
                  <h3 class="text-xl font-semibold text-highlighted">
                    {{ request.first_name }} {{ request.last_name }}
                  </h3>
                  <div class="flex flex-wrap gap-3 text-sm text-muted mt-2">
                    <span class="flex items-center gap-2">
                      <UIcon name="i-lucide-mail" class="w-4 h-4" />
                      {{ request.email }}
                    </span>
                    <span
                      v-if="request.phone"
                      class="flex items-center gap-2"
                    >
                      <UIcon name="i-lucide-phone" class="w-4 h-4" />
                      {{ request.phone }}
                    </span>
                  </div>
                </div>

                <div class="text-right">
                  <p class="text-sm text-muted">Received</p>
                  <p class="text-lg font-semibold text-highlighted">
                    {{ new Date(request.created_at || '').toLocaleDateString() }}
                  </p>
                </div>
              </div>

              <div class="mt-4 grid gap-4 sm:grid-cols-2">
                <div>
                  <p class="text-sm text-muted uppercase tracking-wide">Subject</p>
                  <p class="text-lg font-medium text-highlighted">{{ request.subject }}</p>
                </div>
                <div class="flex gap-6 text-sm">
                  <div>
                    <p class="text-muted uppercase tracking-wide text-xs">Budget</p>
                    <p class="text-highlighted font-medium">{{ request.budget || 'Not specified' }}</p>
                  </div>
                  <div>
                    <p class="text-muted uppercase tracking-wide text-xs">Deadline</p>
                    <p class="text-highlighted font-medium">
                      {{ request.deadline ? new Date(request.deadline).toLocaleDateString() : 'Flexible' }}
                    </p>
                  </div>
                </div>
              </div>

              <div class="mt-4">
                <p class="text-sm text-muted uppercase tracking-wide mb-2">Message</p>
                <p class="text-base leading-relaxed text-default">
                  {{ request.message }}
                </p>
              </div>

              <div v-if="request.attachments.length" class="mt-5">
                <p class="text-sm text-muted uppercase tracking-wide mb-3">Attachments</p>
                <div class="flex flex-wrap gap-4">
                  <button
                    v-for="(attachment, index) in request.attachments"
                    :key="`${request.id}-attachment-${index}`"
                    type="button"
                    class="w-70 h-60 rounded-xl overflow-hidden border border-default bg-muted/30 flex flex-col focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary transition hover:shadow-lg"
                    @click="openAttachmentModal(attachment, request)"
                  >
                    <img
                      v-if="attachment.url"
                      :src="attachment.url"
                      :alt="attachment.name || `Attachment ${index + 1}`"
                      class="w-full h-full object-cover"
                    />
                    <div v-else class="flex-1 flex items-center justify-center text-xs text-muted px-2 text-center">
                      No preview
                    </div>
                    <div class="p-1 text-lg text-center text-muted bg-background/80">
                      {{ attachment.name || `Attachment ${index + 1}` }}
                    </div>
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </UCard>
    </UContainer>

    <UModal
      v-model:open="isAttachmentModalOpen"
      :ui="{ content: 'max-w-4xl' }"
      :close="true"
    >
      <template #header>
        <div class="flex items-center justify-between w-full">
          <div>
            <p class="text-sm text-muted">Attachment</p>
            <p class="text-lg font-semibold text-highlighted">
              {{ selectedAttachment?.name || 'Preview' }}
            </p>
            <p class="text-xs text-muted">
              {{ selectedAttachment?.contactName }}
            </p>
          </div>
          <UButton
            v-if="selectedAttachment?.url"
            label="Download"
            icon="i-lucide-download"
            color="neutral"
            variant="outline"
            @click="downloadSelectedAttachment"
          />
        </div>
      </template>

      <template #body>
        <div class="p-4">
          <img
            v-if="selectedAttachment?.url"
            :src="selectedAttachment.url"
            :alt="selectedAttachment?.name || 'Attachment preview'"
            class="w-full h-auto rounded-xl"
          />
          <div v-else class="flex items-center justify-center h-64 text-muted">
            No preview available
          </div>
        </div>
      </template>

      <template #footer>
        <div class="flex justify-end gap-3">
          <UButton
            label="Close"
            color="neutral"
            variant="ghost"
            @click="closeAttachmentModal"
          />
          <UButton
            v-if="selectedAttachment?.url"
            label="Download"
            icon="i-lucide-download"
            color="primary"
            @click="downloadSelectedAttachment"
          />
        </div>
      </template>
    </UModal>
  </div>
</template>