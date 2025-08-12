<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Contact;
use Illuminate\Http\Request;

class ContactController extends Controller
{
    // GET /api/contacts
    public function index()
    {
        return Contact::orderBy('created_at', 'desc')->get();
    }

    // POST /api/contacts
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|max:255',
            'phone' => 'nullable|string|max:20',
            'service' => 'nullable|string|max:255',
            'message' => 'required|string'
        ]);

        $contact = Contact::create($validated);

        return response()->json([
            'message' => 'Contact form submitted successfully',
            'contact' => $contact
        ], 201);
    }

    // GET /api/contacts/{id}
    public function show(Contact $contact)
    {
        return $contact;
    }

    // PUT /api/contacts/{id}
    public function update(Request $request, Contact $contact)
    {
        $validated = $request->validate([
            'status' => 'sometimes|in:new,read,replied',
            'name' => 'sometimes|string|max:255',
            'email' => 'sometimes|email|max:255',
            'phone' => 'sometimes|nullable|string|max:20',
            'service' => 'sometimes|nullable|string|max:255',
            'message' => 'sometimes|string'
        ]);

        $contact->update($validated);
        return $contact;
    }

    // DELETE /api/contacts/{id}
    public function destroy(Contact $contact)
    {
        $contact->delete();
        return response()->json(['message' => 'Contact deleted successfully']);
    }
}