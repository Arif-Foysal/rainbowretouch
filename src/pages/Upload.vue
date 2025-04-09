<script setup>
import { ref } from 'vue';
import UploadForm from '@/components/UploadForm.vue';
// Available formats
const formats = ['JPG', 'PNG', 'PSD', 'TIFF', 'GIF']
const selectedFormat = ref('JPG')
const selectedFile = ref(null)

// Handle simple file selection
const handleFileSelect = (event) => {
  const file = event.target.files[0]
  if (file) {
    selectedFile.value = file
  }
}
</script>
<template>
    <div class="flex flex-col md:flex-row min-h-screen">
      <!-- Left Section - Promotional Content -->
      <section class="bg-yellow-600 w-full sm:w-2/3 md:w-1/2 p-8 flex flex-col justify-center items-center text-white">
        <div class="max-w-lg mx-auto text-center">
          <h2 class="text-2xl md:text-3xl font-medium mb-6">Get 3 photo editing service for Free</h2>
          
          <div class="my-8">
            <h1 class="text-5xl md:text-7xl font-bold tracking-tight">
              FREE TRIAL
            </h1>
            <h1 class="text-5xl md:text-7xl font-bold tracking-tight mt-2">
              NOW
            </h1>
          </div>
          
          <p class="text-xl md:text-2xl mt-12">Have your image back within 24 hours</p>
        </div>
      </section>
      
      <!-- Right Section - Form -->
      <section class="bg-white w-full sm:w-1/3 md:w-1/2 p-8 flex flex-col justify-center">
        <div class="max-w-md mx-auto w-full">
          <h2 class="text-5xl font-bold mb-6">Request a free trial now!</h2>
          
          <!-- Simple File Upload -->

          
          <!-- Format Selection -->
       
          
          <!-- Upload Form Component -->
          <UploadForm 
            :showFormats="false" 
            :showSubmitButton="true"
          />
        </div>
      </section>
    </div>
  </template>