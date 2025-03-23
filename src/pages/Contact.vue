<template>
    <div class="relative flex items-top justify-center  bg-white  sm:items-center sm:pt-0 h-full">
    <div class="max-w-6xl mx-auto sm:px-6 lg:px-8">
        <div class="mt-8 overflow-hidden">
            <div class="grid grid-cols-1 md:grid-cols-2">
                <div class="p-6 mr-2 bg-gray-100 sm:rounded-lg">
                    <h1 class="text-4xl sm:text-5xl text-gray-800 font-extrabold tracking-tight">
                        Get in touch
                    </h1>
                    <p class="text-normal text-lg sm:text-2xl font-medium text-gray-600 mt-2">
                    We’d love to hear from you! Fill out the form below, and our team will get back to you as soon as possible.
                    </p>

                    <div class="flex items-center mt-8 text-gray-600">
                        <!-- Address information here -->
                    </div>

                    <div class="flex items-center mt-4 text-gray-600 ">
                        <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" class="w-8 h-8 text-gray-500">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"/>
                        </svg>
                        <div class="ml-4 text-md tracking-wide font-semibold w-40">
                            +44 1234567890
                        </div>
                    </div>

                    <div class="flex items-center mt-2 text-gray-600">
                        <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" class="w-8 h-8 text-gray-500">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
                        </svg>
                        <div class="ml-4 text-md tracking-wide font-semibold w-40">
                            <a href="https://veilmail.io/irish-geoff">https://rainbowretouch.com</a>
                        </div>
                    </div>
                </div>

                <form action="https://fabform.io/f/xxxxx" method="post" class="p-6 flex flex-col justify-center">
                    <div class="flex flex-col">
                        <label for="name" class="hidden">Full Name</label>
                        <input type="name" name="name" id="name" placeholder="Full Name" class="w-100 mt-2 py-3 px-3 rounded-lg bg-white border border-gray-400  text-gray-800 font-semibold focus:border-indigo-500 focus:outline-none">
                    </div>

                    <div class="flex flex-col mt-2">
                        <label for="email" class="hidden">Email</label>
                        <input type="email" name="email" id="email" placeholder="Email" class="w-100 mt-2 py-3 px-3 rounded-lg bg-white  border border-gray-400 text-gray-800 font-semibold focus:border-indigo-500 focus:outline-none">
                    </div>

                    <div class="flex flex-col mt-2">
                        <label for="message" class="hidden">Message</label>
                        <textarea name="message" id="message" placeholder="Your Message" class="w-100 mt-2 py-3 px-3 rounded-lg bg-white  border border-gray-400  text-gray-800 font-semibold focus:border-indigo-500 focus:outline-none"></textarea>
                    </div>
<br>
                    <button
                        class="sm:w-fit w-full px-5 py-3 bg-indigo-600 hover:bg-indigo-800 transition-all duration-700 ease-in-out rounded-lg shadow-[0px_1px_2px_0px_rgba(16,_24,_40,_0.05)] justify-center items-center flex">
                        <span class=" px-1.5 text-white text-base font-medium leading-6">Submit</span>
                    </button>
                      <p class="leading-relaxed text-xl text-gray-900 mt-8">
                      We respect your privacy and will never share your information with third parties
            </p>
                </form>
            </div>
        </div>
    </div>
</div>
</template>