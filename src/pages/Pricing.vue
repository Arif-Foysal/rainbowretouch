<template>

<body class="font-inter">
    <section class="py-14 lg:py-24 relative">
        <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
            <h1 class="font-manrope font-bold text-5xl text-gray-900 text-center mb-4">Choose your plan</h1>
            <p class="font-normal text-base leading-7 text-gray-500 mb-8 text-center">Free trial available. No credit card
                required.</p>
                <div class="flex justify-center">
                <a href="free_trial.php" class="inline-flex items-center justify-center px-5 py-3 mr-3 text-base font-medium text-center text-white rounded-lg bg-indigo-600 hover:bg-indigo-800 transition-all duration-700 ease-in-out rounded-lg shadow-[0px_1px_2px_0px_rgba(16,_24,_40,_0.05)] ">
                Free Trial
                <svg class="w-5 h-5 ml-2 -mr-1" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
            </a>
            </div>
            <br>
            <div class="flex items-center justify-center gap-4 mb-20">
                <p class="font-medium text-xl leading-8 text-gray-900">Pay Monthly</p>
                <svg xmlns="http://www.w3.org/2000/svg" width="45" height="26" viewBox="0 0 45 26" fill="none">
                    <rect x="1" width="44" height="24" rx="12" fill="#E0E7FF" />
                    <g filter="url(#filter0_d_12308_8491)">
                        <circle cx="13" cy="12" r="10" fill="#4F46E5" />
                    </g>
                    <defs>
                        <filter id="filter0_d_12308_8491" x="0" y="0" width="26" height="26"
                            filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
                            <feFlood flood-opacity="0" result="BackgroundImageFix" />
                            <feColorMatrix in="SourceAlpha" type="matrix"
                                values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha" />
                            <feOffset dy="1" />
                            <feGaussianBlur stdDeviation="1.5" />
                            <feColorMatrix type="matrix"
                                values="0 0 0 0 0.0627451 0 0 0 0 0.0941176 0 0 0 0 0.156863 0 0 0 0.08 0" />
                            <feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_12308_8491" />
                            <feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_12308_8491"
                                result="shape" />
                        </filter>
                    </defs>
                </svg>
                <p class="font-normal text-xl leading-8 text-gray-500">Pay Yearly</p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8 max-w-md mx-auto md:max-w-3xl lg:max-w-full">
                <div
                    class="starter rounded-2xl border border-gray-300 p-4 xl:p-6 flex flex-col justify-between transition-all duration-500 hover:border-indigo-600 bg-sky-400">
                    <div class="data">
                        <h6 class="font-semibold text-base leading-7 text-emerald-400 mb-3">Starter</h6>
                        <h4 class="font-manrope font-bold text-3xl text-gray-900 leading-tight mb-2">Free</h4>
                        <p class="font-normal text-base leading-8 text-gray-600 mb-6">No credit card required</p>

                        <div class="items-center gap-4 mb-3 hidden lg:flex">
                            <svg class="stroke-gray-900" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M5 12L9.28722 16.2923C9.62045 16.6259 9.78706 16.7927 9.99421 16.7928C10.2014 16.7929 10.3681 16.6262 10.7016 16.2929L20 7"
                                    stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                    stroke-linejoin="round" />
                            </svg>
                            <span class="font-normal text-sm leading-6 text-gray-500">3 photos</span>
                        </div>

                        <div class="items-center gap-4 mb-3 hidden lg:flex">
                            <svg class="stroke-gray-900" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M5 12L9.28722 16.2923C9.62045 16.6259 9.78706 16.7927 9.99421 16.7928C10.2014 16.7929 10.3681 16.6262 10.7016 16.2929L20 7"
                                    stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                    stroke-linejoin="round" />
                            </svg>
                            <span class="font-normal text-sm leading-6 text-gray-500">Revisions</span>
                        </div>

                        <div class="items-center gap-4 mb-3 hidden lg:flex">
                            <svg class="stroke-gray-900" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M5 12L9.28722 16.2923C9.62045 16.6259 9.78706 16.7927 9.99421 16.7928C10.2014 16.7929 10.3681 16.6262 10.7016 16.2929L20 7"
                                    stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                    stroke-linejoin="round" />
                            </svg>
                            <span class="font-normal text-sm leading-6 text-gray-500">Starter Plan</span>
                        </div>
                    </div>

                    <div class="card-data mt-5 block lg:hidden">
                        <!-- Mobile view content - same as original -->
                        <!-- Keeping this section as is from the original code -->
                    </div>

                    <button onclick="location.href='free_trial.php';"
                        class="group flex items-center justify-center py-3 px-3 xl:px-6 rounded-full bg-indigo-50 shadow-sm shadow-indigo-100 mt-auto relative bottom-0 transition-all duration-500 hover:bg-indigo-600">
                        <span class="px-2 font-semibold text-sm text-indigo-600 group-hover:text-white whitespace-nowrap">Free Trial</span>
                        <svg width="23" height="22" viewBox="0 0 23 22" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path class="stroke-indigo-600 group-hover:stroke-white"
                                d="M3.25 11L17.9167 11M13.3333 16.5L18.1852 11.6482C18.4907 11.3426 18.6435 11.1898 18.6435 11C18.6435 10.8102 18.4907 10.6574 18.1852 10.3518L13.3333 5.5"
                                stroke="#4F46E5" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round" />
                        </svg>
                    </button>
                </div>

                <div
                    class="Pro rounded-2xl border border-gray-300 p-4 xl:p-6 flex flex-col justify-between transition-all duration-500 hover:border-indigo-600">
                    <div class="data">
                        <h6 class="font-semibold text-base leading-7 text-fuchsia-400 mb-3">Pro</h6>
                        <h4 class="font-manrope font-bold text-3xl text-gray-900 leading-tight mb-2 flex items-center">
                            $6
                             <span class="font-medium text-xs leading-5 text-fuchsia-400 ml-2.5">/ -25%</span>
                            </h4>
                        <p class="font-normal text-base leading-8 text-gray-600 mb-6">Pre month, billed annually</p>


                        <div class="hidden lg:flex items-center gap-4 mb-3">
                            <svg class="stroke-gray-900" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M5 12L9.28722 16.2923C9.62045 16.6259 9.78706 16.7927 9.99421 16.7928C10.2014 16.7929 10.3681 16.6262 10.7016 16.2929L20 7"
                                    stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                    stroke-linejoin="round" />
                            </svg>

                            <span class="font-normal text-sm leading-6 text-gray-500">10 Images</span>
                        </div>

                        <div class="hidden lg:flex items-center gap-4 mb-3">
                            <svg class="stroke-gray-900" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M5 12L9.28722 16.2923C9.62045 16.6259 9.78706 16.7927 9.99421 16.7928C10.2014 16.7929 10.3681 16.6262 10.7016 16.2929L20 7"
                                    stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                    stroke-linejoin="round" />
                            </svg>

                            <span class="font-normal text-sm leading-6 text-gray-500">Clipping Path</span>
                        </div>

                        <div class="hidden lg:flex items-center gap-4 mb-3">
                            <svg class="stroke-gray-900" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M5 12L9.28722 16.2923C9.62045 16.6259 9.78706 16.7927 9.99421 16.7928C10.2014 16.7929 10.3681 16.6262 10.7016 16.2929L20 7"
                                    stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                    stroke-linejoin="round" />
                            </svg>

                            <span class="font-normal text-sm leading-6 text-gray-500">Image Masking</span>
                        </div>

                        <div class="hidden lg:flex items-center gap-4 mb-3">
                            <svg class="stroke-gray-900" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M5 12L9.28722 16.2923C9.62045 16.6259 9.78706 16.7927 9.99421 16.7928C10.2014 16.7929 10.3681 16.6262 10.7016 16.2929L20 7"
                                    stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                    stroke-linejoin="round" />
                            </svg>

                            <span class="font-normal text-sm leading-6 text-gray-500">Image Retouch</span>
                        </div>

                        <div class="hidden lg:flex items-center gap-4 mb-3">
                            <svg class="stroke-gray-900" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M5 12L9.28722 16.2923C9.62045 16.6259 9.78706 16.7927 9.99421 16.7928C10.2014 16.7929 10.3681 16.6262 10.7016 16.2929L20 7"
                                    stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                    stroke-linejoin="round" />
                            </svg>

                            <span class="font-normal text-sm leading-6 text-gray-500">Ghost Retouch</span>
                        </div>

                        <div class="hidden lg:flex items-center gap-4 mb-3">
                            <svg class="stroke-gray-900" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M5 12L9.28722 16.2923C9.62045 16.6259 9.78706 16.7927 9.99421 16.7928C10.2014 16.7929 10.3681 16.6262 10.7016 16.2929L20 7"
                                    stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                    stroke-linejoin="round" />
                            </svg>

                            <span class="font-normal text-sm leading-6 text-gray-500">Clipping Shadowing</span>
                        </div>

                        <div class="hidden lg:flex items-center gap-4 mb-3">
                            <svg class="stroke-gray-900" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M5 12L9.28722 16.2923C9.62045 16.6259 9.78706 16.7927 9.99421 16.7928C10.2014 16.7929 10.3681 16.6262 10.7016 16.2929L20 7"
                                    stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                    stroke-linejoin="round" />
                            </svg>

                            <span class="font-normal text-sm leading-6 text-gray-500">E-Commerce</span>
                        </div>

                        <div class="hidden lg:flex items-center gap-4 mb-6">
                            <svg class="stroke-gray-900" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M5 12L9.28722 16.2923C9.62045 16.6259 9.78706 16.7927 9.99421 16.7928C10.2014 16.7929 10.3681 16.6262 10.7016 16.2929L20 7"
                                    stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                    stroke-linejoin="round" />
                            </svg>

                            <span class="font-normal text-sm leading-6 text-gray-500">Color Correction</span>
                        </div>

                        
                    </div>

                    <div class="card-data mt-5 block lg:hidden">
                        <!-- Mobile view content - same as original -->
                        <!-- Keeping this section as is from the original code -->
                    </div>

                    <button
                        class="group flex items-center justify-center py-3 px-3 xl:px-6 rounded-full bg-indigo-50 shadow-sm shadow-indigo-100 mt-auto relative bottom-0 transition-all duration-500 hover:bg-indigo-600">
                        <span class="px-2 font-semibold text-sm text-indigo-600 group-hover:text-white whitespace-nowrap">Choose Plan</span>
                        <svg width="23" height="22" viewBox="0 0 23 22" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path class="stroke-indigo-600 group-hover:stroke-white"
                                d="M3.25 11L17.9167 11M13.3333 16.5L18.1852 11.6482C18.4907 11.3426 18.6435 11.1898 18.6435 11C18.6435 10.8102 18.4907 10.6574 18.1852 10.3518L13.3333 5.5"
                                stroke="#4F46E5" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round" />
                        </svg>
                    </button>
                </div>

                <div
                    class="Startup rounded-2xl border border-gray-300 p-4 xl:p-6 flex flex-col justify-between transition-all duration-500 hover:border-indigo-600 bg-cyan-300">
                    <div class="data">
                        <h6 class="font-semibold text-base leading-7 text-amber-400 mb-3">Startup</h6>
                        <h4 class="font-manrope font-bold text-3xl text-gray-900 leading-tight mb-2 flex items-center">
                            $12 <span class="font-medium text-xs leading-5 text-fuchsia-400 ml-2.5">/ -25%</span></h4>
                        <p class="font-normal text-base leading-8 text-gray-600 mb-6">Pre month, billed annually</p>

                        <div class="hidden lg:flex items-center gap-4 mb-3">
                            <svg class="stroke-gray-900" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M5 12L9.28722 16.2923C9.62045 16.6259 9.78706 16.7927 9.99421 16.7928C10.2014 16.7929 10.3681 16.6262 10.7016 16.2929L20 7"
                                    stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                    stroke-linejoin="round" />
                            </svg>

                            <span class="font-normal text-sm leading-6 text-gray-500">10 Images</span>
                        </div>

                        <div class="hidden lg:flex items-center gap-4 mb-3">
                            <svg class="stroke-gray-900" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M5 12L9.28722 16.2923C9.62045 16.6259 9.78706 16.7927 9.99421 16.7928C10.2014 16.7929 10.3681 16.6262 10.7016 16.2929L20 7"
                                    stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                    stroke-linejoin="round" />
                            </svg>

                            <span class="font-normal text-sm leading-6 text-gray-500">Clipping Path</span>
                        </div>

                        <div class="hidden lg:flex items-center gap-4 mb-3">
                            <svg class="stroke-gray-900" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M5 12L9.28722 16.2923C9.62045 16.6259 9.78706 16.7927 9.99421 16.7928C10.2014 16.7929 10.3681 16.6262 10.7016 16.2929L20 7"
                                    stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                    stroke-linejoin="round" />
                            </svg>

                            <span class="font-normal text-sm leading-6 text-gray-500">Image Masking</span>
                        </div>

                        <div class="hidden lg:flex items-center gap-4 mb-3">
                            <svg class="stroke-gray-900" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M5 12L9.28722 16.2923C9.62045 16.6259 9.78706 16.7927 9.99421 16.7928C10.2014 16.7929 10.3681 16.6262 10.7016 16.2929L20 7"
                                    stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                    stroke-linejoin="round" />
                            </svg>

                            <span class="font-normal text-sm leading-6 text-gray-500">Image Retouch</span>
                        </div>

                        <div class="hidden lg:flex items-center gap-4 mb-3">
                            <svg class="stroke-gray-900" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M5 12L9.28722 16.2923C9.62045 16.6259 9.78706 16.7927 9.99421 16.7928C10.2014 16.7929 10.3681 16.6262 10.7016 16.2929L20 7"
                                    stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                    stroke-linejoin="round" />
                            </svg>

                            <span class="font-normal text-sm leading-6 text-gray-500">Ghost Retouch</span>
                        </div>

                        <div class="hidden lg:flex items-center gap-4 mb-3">
                            <svg class="stroke-gray-900" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M5 12L9.28722 16.2923C9.62045 16.6259 9.78706 16.7927 9.99421 16.7928C10.2014 16.7929 10.3681 16.6262 10.7016 16.2929L20 7"
                                    stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                    stroke-linejoin="round" />
                            </svg>

                            <span class="font-normal text-sm leading-6 text-gray-500">Clipping Shadowing</span>
                        </div>

                        <div class="hidden lg:flex items-center gap-4 mb-3">
                            <svg class="stroke-gray-900" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M5 12L9.28722 16.2923C9.62045 16.6259 9.78706 16.7927 9.99421 16.7928C10.2014 16.7929 10.3681 16.6262 10.7016 16.2929L20 7"
                                    stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                    stroke-linejoin="round" />
                            </svg>

                            <span class="font-normal text-sm leading-6 text-gray-500">E-Commerce</span>
                        </div>

                        <div class="hidden lg:flex items-center gap-4 mb-6">
                            <svg class="stroke-gray-900" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M5 12L9.28722 16.2923C9.62045 16.6259 9.78706 16.7927 9.99421 16.7928C10.2014 16.7929 10.3681 16.6262 10.7016 16.2929L20 7"
                                    stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                    stroke-linejoin="round" />
                            </svg>

                            <span class="font-normal text-sm leading-6 text-gray-500">Color Correction</span>
                        </div>
                    </div>

                    <div class="card-data mt-5 block lg:hidden">
                        <!-- Mobile view content - same as original -->
                        <!-- Keeping this section as is from the original code -->
                    </div>

                    <button
                        class="group flex items-center justify-center py-3 px-3 xl:px-6 rounded-full bg-indigo-50 shadow-sm shadow-indigo-100 mt-auto relative bottom-0 transition-all duration-500 hover:bg-indigo-600">
                        <span class="px-2 font-semibold text-sm text-indigo-600 group-hover:text-white whitespace-nowrap">Choose Plan</span>
                        <svg width="23" height="22" viewBox="0 0 23 22" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path class="stroke-indigo-600 group-hover:stroke-white"
                                d="M3.25 11L17.9167 11M13.3333 16.5L18.1852 11.6482C18.4907 11.3426 18.6435 11.1898 18.6435 11C18.6435 10.8102 18.4907 10.6574 18.1852 10.3518L13.3333 5.5"
                                stroke="#4F46E5" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round" />
                        </svg>
                    </button>
                </div>

                <div
                    class="Enterprise rounded-2xl border border-gray-300 p-4 xl:p-6 flex flex-col justify-between transition-all duration-500 hover:border-indigo-600 bg-green">
                    <div class="data">
                        <h6 class="font-semibold text-base leading-7 text-blue-400 mb-3">Enterprise</h6>
                        <h4 class="font-manrope font-bold text-3xl text-gray-900 leading-tight mb-2 flex items-center">
                            Contact us </h4>
                        <p class="font-normal text-base leading-8 text-gray-600 mb-6">For custom needs</p>

                        <div class="hidden lg:flex items-center gap-4 mb-3">
                            <svg class="stroke-gray-900" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M5 12L9.28722 16.2923C9.62045 16.6259 9.78706 16.7927 9.99421 16.7928C10.2014 16.7929 10.3681 16.6262 10.7016 16.2929L20 7"
                                    stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                    stroke-linejoin="round" />
                            </svg>

                            <span class="font-normal text-sm leading-6 text-gray-500">Custom Pricing</span>
                        </div>

                        <div class="hidden lg:flex items-center gap-4 mb-3">
                            <svg class="stroke-gray-900" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M5 12L9.28722 16.2923C9.62045 16.6259 9.78706 16.7927 9.99421 16.7928C10.2014 16.7929 10.3681 16.6262 10.7016 16.2929L20 7"
                                    stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                    stroke-linejoin="round" />
                            </svg>

                            <span class="font-normal text-sm leading-6 text-gray-500">Priority Support</span>
                        </div>

                        <div class="hidden lg:flex items-center gap-4 mb-3">
                            <svg class="stroke-gray-900" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M5 12L9.28722 16.2923C9.62045 16.6259 9.78706 16.7927 9.99421 16.7928C10.2014 16.7929 10.3681 16.6262 10.7016 16.2929L20 7"
                                    stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                    stroke-linejoin="round" />
                            </svg>

                            <span class="font-normal text-sm leading-6 text-gray-500">Volume discounts for bulk orders</span>
                        </div>

                        <div class="hidden lg:flex items-center gap-4 mb-3">
                            <svg class="stroke-gray-900" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M5 12L9.28722 16.2923C9.62045 16.6259 9.78706 16.7927 9.99421 16.7928C10.2014 16.7929 10.3681 16.6262 10.7016 16.2929L20 7"
                                    stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                    stroke-linejoin="round" />
                            </svg>

                            <span class="font-normal text-sm leading-6 text-gray-500">Fast turnaround options available</span>
                        </div>

                        <div class="hidden lg:flex items-center gap-4 mb-3">
                            <svg class="stroke-gray-900" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M5 12L9.28722 16.2923C9.62045 16.6259 9.78706 16.7927 9.99421 16.7928C10.2014 16.7929 10.3681 16.6262 10.7016 16.2929L20 7"
                                    stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                    stroke-linejoin="round" />
                            </svg>

                            <span class="font-normal text-sm leading-6 text-gray-500">Optional custom solution</span>
                        </div>
                    </div>

                    <div class="card-data mt-5 block lg:hidden">
                        <!-- Mobile view content - same as original -->
                        <!-- Keeping this section as is from the original code -->
                    </div>

                    <button
                        class="group flex items-center justify-center py-3 px-3 xl:px-6 rounded-full bg-indigo-50 shadow-sm shadow-indigo-100 mt-auto relative bottom-0 transition-all duration-500 hover:bg-indigo-600">
                        <span class="px-2 font-semibold text-sm text-indigo-600 group-hover:text-white whitespace-nowrap">Choose Plan</span>
                        <svg width="23" height="22" viewBox="0 0 23 22" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path class="stroke-indigo-600 group-hover:stroke-white"
                                d="M3.25 11L17.9167 11M13.3333 16.5L18.1852 11.6482C18.4907 11.3426 18.6435 11.1898 18.6435 11C18.6435 10.8102 18.4907 10.6574 18.1852 10.3518L13.3333 5.5"
                                stroke="#4F46E5" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round" />
                        </svg>
                    </button>
                </div>
            </div>
        </div>
    </section>


    <section class="pb-14 lg:pb-24 ">
        <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
            <div class="flex flex-col justify-center gap-6 xl:gap-12 lg:flex-row lg:justify-between ">
                <div class="w-full lg:w-2/5">
                    <div class="mb-16">
                        <h2 class="text-4xl text-center font-bold text-gray-900 leading-[3.25rem] mb-8 lg:text-left">
                            Frequently asked questions
                        </h2>
                        <p class="text-gray-500 text-lg text-center mb-12 lg:mb-24 lg:text-left">Trusted by more than
