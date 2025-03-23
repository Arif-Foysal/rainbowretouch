<template>
    <div ref="slider" class="slider-wrapper" @mousedown="startDrag" @touchstart="startDrag">
      <div
        class="slider-content"
        :style="{ transform: `translateX(${translateX}px)`, width: `${contentWidth}px` }"
        @transitionend="onTransitionEnd"
      >
        <div
          v-for="(item, index) in displayItems"
          :key="index"
          class="slider-item"
          :style="{ width: `${itemWidth}px` }"
        >
          <slot :item="item"></slot>
        </div>
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref, reactive, onMounted, watch } from 'vue';
  
  const slider = ref(null);
  const state = reactive({
    items: Array(10).fill().map((_, i) => i + 1),
    itemWidth: 200,
    translateX: 0,
    isDragging: false,
    startX: 0,
    currentX: 0,
  });
  
  const displayItems = computed(() => [
    state.items[state.items.length - 1],
    ...state.items,
    state.items[0],
  ]);
  
  const contentWidth = computed(() => state.itemWidth * displayItems.value.length);
  
  const startDrag = (e) => {
    state.isDragging = true;
    state.startX = e.touches ? e.touches[0].clientX : e.clientX;
    window.addEventListener('mousemove', onDrag);
    window.addEventListener('touchmove', onDrag);
    window.addEventListener('mouseup', endDrag);
    window.addEventListener('touchend', endDrag);
  };
  
  const onDrag = (e) => {
    if (!state.isDragging) return;
    state.currentX = e.touches ? e.touches[0].clientX : e.clientX;
    state.translateX += state.currentX - state.startX;
    state.startX = state.currentX;
  };
  
  const endDrag = () => {
    state.isDragging = false;
    window.removeEventListener('mousemove', onDrag);
    window.removeEventListener('touchmove', onDrag);
    window.removeEventListener('mouseup', endDrag);
    window.removeEventListener('touchend', endDrag);
    correctPosition();
  };
  
  const correctPosition = () => {
    const maxTranslateX = -state.itemWidth * (displayItems.value.length - 3);
    if (state.translateX > -state.itemWidth) {
      state.translateX = maxTranslateX;
    }
    if (state.translateX < maxTranslateX) {
      state.translateX = -state.itemWidth;
    }
  };
  
  onMounted(() => {
    state.translateX = -state.itemWidth;
  });
  </script>
  
  <style scoped>
  .slider-wrapper {
    overflow: hidden;
    width: 100%;
    position: relative;
  }
  
  .slider-content {
    display: flex;
    transition: transform 0.3s ease;
  }
  
  .slider-item {
    flex-shrink: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 200px;
    background-color: #f4f4f4;
    margin: 0 10px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  }
  </style>
  