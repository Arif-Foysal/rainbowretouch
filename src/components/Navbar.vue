<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';
import logo from '@/assets/logo.png'; // Update the path to your logo
 
document.addEventListener('DOMContentLoaded', function() {
        // Mobile menu toggle
        const menuButton = document.querySelector('[data-collapse-toggle="navbar-default"]');
        const menu = document.getElementById('navbar-default');
        
        menuButton.addEventListener('click', function() {
            menu.classList.toggle('hidden');
        });

        // Only add click handlers on mobile
        function isMobile() {
            return window.innerWidth < 1024;
        }

        // Handle dropdown toggles
        const dropdownTriggers = document.querySelectorAll('.dropdown-trigger');
        const subDropdowns = document.querySelectorAll('.sub-dropdown');

        dropdownTriggers.forEach(trigger => {
            trigger.addEventListener('click', function(e) {
                if (isMobile()) {
                    e.preventDefault();
                    const dropdownContent = this.nextElementSibling;
                    dropdownContent.classList.toggle('show');
                }
            });
        });

        subDropdowns.forEach(subDropdown => {
            const trigger = subDropdown.querySelector('.dropdown-item');
            trigger.addEventListener('click', function(e) {
                if (isMobile()) {
                    e.preventDefault();
                    e.stopPropagation();
                    const subContent = this.nextElementSibling;
                    subContent.classList.toggle('show');
                }
            });
        });

        // Close dropdowns when clicking outside
        document.addEventListener('click', function(e) {
            if (isMobile()) {
                if (!e.target.closest('.dropdown')) {
                    document.querySelectorAll('.dropdown-content, .sub-dropdown-content').forEach(content => {
                        content.classList.remove('show');
                    });
                }
            }
        });

        // Handle window resize
        window.addEventListener('resize', function() {
            if (!isMobile()) {
                document.querySelectorAll('.dropdown-content, .sub-dropdown-content').forEach(content => {
                    content.classList.remove('show');
                });
            }
        });
    });
</script>

<template>

