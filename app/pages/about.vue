<template>
  <UApp>
    <!-- Hero Section -->
     <div v-motion-pop-visible>

     
    <UPageHero
      headline="About Us"
      title="Creative Minds. Stunning Designs."
      description="We're a team of passionate graphic designers transforming ideas into visual masterpieces. With over 10 years of experience, we bring brands to life through innovative design solutions that captivate and inspire."
      :links="[
        { label: 'Get in Touch', color: 'primary', size: 'xl', to: '/contact' },
        { label: 'View Portfolio', color: 'neutral', variant: 'outline', size: 'xl', to: '/' }
      ]"
      orientation="horizontal"
    >
      <UCard variant="subtle" class="rounded-2xl overflow-hidden">
        <img 
          src="https://images.unsplash.com/photo-1522542550221-31fd19575a2d?w=800&h=600&fit=crop" 
          alt="Design team collaboration" 
          class="w-full h-auto rounded-xl"
        />
      </UCard>
    </UPageHero>
</div>
    <!-- Our Values Section -->
    <UPageSection
      headline="Our Values"
      title="Design That Speaks"
      description="We believe in creating designs that not only look beautiful but tell a compelling story. Every project is a collaboration, every challenge an opportunity to innovate."
      orientation="vertical"
      :features="[
        {
          title: 'Creative Excellence',
          description: 'Pushing boundaries and exploring new design horizons with every project we undertake.',
          icon: 'i-lucide-sparkles'
        },
        {
          title: 'Client-Focused',
          description: 'Your vision is our mission. We listen, collaborate, and deliver beyond expectations.',
          icon: 'i-lucide-heart'
        },
        {
          title: 'Innovation First',
          description: 'Staying ahead of trends while creating timeless designs that stand the test of time.',
          icon: 'i-lucide-rocket'
        }
      ]"
    />

    <!-- Team Section -->
    <UPageSection
      headline="The Team"
      title="Meet Our Creative Wizards"
      description="A diverse team of talented designers, each bringing unique perspectives and expertise to create exceptional work."
      orientation="vertical"
    >
      <UPageGrid>
        <UCard variant="outline" class="text-center">
          <div class="flex flex-col items-center space-y-4">
            <UAvatar 
              src="https://i.pravatar.cc/150?img=1" 
              alt="Sarah Johnson" 
              size="3xl"
            />
            <div>
              <h3 class="text-xl font-bold text-highlighted">Sarah Johnson</h3>
              <p class="text-muted">Creative Director</p>
            </div>
            <p class="text-sm text-muted">15+ years crafting brand identities for Fortune 500 companies.</p>
          </div>
        </UCard>

        <UCard variant="outline" class="text-center">
          <div class="flex flex-col items-center space-y-4">
            <UAvatar 
              src="https://i.pravatar.cc/150?img=5" 
              alt="Marcus Chen" 
              size="3xl"
            />
            <div>
              <h3 class="text-xl font-bold text-highlighted">Marcus Chen</h3>
              <p class="text-muted">Lead Designer</p>
            </div>
            <p class="text-sm text-muted">Award-winning designer specializing in minimalist and modern aesthetics.</p>
          </div>
        </UCard>

        <UCard variant="outline" class="text-center">
          <div class="flex flex-col items-center space-y-4">
            <UAvatar 
              src="https://i.pravatar.cc/150?img=9" 
              alt="Emily Rodriguez" 
              size="3xl"
            />
            <div>
              <h3 class="text-xl font-bold text-highlighted">Emily Rodriguez</h3>
              <p class="text-muted">UI/UX Designer</p>
            </div>
            <p class="text-sm text-muted">Creating seamless digital experiences that users love.</p>
          </div>
        </UCard>

        <UCard variant="outline" class="text-center">
          <div class="flex flex-col items-center space-y-4">
            <UAvatar 
              src="https://i.pravatar.cc/150?img=12" 
              alt="James Thompson" 
              size="3xl"
            />
            <div>
              <h3 class="text-xl font-bold text-highlighted">James Thompson</h3>
              <p class="text-muted">Motion Designer</p>
            </div>
            <p class="text-sm text-muted">Bringing static designs to life with stunning animations.</p>
          </div>
        </UCard>

        <UCard variant="outline" class="text-center">
          <div class="flex flex-col items-center space-y-4">
            <UAvatar 
              src="https://i.pravatar.cc/150?img=20" 
              alt="Aisha Patel" 
              size="3xl"
            />
            <div>
              <h3 class="text-xl font-bold text-highlighted">Aisha Patel</h3>
              <p class="text-muted">Brand Strategist</p>
            </div>
            <p class="text-sm text-muted">Crafting compelling brand narratives that resonate with audiences.</p>
          </div>
        </UCard>

        <UCard variant="outline" class="text-center">
          <div class="flex flex-col items-center space-y-4">
            <UAvatar 
              src="https://i.pravatar.cc/150?img=33" 
              alt="David Kim" 
              size="3xl"
            />
            <div>
              <h3 class="text-xl font-bold text-highlighted">David Kim</h3>
              <p class="text-muted">Illustrator</p>
            </div>
            <p class="text-sm text-muted">Custom illustrations that add personality to every brand.</p>
          </div>
        </UCard>
      </UPageGrid>
    </UPageSection>

    <!-- Our Approach Section -->
    <UPageSection
      headline="How We Work"
      title="Our Design Process"
      description="A proven methodology that ensures outstanding results every time."
      orientation="vertical"
    >
      <div class="grid gap-6 md:grid-cols-2 lg:grid-cols-4">
        <UCard variant="soft">
          <div class="space-y-3">
            <div class="flex items-center justify-center w-12 h-12 rounded-full bg-primary/10">
              <UIcon name="i-lucide-lightbulb" class="w-6 h-6 text-primary" />
            </div>
            <h3 class="text-lg font-bold">1. Discovery</h3>
            <p class="text-sm text-muted">Understanding your brand, goals, and target audience through in-depth research.</p>
          </div>
        </UCard>

        <UCard variant="soft">
          <div class="space-y-3">
            <div class="flex items-center justify-center w-12 h-12 rounded-full bg-primary/10">
              <UIcon name="i-lucide-pencil-ruler" class="w-6 h-6 text-primary" />
            </div>
            <h3 class="text-lg font-bold">2. Concept</h3>
            <p class="text-sm text-muted">Developing creative concepts and visual directions tailored to your needs.</p>
          </div>
        </UCard>

        <UCard variant="soft">
          <div class="space-y-3">
            <div class="flex items-center justify-center w-12 h-12 rounded-full bg-primary/10">
              <UIcon name="i-lucide-palette" class="w-6 h-6 text-primary" />
            </div>
            <h3 class="text-lg font-bold">3. Design</h3>
            <p class="text-sm text-muted">Bringing concepts to life with meticulous attention to detail and craftsmanship.</p>
          </div>
        </UCard>

        <UCard variant="soft">
          <div class="space-y-3">
            <div class="flex items-center justify-center w-12 h-12 rounded-full bg-primary/10">
              <UIcon name="i-lucide-check-circle" class="w-6 h-6 text-primary" />
            </div>
            <h3 class="text-lg font-bold">4. Delivery</h3>
            <p class="text-sm text-muted">Finalizing and delivering polished designs ready to make an impact.</p>
          </div>
        </UCard>
      </div>
    </UPageSection>

    <!-- Stats Section -->
    <UPageSection orientation="vertical">
      <div class="grid gap-8 md:grid-cols-4 text-center">
        <div>
          <div class="text-5xl font-bold text-primary mb-2">500+</div>
          <p class="text-muted">Projects Completed</p>
        </div>
        <div>
          <div class="text-5xl font-bold text-primary mb-2">200+</div>
          <p class="text-muted">Happy Clients</p>
        </div>
        <div>
          <div class="text-5xl font-bold text-primary mb-2">15</div>
          <p class="text-muted">Awards Won</p>
        </div>
        <div>
          <div class="text-5xl font-bold text-primary mb-2">10+</div>
          <p class="text-muted">Years Experience</p>
        </div>
      </div>
    </UPageSection>
    <UPageCTA
      v-bind="page.cta"
      variant="subtle"
      class="overflow-hidden"
    >
      <LazyStarsBg />
    </UPageCTA>

  </UApp>
</template>

<script setup lang="ts">
// You can add any reactive data or methods here
const { data: page } = await useAsyncData('index', () => queryCollection('index').first())
</script>
