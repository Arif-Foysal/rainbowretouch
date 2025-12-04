<script setup lang="ts">
import type { PropType } from 'vue'

const props = defineProps({
	headline: { type: String, default: 'How We Work' },
	title: { type: String, default: 'Our Design Process' },
	description: { type: String, default: 'A proven methodology that ensures outstanding results every time.' },
	orientation: { type: String as PropType<'vertical' | 'horizontal'>, default: 'vertical' },
	items: {
		type: Array as PropType<Array<{ title: string; description: string; icon?: string }>>,
		default: () => [
			{ title: '1. Discovery', description: 'Understanding your brand, goals, and target audience through in-depth research.', icon: 'i-lucide-lightbulb' },
			{ title: '2. Concept', description: 'Developing creative concepts and visual directions tailored to your needs.', icon: 'i-lucide-pencil-ruler' },
			{ title: '3. Design', description: 'Bringing concepts to life with meticulous attention to detail and craftsmanship.', icon: 'i-lucide-palette' },
			{ title: '4. Delivery', description: 'Finalizing and delivering polished designs ready to make an impact.', icon: 'i-lucide-check-circle' }
		]
	}
})
</script>

<template>
	<UPageSection
        v-motion-slide-visible-bottom
		:headline="props.headline"
		:title="props.title"
		:description="props.description"
		:orientation="props.orientation"
	>
		<div class="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
			<UCard v-for="(item, i) in props.items" :key="i" variant="soft">
				<div class="space-y-3">
					<div class="flex items-center justify-center w-12 h-12 rounded-full bg-primary/10">
						<UIcon :name="item.icon || 'i-lucide-star'" class="w-6 h-6 text-primary" />
					</div>
					<h3 class="text-2xl font-bold">{{ item.title }}</h3>
					<p class="text-sm text-muted">{{ item.description }}</p>
				</div>
			</UCard>
		</div>

		<!-- Optional CTA slot -->
		<!-- <div class="mt-6">
			<slot name="cta" />
		</div> -->
	</UPageSection>
</template>
