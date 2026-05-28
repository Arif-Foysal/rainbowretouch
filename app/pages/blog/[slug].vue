<script setup lang="ts">
const route = useRoute()
const supabase = useSupabaseClient()
const slug = route.params.slug as string

const { data: dbPost } = await useAsyncData(`blog-db:${slug}`, async () => {
  const { data } = await supabase
    .from('blog_posts')
    .select('*')
    .eq('slug', slug)
    .eq('is_published', true)
    .maybeSingle()
  return data as any
})

const { data: mdPost } = await useAsyncData(`blog-md:${route.path}`, () =>
  queryCollection('posts').path(route.path).first()
)

const { data: surround } = await useAsyncData(`${route.path}-surround`, () =>
  queryCollectionItemSurroundings('posts', route.path, { fields: ['description'] })
)

if (!dbPost.value && !mdPost.value) {
  throw createError({ statusCode: 404, statusMessage: 'Post not found', fatal: true })
}

const post = computed(() => dbPost.value || mdPost.value)
const isDbPost = computed(() => !!dbPost.value)

const title = computed(() => (post.value as any)?.title || 'Blog')
const description = computed(() => (post.value as any)?.excerpt || (post.value as any)?.description || '')

useSeoMeta({ title, ogTitle: title, description, ogDescription: description })

if (isDbPost.value && dbPost.value?.cover_image_url) {
  defineOgImage({ url: dbPost.value.cover_image_url })
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
        <time v-if="(post as any).published_at || (post as any).date" class="text-muted">
          {{ new Date((post as any).published_at || (post as any).date).toLocaleDateString('en', { year: 'numeric', month: 'short', day: 'numeric' }) }}
        </time>
      </template>

      <div v-if="(post as any).author_name" class="flex flex-wrap items-center gap-3 mt-4">
        <UButton color="neutral" variant="subtle" size="sm">
          {{ (post as any).author_name }}
        </UButton>
      </div>
    </UPageHeader>

    <UPage>
      <UPageBody>
        <div v-if="isDbPost && (dbPost as any)?.cover_image_url" class="mb-6 rounded-2xl overflow-hidden">
          <img :src="(dbPost as any).cover_image_url" :alt="(dbPost as any).title" class="w-full h-auto">
        </div>

        <div
          v-if="isDbPost"
          class="prose dark:prose-invert max-w-none"
          v-html="(dbPost as any)?.body || ''"
        />
        <ContentRenderer
          v-else-if="mdPost"
          :value="mdPost"
        />

        <USeparator v-if="!isDbPost && surround?.length" />
        <UContentSurround v-if="!isDbPost" :surround="surround" />
      </UPageBody>
    </UPage>
  </UContainer>
</template>