800 happy clients worldwide.</p>
                        <div class="flex justify-center lg:justify-start">
                            <button
                                class="py-3 px-7 bg-indigo-600 shadow-sm rounded-full transition-all duration-500 text-white font-semibold hover:bg-indigo-700">Read
                                More</button>
                        </div>
                    </div>
                </div>
                <div class="w-full max-lg:max-w-2xl max-lg:mx-auto lg:w-3/5 ">
                    <div class="accordion-group">
                        <div class="accordion pb-6 border-b border-solid border-gray-100">
                            <button
                                class="accordion-toggle group inline-flex items-center justify-between text-left text-xl leading-8 text-gray-900 w-full transition duration-500 hover:text-indigo-600"
                                data-active="true">
                                <h5>
                                    How to create an account?
                                </h5>
                                <svg class="text-gray-500 transition duration-500 group-hover:text-indigo-600 accordion-active:text-indigo-600 accordion-active:rotate-180"
                                    width="22" height="22" viewBox="0 0 22 22" fill="none"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path
                                        d="M16.5 8.25L12.4142 12.3358C11.7475 13.0025 11.4142 13.3358 11 13.3358C10.5858 13.3358 10.2525 13.0025 9.58579 12.3358L5.5 8.25"
                                        stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                        stroke-linejoin="round" />
                                </svg>
                            </button>
                            <div class="accordion-content w-full px-0 overflow-hidden transition-[height] duration-300 mt-3">
                                <p class="text-gray-900 leading-6">To create an account, find the "Sign up" or "Create
                                    account" button, fill out the registration form with your personal information, and
                                    click "Create account" or "Sign up." Verify your email address if needed, and then
                                    log in to start using the platform.</p>
                            </div>
                        </div>
                        <div class="accordion py-6 border-b border-solid border-gray-100">
                            <button
                                class="accordion-toggle group inline-flex items-center justify-between text-left text-xl leading-8 text-gray-900 w-full transition duration-500 hover:text-indigo-600"
                                data-active="false">
                                <h5>
                                    What is the payment process?
                                </h5>
                                <svg class="text-gray-500 transition duration-500 group-hover:text-indigo-600 accordion-active:text-indigo-600 accordion-active:rotate-180"
                                    width="22" height="22" viewBox="0 0 22 22" fill="none"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path
                                        d="M16.5 8.25L12.4142 12.3358C11.7475 13.0025 11.4142 13.3358 11 13.3358C10.5858 13.3358 10.2525 13.0025 9.58579 12.3358L5.5 8.25"
                                        stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                        stroke-linejoin="round" />
                                </svg>
                            </button>
                            <div class="accordion-content w-full px-0 hidden overflow-hidden transition-[height] duration-300 mt-3">
                                <p class="text-gray-900 leading-6">Our payment process is simple and secure. Select your preferred plan, enter your payment details (credit card, PayPal, or other available methods), and confirm your purchase. All transactions are encrypted and processed securely. You'll receive a confirmation email with your receipt and account details.</p>
                            </div>
                        </div>
                        <div class="accordion py-6 border-b border-solid border-gray-100">
                            <button
                                class="accordion-toggle group inline-flex items-center justify-between text-left text-xl leading-8 text-gray-900 w-full transition duration-500 hover:text-indigo-600"
                                data-active="false">
                                <h5>
                                    How can I reset my password?
                                </h5>
                                <svg class="text-gray-500 transition duration-500 group-hover:text-indigo-600 accordion-active:text-indigo-600 accordion-active:rotate-180"
                                    width="22" height="22" viewBox="0 0 22 22" fill="none"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path
                                        d="M16.5 8.25L12.4142 12.3358C11.7475 13.0025 11.4142 13.3358 11 13.3358C10.5858 13.3358 10.2525 13.0025 9.58579 12.3358L5.5 8.25"
                                        stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                        stroke-linejoin="round" />
                                </svg>
                            </button>
                            <div class="accordion-content w-full px-0 hidden overflow-hidden transition-[height] duration-300 mt-3">
                                <p class="text-gray-900 leading-6">To reset your password, click on the "Forgot password" link on the login page. Enter the email address associated with your account, and we'll send you a password reset link. Click the link in the email and follow the instructions to create a new password. For security reasons, the reset link expires after 24 hours.</p>
                            </div>
                        </div>
                        <div class="accordion pt-6">
                            <button
                                class="accordion-toggle group inline-flex items-center justify-between text-left text-xl leading-8 text-gray-900 w-full transition duration-500 hover:text-indigo-600"
                                data-active="false">
                                <h5>
                                    Have any trust issue?
                                </h5>
                                <svg class="text-gray-500 transition duration-500 group-hover:text-indigo-600 accordion-active:text-indigo-600 accordion-active:rotate-180"
                                    width="22" height="22" viewBox="0 0 22 22" fill="none"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path
                                        d="M16.5 8.25L12.4142 12.3358C11.7475 13.0025 11.4142 13.3358 11 13.3358C10.5858 13.3358 10.2525 13.0025 9.58579 12.3358L5.5 8.25"
                                        stroke="currentColor" stroke-width="1.6" stroke-linecap="round"
                                        stroke-linejoin="round" />
                                </svg>
                            </button>
                            <div class="accordion-content w-full px-0 hidden overflow-hidden transition-[height] duration-300 mt-3">
                                <p class="text-gray-900 leading-6">We understand trust is essential. That's why we prioritize transparency, security, and reliability. Our platform uses industry-standard encryption, we're compliant with relevant regulations, and we have a clear privacy policy. If you have specific concerns, our support team is available to address them and provide any documentation you might need.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>




</body>
</template>

<script setup>
import { ref, onMounted } from 'vue';


</script>