<nav class="bg-gray-100 border-gray-200 sticky top-0 z-50">
    <!-- Previous green header div remains the same -->
  
    <div class="max-w-screen-xl flex flex-wrap items-center justify-between mx-auto px-4">
        <a href="index.php" class="flex items-center space-x-3 rtl:space-x-reverse">
            <img :src="logo" class="h-16" alt="Momen Logo" />
        </a>
        <button @click="toggleMenu" data-collapse-toggle="navbar-default" type="button" class="inline-flex items-center p-2 w-10 h-10 justify-center text-sm text-gray-500 rounded-lg lg:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200" aria-controls="navbar-default" aria-expanded="false">
            <span class="sr-only">Open main menu</span>
            <svg class="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 17 14">
            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 1h15M1 7h15M1 13h15"/>
            </svg> 
        </button>
        <div class="hidden w-full lg:block lg:w-auto" id="navbar-default">
            <ul class="font-medium flex flex-col p-4 lg:p-0 mt-4 border border-gray-100 rounded-lg bg-gray-50 lg:flex-row lg:space-x-8 rtl:space-x-reverse lg:mt-0 lg:border-0 lg:bg-gray-100">
                <li>
                    <a href="index.php" class="block py-2 px-3 text-white bg-blue-700 rounded lg:bg-transparent lg:text-blue-700 lg:p-0" aria-current="page">Home</a>
                </li>
                <li>
                    <a href="about.php" class="block py-2 px-3 text-gray-900 rounded hover:bg-gray-100 lg:hover:bg-transparent lg:border-0 lg:hover:text-blue-700 lg:p-0">About</a>
                </li>
                <li class="dropdown">
                    <a href="#" class="text-gray-900 font-semibold text-md dropdown-trigger" aria-current="page">
                        <div class="flex items-center">
                            <p>Services</p>
                            &nbsp;
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-down" viewBox="0 0 16 16">
                                <path fill-rule="evenodd" d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708"/>
                            </svg>
                        </div>
                    </a>
                    <div class="dropdown-content">
                        <div class="dropdown-content-container">
                            <div class="sub-dropdown">
                                <div class="dropdown-item">
                                    Image
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
                                        <path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
                                    </svg>
                                </div>
                                <div class="sub-dropdown-content">
                                    <div class="dropdown-content-container">
                                    <a href="#" class="dropdown-item">Background Removal</a>
                                        <a href="#" class="dropdown-item">Image Retouching</a>
                                        <a href="#" class="dropdown-item">Individual Ghost</a>
                                        <a href="#" class="dropdown-item">Image Restoration</a>
                                        <a href="#" class="dropdown-item">E-commerce product editing</a>
                                        <a href="#" class="dropdown-item">Color Correction</a>
                                        <a href="#" class="dropdown-item">Shadow Creation</a>
                                    </div>
                                </div>
                            </div>
                           

                            <div class="sub-dropdown">
                                <div class="dropdown-item">
                                    VFX
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
                                        <path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
                                    </svg>
                                </div>
                                <div class="sub-dropdown-content">
                                    <div class="dropdown-content-container">
                                        <a href="#" class="dropdown-item">Motion Graphics</a>
                                        <a href="#" class="dropdown-item">Visual Effects (VFX) Compositing</a>
                                        <a href="#" class="dropdown-item">3D Animation & Simulation</a>
                                    </div>
                                </div>
                            </div>
                            <!-- Add more service items similarly -->
                            <div class="sub-dropdown">
                                <div class="dropdown-item">
                                    Web Development
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
                                        <path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
                                    </svg>
                                </div>
                                <div class="sub-dropdown-content">
                                    <div class="dropdown-content-container">
                                        <a href="#" class="dropdown-item">Custom Website Development</a>
                                        <a href="#" class="dropdown-item">Frontend Development</a>
                                        <a href="#" class="dropdown-item">Backend Development</a>
                                        <a href="#" class="dropdown-item">API Development & Integration</a>
                                        <a href="#" class="dropdown-item">Database Design and Management</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <!-- Rest of the menu items remain the same -->
                <li>
                    <a href="pricing.php" class="block py-2 px-3 text-gray-900 rounded hover:bg-gray-100 lg:hover:bg-transparent lg:border-0 lg:hover:text-blue-700 lg:p-0">Pricing</a>
                </li>
                <li>
                    <a href="#" class="block py-2 px-3 text-gray-900 rounded hover:bg-gray-100 lg:hover:bg-transparent lg:border-0 lg:hover:text-blue-700 lg:p-0">Portfolio</a>
                </li>
                <li>
                    <a href="blog.php" class="block py-2 px-3 text-gray-900 rounded hover:bg-gray-100 lg:hover:bg-transparent lg:border-0 lg:hover:text-blue-700 lg:p-0">Blog</a>
                </li>
                <li>
                    <a href="workflow.php" class="block py-2 px-3 text-gray-900 rounded hover:bg-gray-100 lg:hover:bg-transparent lg:border-0 lg:hover:text-blue-700 lg:p-0">Workflow</a>
                </li>
                <li>
                    <a href="contact.php" class="block py-2 px-3 text-gray-900 rounded hover:bg-gray-100 lg:hover:bg-transparent lg:border-0 lg:hover:text-blue-700 lg:p-0">Contact</a>
                </li>
                
                <li class="dropdown">
                    <a href="#" class="text-gray-900 font-semibold text-md dropdown-trigger" aria-current="page">
                        <div class="flex items-center">
                            <p>Account</p>
                            &nbsp;
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-down" viewBox="0 0 16 16">
                                <path fill-rule="evenodd" d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708"/>
                            </svg>
                        </div>
                    </a>
                    <div class="dropdown-content">
                        <div class="dropdown-content-container">
                            <a href="profile.php" class="dropdown-item">Dashboard</a>
                            <a href="signup.php" class="dropdown-item">Sign Up</a>
                            <a href="login.php" class="dropdown-item">Log In</a>
                        </div>
                    </div>
                </li>


            </ul>
            
        </div>
        
    </div>
</nav>

</template>

<style scoped>  

   /* Base dropdown styles */
   .dropdown {
            position: relative;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            min-width: 200px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
            /* Adjust top position to be below the Services button */
            top: 100%;
            /* Add margin-top instead of padding to create gap */
            /* margin-top: 5px; */
            /* Add invisible padding on top to maintain hover area */
        }

        /* Sub dropdown styles */
        .sub-dropdown {
            position: relative;
        }

        .sub-dropdown-content {
            display: none;
            position: absolute;
            left: calc(100% - 10px); /* Pull back slightly to create overlap */
            top: -5px; /* Align with parent item */
            background-color: #f9f9f9;
            min-width: 200px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 2;
            /* Add padding to left to create hoverable gap */
            margin-left: 10px;
        }

        /* Desktop hover styles */
        @media (min-width: 768px) {
            .dropdown:hover .dropdown-content {
                display: block;
            }

            .sub-dropdown:hover .sub-dropdown-content {
                display: block;
            }

            /* Ensure main dropdown appears below the button */
            .dropdown {
                padding-bottom: 5px;
            }
        }

        /* Mobile styles */
        @media (max-width: 767px) {
            .dropdown-content {
                position: static;
                box-shadow: none;
                padding-left: 1rem;
                padding-top: 0;
                margin-top: 0;
            }

            .sub-dropdown-content {
                position: static;
                box-shadow: none;
                padding-left: 1rem;
            }

            .show {
                display: block;
            }
        }

        /* General styles */
        .dropdown-item {
            padding: 0.5rem 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
            background-color: #f9f9f9;
        }

        .dropdown-item:hover {
            background-color: #f0f0f0;
        }

        /* Add background to the dropdown content container */
        .dropdown-content-container {
            background-color: #f9f9f9;
            border-radius: 4px;
            /* Add a subtle border */
            border: 1px solid rgba(0,0,0,0.1);
        }



</style>