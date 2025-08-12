<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Subcategory;

class SubcategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $subcategories = [
            // Logo Design subcategories
            ['service_id' => 1, 'name' => 'Business Logos', 'description' => 'Professional business logo designs'],
            ['service_id' => 1, 'name' => 'Creative Logos', 'description' => 'Artistic and creative logo concepts'],
            ['service_id' => 1, 'name' => 'Minimalist Logos', 'description' => 'Clean and simple logo designs'],
            
            // Photo Editing subcategories
            ['service_id' => 2, 'name' => 'Portrait Retouching', 'description' => 'Professional portrait photo editing'],
            ['service_id' => 2, 'name' => 'Product Photos', 'description' => 'E-commerce product photo editing'],
            ['service_id' => 2, 'name' => 'Background Removal', 'description' => 'Clean background removal services'],
            
            // Web Design subcategories
            ['service_id' => 3, 'name' => 'Landing Pages', 'description' => 'Converting landing page designs'],
            ['service_id' => 3, 'name' => 'E-commerce Sites', 'description' => 'Online store website designs'],
            
            // Branding subcategories
            ['service_id' => 4, 'name' => 'Brand Identity', 'description' => 'Complete brand identity packages'],
            ['service_id' => 4, 'name' => 'Business Cards', 'description' => 'Professional business card designs']
        ];

        foreach ($subcategories as $subcategory) {
            Subcategory::create($subcategory);
        }
    }
}
