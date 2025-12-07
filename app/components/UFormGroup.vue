<template>
  <div class="space-y-1">
    <label v-if="props.label" class="flex items-center gap-1 text-sm font-medium text-highlighted">
      <span>{{ props.label }}</span>
      <span v-if="props.required" class="text-error">*</span>
    </label>
    <slot />
    <p v-if="props.description" class="text-xs text-muted">{{ props.description }}</p>
  </div>
</template>

<script setup lang="ts">
const props = defineProps<{
  label?: string
  description?: string
  required?: boolean
}>()
</script>
