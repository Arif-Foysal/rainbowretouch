## Todo

Since your SPA will be hosted on a separate server/domain, you'll need to:

Configure CORS properly
Use token-based authentication instead of cookie-based
1. Configure CORS in Laravel
```php
<?php
return [
    'paths' => ['api/*', 'sanctum/csrf-cookie'],
    'allowed_methods' => ['*'],
    'allowed_origins' => ['http://rainbowretouch.com'], // Replace with your SPA domain
    'allowed_origins_patterns' => [],
    'allowed_headers' => ['*'],
    'exposed_headers' => [],
    'max_age' => 0,
    'supports_credentials' => true, // Important for cookies if needed
];
```
2. Token Storage in Frontend
3. In your SPA (Vue, React, Angular, etc.), implement this pattern:
```js
// Login and store token
async function login(email, password) {
  try {
    const response = await fetch('https://api.xxx.com/api/login', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: JSON.stringify({ email, password })
    });
    
    const data = await response.json();
    
    if (response.ok) {
      // Store the token in localStorage
      localStorage.setItem('auth_token', data.token);
      return { success: true, user: data.user };
    } else {
      return { success: false, message: data.message };
    }
  } catch (error) {
    return { success: false, message: 'Network error' };
  }
}

// Add token to requests
async function fetchWithAuth(url, options = {}) {
  const token = localStorage.getItem('auth_token');
  
  return fetch(url, {
    ...options,
    headers: {
      ...options.headers,
      'Authorization': token ? `Bearer ${token}` : '',
      'Accept': 'application/json'
    }
  });
}

// Example: Fetch protected data
async function getServices() {
  const response = await fetchWithAuth('https://api.xxx.com/api/services');
  return response.json();
}

// Logout function
function logout() {
  // Call API to invalidate token
  fetchWithAuth('https://api.xxx.com/api/logout', { method: 'POST' })
    .then(() => {
      // Remove token from storage
      localStorage.removeItem('auth_token');
    });
}
```   

Example vue.js auth service:
```js
// src/services/auth.js
import api from '@/services/api';

export default {
  login(credentials) {
    return api.post('/login', credentials);
  },
  
  register(user) {
    return api.post('/register', user);
  },
  
  logout() {
    return api.post('/logout');
  },
  
  getUser() {
    return api.get('/user');
  },
  
  isAuthenticated() {
    return localStorage.getItem('auth_token') !== null;
  }
};
```