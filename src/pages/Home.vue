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
import Faq from '@/components/Faq.vue';
import Brandings from '@/components/Brandings.vue';
import Timeline from '@/components/Time.vue';
import DataMap from '@/components/DataMap.vue';
import FeatureCards2 from '@/components/FeatureCards2.vue';
import Contact2 from '@/components/Contact2.vue';
</script>

<template>
<div class="">

<Hero/>
<FeatureCards/>
<BgRemoval/>
<FeatureCards2/>
<Faq/>
<Brandings/>
<Timeline/>
<DataMap/>
<section class="py-8 ">
        <div>
            <CarouselCard/>
            <Support/>
            
<Planning/>
<Investors/>

        </div>
</section>
                                            



</div>

<WithStats/>
<DiscountCards/>
<Testimonial/>

<Upload/>
<Contact2/>
    <!-- Contact Modal -->

</template>