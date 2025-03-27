<script setup>
import { ref } from 'vue';
import sampleImage1 from '@/assets/images/image-4.jpg';

import ImageCarousel from '@/components/ImageCarousel.vue';
import WithStats from '@/components/WithStats.vue';
import Testimonial from '@/components/Testimonial.vue';
import Support from '@/components/Support.vue';
import BgRemoval from '@/components/BgRemoval.vue';
import Planning from '@/components/Planning.vue';
import Investors from '@/components/Investors.vue';
import CarouselCard from '@/components/CarouselCard.vue';
import Hero from '@/components/Hero.vue';
</script>

<template>
<div class="">

<Hero/>




<section class="py-8 ">
        <div>
            <CarouselCard/>
            <Support/>
            <BgRemoval/>
<Planning/>
<Investors/>

        </div>
      </section>
                                            



</div>

<WithStats/>
<Testimonial/>
</template>