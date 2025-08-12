import axios from 'axios';

// Create axios instance with base URL
const api = axios.create({
  baseURL: 'http://localhost:8000/api',
  headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-Requested-With': 'XMLHttpRequest' // This is important for Laravel to identify AJAX requests
  },
  withCredentials: true // This ensures cookies are sent with requests
});

// Set up CSRF token from the cookie if it exists
let token = document.cookie.split('; ')
  .find(row => row.startsWith('XSRF-TOKEN='))
  ?.split('=')[1];

if (token) {
  api.defaults.headers.common['X-XSRF-TOKEN'] = decodeURIComponent(token);
}

// Add a request interceptor to add auth token to every request
api.interceptors.request.use(
  config => {
    const token = localStorage.getItem('auth_token');
    if (token) {
      config.headers['Authorization'] = `Bearer ${token}`;
    }
    return config;
  },
  error => {
    return Promise.reject(error);
  }
);

// Add a response interceptor to handle auth errors globally
api.interceptors.response.use(
  response => {
    return response;
  },
  error => {
    // Handle 401 Unauthorized responses
    if (error.response && error.response.status === 401) {
      // Clear auth data
      localStorage.removeItem('auth_token');
      localStorage.removeItem('user');
      
      // Redirect to login page
      // Using window.location because we don't have access to the router here
      if (window.location.pathname !== '/login') {
        window.location.href = '/login';
      }
    }
    return Promise.reject(error);
  }
);

export default api;
