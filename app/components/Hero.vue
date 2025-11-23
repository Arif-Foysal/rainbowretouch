<template>
    <div>
        
        <!-- <HeroBackground/> -->
    <UPageHero
    headline="Rainbow Retouch"
    title="Transforming Ideas Into Visual Masterpieces"
    description="We create stunning visual experiences that captivate audiences and elevate brands. From branding to digital design, we bring your creative vision to life with precision and artistry."
    orientation="horizontal"
    :links="[
      {
        label: 'View Our Work',
        color: 'primary',
        size: 'xl',
        to: '/portfolio'
      },
      {
        label: 'Get in Touch',
        variant: 'outline',
        size: 'xl',
        to: '/contact',
        trailingIcon: 'i-heroicons-arrow-right-20-solid'
      }
    ]"
    :ui="{
      root: 'relative isolate overflow-hidden ',
      container: 'min-h-[600px] lg:min-h-[700px]'
    }"
  >
  
    <template #title>
      <h1 class="">Transforming Ideas Into Visual Masterpieces</h1>
    </template>
    <template #description>
      <p class="mt-4 text-lg">We create stunning visual experiences that captivate audiences and elevate brands. From branding to digital design, we bring your creative vision to life with precision and artistry.</p>
    </template>
    <template #default>
      <!-- Background Image with Overlay -->
      <div class="absolute inset-0 -z-10">
        <img
          src="https://images.unsplash.com/photo-1561070791-2526d30994b5?q=80&w=2064"
          alt="Creative workspace"
          class="w-full h-full object-cover opacity-30"
        />
        <!-- <div class="absolute inset-0 bg-gradient-to-r from-primary/50 via-purple-900/80 to-transparent"></div> -->
      </div>

      <!-- <HeroBackground /> -->
      <!-- Decorative Elements -->
      <div class="absolute inset-0 -z-10 overflow-hidden">
        <div class="absolute -top-40 -right-40 w-80 h-80 bg-purple-500/20 rounded-full blur-3xl"></div>
        <div class="absolute -bottom-40 -left-40 w-80 h-80 bg-blue-500/20 rounded-full blur-3xl"></div>
      </div>

      <!-- Hero Image/Illustration -->
      <div class="relative">
        <img
          src="https://images.unsplash.com/photo-1626785774573-4b799315345d?q=80&w=2071"
          alt="Design showcase"
          class="rounded-2xl shadow-2xl ring-1 ring-white/10 hover:ring-white/20 transition-all duration-300"
        />
        <!-- Floating Badge -->
        <div class="absolute -bottom-6 -left-6 bg-white dark:bg-gray-800 rounded-xl shadow-xl p-4 flex items-center gap-3">
          <div class="w-12 h-12 bg-gradient-to-br from-purple-500 to-pink-500 rounded-lg flex items-center justify-center">
            <UIcon name="i-heroicons-sparkles" class="w-6 h-6 text-white" />
          </div>
          <div>
            <div class="font-bold text-gray-900 dark:text-white">500+</div>
            <div class="text-sm text-gray-600 dark:text-gray-400">Projects Completed</div>
          </div>
        </div>
      </div>
    </template>
  </UPageHero>
  <!-- <HeroBackground/> -->
   <StarsBg/>
     </div>
</template>
