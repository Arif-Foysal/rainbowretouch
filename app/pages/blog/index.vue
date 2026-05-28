<script setup lang="ts">
const route = useRoute()

const { data: dbPosts } = await useBlogPosts()
const { data: page } = await useAsyncData('blog', () => queryCollection('blog').first())
const { data: mdPosts } = await useAsyncData(route.path, () => queryCollection('posts').all())

const title = page.value?.seo?.title || page.value?.title || 'Blog'
const description = page.value?.seo?.description || page.value?.description || 'News, tips, and case studies.'

useSeoMeta({ title, ogTitle: title, description, ogDescription: description })
defineOgImageComponent('Saas')

const posts = computed<any[]>(() => {
  if (dbPosts.value?.length) {
    return dbPosts.value.map((p: any) => ({
      path: `/blog/${p.slug}`,
      title: p.title,
      description: p.excerpt,
      image: p.cover_image_url,
      date: p.published_at || p.created_at,
      authors: p.author_name ? [{ name: p.author_name }] : [],
      badge: undefined
    }))
  }
  return (mdPosts.value || []).map((p: any) => ({
    path: p.path,
    title: p.title,
    description: p.description,
    image: p.image,
    date: p.date,
    authors: p.authors,
    badge: p.badge
  }))
})
</script>

<template>
  <UContainer>
    <UPageHeader
      :title="title"
      :description="description"
      class="py-10 sm:py-[50px]"
    />

    <UPageBody>
      <UEmpty
        v-if="!posts.length"
        icon="i-lucide-book-open"
        title="No blog posts yet"
        description="Posts will appear here once published from admin."
      />
      <UBlogPosts v-else>
        <UBlogPost
          v-for="(post, index) in posts"
          :key="index"
          :to="post.path"
          :title="post.title"
          :description="post.description"
          :image="post.image"
          :date="post.date ? new Date(post.date).toLocaleDateString('en', { year: 'numeric', month: 'short', day: 'numeric' }) : undefined"
          :authors="post.authors"
          :badge="post.badge"
          :orientation="index === 0 ? 'horizontal' : 'vertical'"
          :class="[index === 0 && 'col-span-full']"
          variant="naked"
          :ui="{ description: 'line-clamp-2' }"
        />
      </UBlogPosts>
    </UPageBody>
  </UContainer>
</template>
