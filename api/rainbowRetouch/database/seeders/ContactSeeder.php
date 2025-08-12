<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Contact;

class ContactSeeder extends Seeder
{
    public function run(): void
    {
        $contacts = [
            [
                'name' => 'John Smith',
                'email' => 'john.smith@email.com',
                'phone' => '+1-555-0123',
                'service' => 'Logo Design',
                'message' => 'I need a professional logo for my new startup company. Looking for something modern and clean.',
                'status' => 'new'
            ],
            [
                'name' => 'Sarah Johnson',
                'email' => 'sarah.johnson@company.com',
                'phone' => '+1-555-0456',
                'service' => 'Photo Editing',
                'message' => 'We have a batch of product photos that need background removal and color correction.',
                'status' => 'read'
            ],
            [
                'name' => 'Mike Wilson',
                'email' => 'mike.wilson@business.net',
                'phone' => null,
                'service' => 'Web Design',
                'message' => 'Looking for a complete website redesign for our e-commerce store. Need modern and mobile-friendly design.',
                'status' => 'new'
            ],
            [
                'name' => 'Emma Davis',
                'email' => 'emma.davis@gmail.com',
                'phone' => '+1-555-0789',
                'service' => 'Branding',
                'message' => 'Starting a new restaurant and need complete branding package including logo, menu design, and signage.',
                'status' => 'replied'
            ],
            [
                'name' => 'David Brown',
                'email' => 'david.brown@techstart.io',
                'phone' => '+1-555-0321',
                'service' => 'Logo Design',
                'message' => 'Tech startup needs a minimalist logo that represents innovation and reliability.',
                'status' => 'new'
            ],
            [
                'name' => 'Lisa Anderson',
                'email' => 'lisa.anderson@fashion.com',
                'phone' => '+1-555-0654',
                'service' => 'Photo Editing',
                'message' => 'Fashion photography retouching needed for upcoming catalog. About 50 images total.',
                'status' => 'read'
            ],
            [
                'name' => 'Robert Taylor',
                'email' => 'robert.taylor@consulting.biz',
                'phone' => null,
                'service' => null,
                'message' => 'General inquiry about your services and pricing. Please send me a portfolio of your recent work.',
                'status' => 'new'
            ],
            [
                'name' => 'Jennifer Martinez',
                'email' => 'jen.martinez@nonprofit.org',
                'phone' => '+1-555-0987',
                'service' => 'Branding',
                'message' => 'Non-profit organization looking for pro-bono or discounted branding services for our charity.',
                'status' => 'new'
            ],
            [
                'name' => 'Alex Thompson',
                'email' => 'alex.thompson@realtor.com',
                'phone' => '+1-555-0147',
                'service' => 'Web Design',
                'message' => 'Real estate agent needs a professional website with property listings and contact forms.',
                'status' => 'replied'
            ],
            [
                'name' => 'Maria Garcia',
                'email' => 'maria.garcia@bakery.local',
                'phone' => '+1-555-0258',
                'service' => 'Logo Design',
                'message' => 'Family bakery wants a warm, traditional logo that reflects our homemade quality and heritage.',
                'status' => 'read'
            ]
        ];

        foreach ($contacts as $contact) {
            Contact::create($contact);
        }
    }
}