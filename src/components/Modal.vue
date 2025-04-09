<template>
    <Teleport to="body">
      <transition name="modal-fade">
        <div v-if="modelValue" class="modal-overlay" @click.self="closeModal">
          <div class="modal-container" :class="[size]">
            <div class="modal-header">
              <slot name="header">
                <h3 class="modal-title">{{ title }}</h3>
              </slot>
              <button class="modal-close" @click="closeModal" aria-label="Close modal">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="w-5 h-5">
                  <line x1="18" y1="6" x2="6" y2="18"></line>
                  <line x1="6" y1="6" x2="18" y2="18"></line>
                </svg>
              </button>
            </div>
            <div class="modal-body">
              <slot></slot>
            </div>
            <div class="modal-footer" v-if="$slots.footer">
              <slot name="footer"></slot>
            </div>
          </div>
        </div>
      </transition>
    </Teleport>
  </template>
  
  <script setup>
  import { watch } from 'vue'
  
  const props = defineProps({
    modelValue: {
      type: Boolean,
      default: false
    },
    title: {
      type: String,
      default: ''
    },
    size: {
      type: String,
      default: 'md',
      validator: (value) => ['sm', 'md', 'lg', 'xl', 'full'].includes(value)
    }
  })
  
  const emit = defineEmits(['update:modelValue'])
  
  const closeModal = () => {
    emit('update:modelValue', false)
  }
  
  // Close modal on escape key
  watch(() => props.modelValue, (value) => {
    if (value) {
      document.body.style.overflow = 'hidden'
      window.addEventListener('keydown', handleEscKey)
    } else {
      document.body.style.overflow = ''
      window.removeEventListener('keydown', handleEscKey)
    }
  })
  
  const handleEscKey = (event) => {
    if (event.key === 'Escape') {
      closeModal()
    }
  }
  </script>
  
  <style scoped>
  .modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 50;
    padding: 1rem;
  }
  
  .modal-container {
    background-color: white;
    border-radius: 0.5rem;
    box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
    max-height: calc(100vh - 2rem);
    overflow-y: auto;
    width: 100%;
  }
  
  .modal-container.sm {
    max-width: 24rem;
  }
  
  .modal-container.md {
    max-width: 32rem;
  }
  
  .modal-container.lg {
    max-width: 48rem;
  }
  
  .modal-container.xl {
    max-width: 64rem;
  }
  
  .modal-container.full {
    max-width: 100%;
    height: 100%;
    border-radius: 0;
  }
  
  .modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1rem 1.5rem;
    border-bottom: 1px solid #e5e7eb;
  }
  
  .modal-title {
    font-size: 1.125rem;
    font-weight: 600;
    color: #111827;
    margin: 0;
  }
  
  .modal-close {
    background: transparent;
    border: none;
    color: #6b7280;
    cursor: pointer;
    padding: 0.25rem;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 0.375rem;
    transition: background-color 0.2s;
  }
  
  .modal-close:hover {
    background-color: #f3f4f6;
    color: #111827;
  }
  
  .modal-body {
    padding: 1.5rem;
  }
  
  .modal-footer {
    padding: 1rem 1.5rem;
    border-top: 1px solid #e5e7eb;
    display: flex;
    justify-content: flex-end;
    gap: 0.5rem;
  }
  
  /* Transition animations */
  .modal-fade-enter-active,
  .modal-fade-leave-active {
    transition: opacity 0.3s ease;
  }
  
  .modal-fade-enter-from,
  .modal-fade-leave-to {
    opacity: 0;
  }
  </style>