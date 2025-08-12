<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Models\Service;
use App\Models\Subcategory;
use App\Models\Image;
use App\Models\User; // Ensure User model is imported
use Illuminate\Support\Facades\Hash; // Ensure Hash facade is imported

use App\Http\Controllers\Api\ContactController;

Route::middleware(['auth:sanctum'])->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('/', function () {
    return ['Laravel is workinggggggggggg' => app()->version()];
});

// ===== AUTHENTICATION ROUTES =====
// SIGNUP (Register)
Route::post('/register', function (Request $request) {
    $validated = $request->validate([
        'name' => 'required|string|max:255',
        'email' => 'required|string|email|max:255|unique:users',
        'password' => 'required|string|min:8|confirmed',
    ]);

    // Check if user already exists
    if (User::where('email', $validated['email'])->exists()) {
        return response()->json(['message' => 'User already exists'], 409);
    }

    // Create the user
    $user = User::create([
        'name' => $validated['name'],
        'email' => $validated['email'],
        'password' => Hash::make($validated['password']),
    ]);

    // Optionally auto-login after registration
    $token = $user->createToken('api-token')->plainTextToken;

    return response()->json([
        'user' => $user,
        'token' => $token,
    ], 201);
});


// LOGIN
Route::post('/login', function (Request $request) {
    $credentials = $request->validate([
        'email' => 'required|email',
        'password' => 'required',
    ]);

    $user = User::where('email', $credentials['email'])->first();

    if (!$user || !Hash::check($credentials['password'], $user->password)) {
        return response()->json(['message' => 'Invalid credentials'], 401);
    }

    $token = $user->createToken('api-token')->plainTextToken;

    return response()->json([
        'user' => $user,
        'token' => $token,
    ]);
});



// LOGOUT (Revoke token)
Route::middleware('auth:sanctum')->post('/logout', function (Request $request) {
    $request->user()->currentAccessToken()->delete();
    return response()->json(['message' => 'Logged out']);
});




// ===== SERVICES CRUD =====
// READ - Get all services
Route::get('/services', function () {
    return Service::with('subcategories')->get();
});

// READ - Get single service
Route::get('/services/{id}', function ($id) {
    return Service::with('subcategories.images')->findOrFail($id);
});

// CREATE - Create new service
Route::post('/services', function (Request $request) {
    $validated = $request->validate([
        'name' => 'required|string|max:255',
        'description' => 'required|string'
    ]);
    
    return Service::create($validated);
});

// UPDATE - Update service
Route::put('/services/{id}', function (Request $request, $id) {
    $service = Service::findOrFail($id);
    
    $validated = $request->validate([
        'name' => 'sometimes|string|max:255',
        'description' => 'sometimes|string'
    ]);
    
    $service->update($validated);
    return $service;
});

// DELETE - Delete service
Route::delete('/services/{id}', function ($id) {
    $service = Service::findOrFail($id);
    $service->delete();
    return response()->json(['message' => 'Service deleted successfully']);
});

// ===== SUBCATEGORIES CRUD =====
// READ - Get all subcategories
Route::get('/subcategories', function () {
    return Subcategory::with(['service', 'images'])->get();
});

// READ - Get subcategories by service
Route::get('/services/{serviceId}/subcategories', function ($serviceId) {
    return Subcategory::where('service_id', $serviceId)->with('images')->get();
});

// READ - Get single subcategory
Route::get('/subcategories/{id}', function ($id) {
    return Subcategory::with(['service', 'images'])->findOrFail($id);
});

// CREATE - Create new subcategory
Route::post('/subcategories', function (Request $request) {
    $validated = $request->validate([
        'service_id' => 'required|exists:services,id',
        'name' => 'required|string|max:255',
        'description' => 'required|string'
    ]);
    
    return Subcategory::create($validated);
});

// UPDATE - Update subcategory
Route::put('/subcategories/{id}', function (Request $request, $id) {
    $subcategory = Subcategory::findOrFail($id);
    
    $validated = $request->validate([
        'service_id' => 'sometimes|exists:services,id',
        'name' => 'sometimes|string|max:255',
        'description' => 'sometimes|string'
    ]);
    
    $subcategory->update($validated);
    return $subcategory;
});

// DELETE - Delete subcategory
Route::delete('/subcategories/{id}', function ($id) {
    $subcategory = Subcategory::findOrFail($id);
    $subcategory->delete();
    return response()->json(['message' => 'Subcategory deleted successfully']);
});

// ===== IMAGES CRUD =====
// READ - Get all images
Route::get('/images', function () {
    return Image::with('subcategory.service')->get();
});

// READ - Get images by subcategory
Route::get('/subcategories/{subcategoryId}/images', function ($subcategoryId) {
    return Image::where('subcategory_id', $subcategoryId)->get();
});

// READ - Get single image
Route::get('/images/{id}', function ($id) {
    return Image::with('subcategory.service')->findOrFail($id);
});

// CREATE - Create new image
Route::post('/images', function (Request $request) {
    $validated = $request->validate([
        'subcategory_id' => 'required|exists:subcategories,id',
        'image_url' => 'required|string',
        'description' => 'required|string'
    ]);
    
    return Image::create($validated);
});

// UPDATE - Update image
Route::put('/images/{id}', function (Request $request, $id) {
    $image = Image::findOrFail($id);
    
    $validated = $request->validate([
        'subcategory_id' => 'sometimes|exists:subcategories,id',
        'image_url' => 'sometimes|string',
        'description' => 'sometimes|string'
    ]);
    
    $image->update($validated);
    return $image;
});

// DELETE - Delete image
Route::delete('/images/{id}', function ($id) {
    $image = Image::findOrFail($id);
    $image->delete();
    return response()->json(['message' => 'Image deleted successfully']);
});

// ===== CONTACTS CRUD =====
Route::apiResource('contacts', ContactController::class)->only(['index', 'store', 'show', 'update', 'destroy'])->names([
    'index' => 'contacts.list',
    'store' => 'contacts.create',
    'show' => 'contacts.view',
    'update' => 'contacts.update',
    'destroy' => 'contacts.delete'
]);