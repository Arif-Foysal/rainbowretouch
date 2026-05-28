<script setup lang="ts">
const route = useRoute()
const supabase = useSupabaseClient()
const slug = route.params.slug as string

const { data: post } = await useAsyncData(`blog-db:${slug}`, async () => {
  const { data } = await supabase
    .from('blog_posts')
    .select('*')
    .eq('slug', slug)
    .eq('is_published', true)
    .maybeSingle()
  return data as any
})

if (!post.value) {
  throw createError({ statusCode: 404, statusMessage: 'Post not found', fatal: true })
}

const title = computed(() => post.value?.title || 'Blog')
const description = computed(() => post.value?.excerpt || '')

useSeoMeta({ title, ogTitle: title, description, ogDescription: description })

if (post.value?.cover_image_url) {
  defineOgImage({ url: post.value.cover_image_url })
} else {
  defineOgImageComponent('Saas', { headline: 'Blog' })
}
</script>

<template>
  <UContainer v-if="post">
    <UPageHeader
      :title="title"
      :description="description"
    >
      <template #headline>
        <time v-if="post.published_at" class="text-muted">
          {{ new Date(post.published_at).toLocaleDateString('en', { year: 'numeric', month: 'short', day: 'numeric' }) }}
        </time>
      </template>

      <div v-if="post.author_name" class="flex flex-wrap items-center gap-3 mt-4">
        <UButton color="neutral" variant="subtle" size="sm">
          {{ post.author_name }}
        </UButton>
      </div>
    </UPageHeader>

    <UPage>
      <UPageBody>
        <div v-if="post.cover_image_url" class="mb-6 rounded-2xl overflow-hidden">
          <img :src="post.cover_image_url" :alt="post.title" class="w-full h-auto">
        </div>

        <div
          class="prose dark:prose-invert max-w-none"
          v-html="post.body || ''"
        />
      </UPageBody>
    </UPage>
  </UContainer>
</template>
