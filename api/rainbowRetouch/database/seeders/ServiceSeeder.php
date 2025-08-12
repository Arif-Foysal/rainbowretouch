<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Service;

class ServiceSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $services = [
            [
                'name' => 'Logo Design',
                'description' => 'Professional logo design services for businesses and brands'
            ],
            [
                'name' => 'Photo Editing',
                'description' => 'High-quality photo retouching and editing services'
            ],
            [
                'name' => 'Web Design',
                'description' => 'Modern and responsive web design solutions'
            ],
            [
                'name' => 'Branding',
                'description' => 'Complete branding packages for your business'
            ]
        ];

        foreach ($services as $service) {
            Service::create($service);
        }
    }
}
