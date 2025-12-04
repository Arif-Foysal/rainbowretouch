<template>

<UPageHeader
title="Our Editing Services"
description="We streamline your visual workflow with pixel-perfect product editing, restoration, and retouching delivered at scale."
headline="Turn raw captures into commercial assets"

  />
    <UPageSection v-for="(section, index) in page.sections" :key="index" :title="section.title"
      :description="section.description" :orientation="section.orientation" :reverse="section.reverse"
      :features="section.features">
      <div class="relative overflow-hidden rounded-3xl shadow-xl ring-1 ring-default/40">
        <div class="aspect-[4/3] w-full">
          <NuxtImg
            :src="section.image || '/imagePoster/1.png'"
            :alt="section.title"
            class="w-full h-full object-cover"
            format="webp"
            quality="80"
            sizes="sm:100vw md:1000px"
          />
        </div>
      </div>
    </UPageSection>

</template>
<script setup>
const { data: page } = await useAsyncData('index', () => queryCollection('index').first())
</script>