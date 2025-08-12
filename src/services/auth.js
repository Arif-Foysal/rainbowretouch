// src/services/auth.js
import api from './api';
import axios from 'axios';

const authService = {
  /**
   * Get CSRF cookie from Laravel
   * @returns {Promise} - API response
   */
  async getCsrfCookie() {
    try {
      // Get CSRF cookie from Laravel Sanctum
      const response = await axios.get('http://localhost:8000/sanctum/csrf-cookie', {
        withCredentials: true // Important for cookies to be set
      });
      
      // After getting the cookie, extract the XSRF-TOKEN from cookies
      let token = document.cookie.split('; ')
        .find(row => row.startsWith('XSRF-TOKEN='))
        ?.split('=')[1];
      
      if (token) {
        // Update axios defaults
        axios.defaults.headers.common['X-XSRF-TOKEN'] = decodeURIComponent(token);
        api.defaults.headers.common['X-XSRF-TOKEN'] = decodeURIComponent(token);
      }
      
      return response;
    } catch (error) {
      console.error('Error getting CSRF cookie:', error);
      throw error;
    }
  },

  /**
   * Login user with email and password
   * @param {Object} credentials - User credentials
   * @param {string} credentials.email - User email
   * @param {string} credentials.password - User password
   * @returns {Promise} - API response
   */
  async login(credentials) {
    // First, get the CSRF cookie
    await this.getCsrfCookie();
    
    // Then perform the login request
    return api.post('/login', credentials);
  },

  /**
   * Register a new user
   * @param {Object} userData - User registration data
   * @param {string} userData.name - User name
   * @param {string} userData.email - User email
   * @param {string} userData.password - User password
   * @param {string} userData.password_confirmation - Password confirmation
   * @returns {Promise} - API response
   */
  async register(userData) {
    // First, get the CSRF cookie
    await this.getCsrfCookie();
    
    // Then perform the register request
    return api.post('/register', userData);
  },

  /**
   * Logout the current user
   * @returns {Promise} - API response
   */
  async logout() {
    // Make sure we have a valid CSRF token
    await this.getCsrfCookie();
    return api.post('/logout');
  },

  /**
   * Get authenticated user details
   * @returns {Promise} - API response with user data
   */
  async getUser() {
    // Make sure we have a valid CSRF token
    await this.getCsrfCookie();
    return api.get('/user');
  },
  
  /**
   * Check if the user is authenticated
   * @returns {boolean} - True if authenticated, false otherwise
   */
  isAuthenticated() {
    return !!localStorage.getItem('auth_token');
  },
  
  /**
   * Get the current user from localStorage
   * @returns {Object|null} - User object or null if not logged in
   */
  getCurrentUser() {
    const userStr = localStorage.getItem('user');
    if (userStr) {
      try {
        return JSON.parse(userStr);
      } catch (e) {
        return null;
      }
    }
    return null;
  }
};

export default authService;
