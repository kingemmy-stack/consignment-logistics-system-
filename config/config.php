<?php
/**
 * Configuration File
 * Database and application settings
 */

// Database Configuration
define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', '');
define('DB_NAME', 'consignment_db');
define('DB_PORT', 3306);

// Application Settings
define('APP_NAME', 'Consignment & Logistics Management System');
define('APP_URL', 'http://localhost/');
define('APP_VERSION', '1.0.0');

// Security
define('SECRET_KEY', 'your_secret_key_here_change_in_production');
define('CSRF_TOKEN_EXPIRY', 3600);

// Upload Settings
define('UPLOAD_DIR', __DIR__ . '/../uploads/');
define('MAX_UPLOAD_SIZE', 5242880); // 5MB in bytes
define('ALLOWED_FILE_TYPES', ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx']);

// Email Settings
define('MAIL_FROM', 'noreply@consignmentlogistics.com');
define('MAIL_HOST', 'smtp.gmail.com');
define('MAIL_PORT', 587);
define('MAIL_USERNAME', 'your_email@gmail.com');
define('MAIL_PASSWORD', 'your_app_password');

// Payment Gateway - Paystack
define('PAYSTACK_PUBLIC_KEY', 'pk_live_your_paystack_public_key');
define('PAYSTACK_SECRET_KEY', 'sk_live_your_paystack_secret_key');

// Payment Gateway - Flutterwave
define('FLUTTERWAVE_PUBLIC_KEY', 'FLWPUBK_your_flutterwave_key');
define('FLUTTERWAVE_SECRET_KEY', 'FLWSECK_your_flutterwave_secret');

// Google Maps API
define('GOOGLE_MAPS_API_KEY', 'your_google_maps_api_key');

// Session Settings
define('SESSION_TIMEOUT', 3600); // 1 hour
define('SESSION_NAME', 'consignment_session');

// Pagination
define('ITEMS_PER_PAGE', 15);

// Timezone
define('TIMEZONE', 'Africa/Lagos');
date_default_timezone_set(TIMEZONE);
