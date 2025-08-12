<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return ['Laravel' => app()->version()];
});

//login page
Route::get('/login', function () {
    return response()->json(['message' => 'Login page']);
});