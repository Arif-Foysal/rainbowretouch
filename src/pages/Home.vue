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
import DiscountCards from '@/components/DiscountCards.vue';
import Upload from '@/pages/Upload.vue';
import Modal from '@/components/Modal.vue';
import UploadForm from '@/components/UploadForm.vue';
import FeatureCards from '@/components/FeatureCards.vue';

// import Timeline from '@/components/Timeline.vue';
</script>

<template>
<div class="">

<Hero/>
<FeatureCards/>



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
<DiscountCards/>
<Testimonial/>

<Upload/>
    <!-- Contact Modal -->

</template>