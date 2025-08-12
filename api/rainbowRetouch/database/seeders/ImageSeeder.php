<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Image;

class ImageSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $images = [
            // Business Logos images
            ['subcategory_id' => 1, 'image_url' => '/storage/images/business-logo-1.jpg', 'description' => 'Modern corporate logo design'],
            ['subcategory_id' => 1, 'image_url' => '/storage/images/business-logo-2.jpg', 'description' => 'Professional service logo'],
            ['subcategory_id' => 1, 'image_url' => '/storage/images/business-logo-3.jpg', 'description' => 'Tech company logo design'],
            
            // Creative Logos images
            ['subcategory_id' => 2, 'image_url' => '/storage/images/creative-logo-1.jpg', 'description' => 'Artistic brand logo'],
            ['subcategory_id' => 2, 'image_url' => '/storage/images/creative-logo-2.jpg', 'description' => 'Creative agency logo'],
            
            // Portrait Retouching images
            ['subcategory_id' => 4, 'image_url' => '/storage/images/portrait-1.jpg', 'description' => 'Professional headshot retouching'],
            ['subcategory_id' => 4, 'image_url' => '/storage/images/portrait-2.jpg', 'description' => 'Wedding photo editing'],
            
            // Product Photos images
            ['subcategory_id' => 5, 'image_url' => '/storage/images/product-1.jpg', 'description' => 'E-commerce product photo'],
            ['subcategory_id' => 5, 'image_url' => '/storage/images/product-2.jpg', 'description' => 'Amazon product listing photo'],
            
            // Landing Pages images
            ['subcategory_id' => 7, 'image_url' => '/storage/images/landing-1.jpg', 'description' => 'SaaS landing page design'],
            ['subcategory_id' => 7, 'image_url' => '/storage/images/landing-2.jpg', 'description' => 'Marketing landing page']
        ];

        foreach ($images as $image) {
            Image::create($image);
        }
    }
}
