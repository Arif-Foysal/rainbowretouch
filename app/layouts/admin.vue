<template>
  <div>
    <AppHeader />
    <div class="border-t border-gray-200 dark:border-gray-800">
      <div class="container mx-auto px-4 py-8">
        <slot />
      </div>
    </div>
    <AppFooter />
  </div>
</template>
