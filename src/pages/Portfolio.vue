
<template>
    <div>
        <div class="grid grid-cols-2 md:grid-cols-4 gap-4 py-8 px-8">
            <div class="grid gap-4" v-for="(col, colIdx) in columns" :key="colIdx">
                <div v-for="(img, imgIdx) in col" :key="img">
                    <img
                        class="h-auto max-w-full rounded-lg cursor-pointer hover:opacity-80 transition"
                        :src="img"
                        alt=""
                        @click="openGallery(flatIndex(colIdx, imgIdx))"
                    />
                </div>
            </div>
        </div>

        <!-- Gallery Modal -->
        <div v-if="galleryOpen" class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-90">
            <button @click="closeGallery" class="absolute top-6 right-8 text-white text-3xl font-bold hover:text-red-400 focus:outline-none">&times;</button>
            <button @click="prevImage" class="absolute left-4 md:left-12 top-1/2 -translate-y-1/2 text-white text-4xl px-2 py-1 rounded hover:bg-black/30 focus:outline-none">&#8592;</button>
            <img :src="images[currentIndex]" class="max-h-[80vh] max-w-[90vw] rounded-lg shadow-2xl border-4 border-white" />
            <button @click="nextImage" class="absolute right-4 md:right-12 top-1/2 -translate-y-1/2 text-white text-4xl px-2 py-1 rounded hover:bg-black/30 focus:outline-none">&#8594;</button>
        </div>
    </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue';

const images = [
    'https://flowbite.s3.amazonaws.com/docs/gallery/masonry/image.jpg',
    'https://flowbite.s3.amazonaws.com/docs/gallery/masonry/image-1.jpg',
    'https://flowbite.s3.amazonaws.com/docs/gallery/masonry/image-2.jpg',
    'https://flowbite.s3.amazonaws.com/docs/gallery/masonry/image-3.jpg',
    'https://flowbite.s3.amazonaws.com/docs/gallery/masonry/image-4.jpg',
    'https://flowbite.s3.amazonaws.com/docs/gallery/masonry/image-5.jpg',
    'https://flowbite.s3.amazonaws.com/docs/gallery/masonry/image-6.jpg',
    'https://flowbite.s3.amazonaws.com/docs/gallery/masonry/image-7.jpg',
    'https://flowbite.s3.amazonaws.com/docs/gallery/masonry/image-8.jpg',
    'https://flowbite.s3.amazonaws.com/docs/gallery/masonry/image-9.jpg',
    'https://flowbite.s3.amazonaws.com/docs/gallery/masonry/image-10.jpg',
    'https://flowbite.s3.amazonaws.com/docs/gallery/masonry/image-11.jpg',
];

// Split images into 4 columns for masonry layout
const columns = computed(() => {
    const cols = [[], [], [], []];
    images.forEach((img, i) => {
        cols[i % 4].push(img);
    });
    return cols;
});

const galleryOpen = ref(false);
const currentIndex = ref(0);

function openGallery(idx) {
    currentIndex.value = idx;
    galleryOpen.value = true;
}
function closeGallery() {
    galleryOpen.value = false;
}
function nextImage() {
    currentIndex.value = (currentIndex.value + 1) % images.length;
}
function prevImage() {
    currentIndex.value = (currentIndex.value - 1 + images.length) % images.length;
}
function flatIndex(colIdx, imgIdx) {
    // Convert column and index to flat index
    let idx = 0;
    for (let i = 0; i < colIdx; i++) idx += columns.value[i].length;
    return idx + imgIdx;
}

function handleKey(e) {
    if (!galleryOpen.value) return;
    if (e.key === 'ArrowRight') nextImage();
    else if (e.key === 'ArrowLeft') prevImage();
    else if (e.key === 'Escape') closeGallery();
}

onMounted(() => {
    window.addEventListener('keydown', handleKey);
});
onUnmounted(() => {
    window.removeEventListener('keydown', handleKey);
});
</script>