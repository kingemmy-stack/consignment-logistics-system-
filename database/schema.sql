-- ============================================================
-- CONSIGNMENT & LOGISTICS MANAGEMENT SYSTEM
-- Database Schema
-- ============================================================

-- Create Database
CREATE DATABASE IF NOT EXISTS `consignment_db` 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE `consignment_db`;

-- ============================================================
-- 1. ROLES TABLE
-- ============================================================
CREATE TABLE `roles` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(50) NOT NULL UNIQUE,
  `description` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 2. USERS TABLE (Customers)
-- ============================================================
CREATE TABLE `users` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `username` VARCHAR(100) NOT NULL UNIQUE,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `first_name` VARCHAR(50),
  `last_name` VARCHAR(50),
  `phone` VARCHAR(20),
  `avatar` VARCHAR(255),
  `company_name` VARCHAR(100),
  `company_registration` VARCHAR(50),
  `address` TEXT,
  `city` VARCHAR(50),
  `state` VARCHAR(50),
  `country` VARCHAR(50),
  `postal_code` VARCHAR(20),
  `latitude` DECIMAL(10, 8),
  `longitude` DECIMAL(11, 8),
  `role_id` INT DEFAULT 1,
  `status` ENUM('active', 'inactive', 'suspended', 'deleted') DEFAULT 'active',
  `email_verified` BOOLEAN DEFAULT FALSE,
  `email_verification_token` VARCHAR(255),
  `email_verified_at` TIMESTAMP NULL,
  `phone_verified` BOOLEAN DEFAULT FALSE,
  `two_factor_enabled` BOOLEAN DEFAULT FALSE,
  `two_factor_secret` VARCHAR(255),
  `last_login` TIMESTAMP NULL,
  `profile_completed` BOOLEAN DEFAULT FALSE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`role_id`) REFERENCES `roles`(`id`) ON DELETE SET NULL,
  INDEX `idx_email` (`email`),
  INDEX `idx_status` (`status`),
  INDEX `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 3. ADMINS TABLE
-- ============================================================
CREATE TABLE `admins` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `username` VARCHAR(100) NOT NULL UNIQUE,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `first_name` VARCHAR(50),
  `last_name` VARCHAR(50),
  `phone` VARCHAR(20),
  `avatar` VARCHAR(255),
  `role_id` INT,
  `status` ENUM('active', 'inactive', 'suspended') DEFAULT 'active',
  `permissions` JSON,
  `last_login` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`role_id`) REFERENCES `roles`(`id`) ON DELETE SET NULL,
  INDEX `idx_email` (`email`),
  INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 4. DRIVERS TABLE
-- ============================================================
CREATE TABLE `drivers` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `username` VARCHAR(100) NOT NULL UNIQUE,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `avatar` VARCHAR(255),
  `license_number` VARCHAR(50) UNIQUE,
  `license_expiry` DATE,
  `national_id` VARCHAR(50) UNIQUE,
  `address` TEXT,
  `city` VARCHAR(50),
  `state` VARCHAR(50),
  `country` VARCHAR(50),
  `postal_code` VARCHAR(20),
  `latitude` DECIMAL(10, 8),
  `longitude` DECIMAL(11, 8),
  `branch_id` INT,
  `vehicle_id` INT,
  `status` ENUM('active', 'inactive', 'on_leave', 'suspended') DEFAULT 'active',
  `approval_status` ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
  `rating` DECIMAL(3, 2) DEFAULT 0,
  `total_deliveries` INT DEFAULT 0,
  `successful_deliveries` INT DEFAULT 0,
  `failed_deliveries` INT DEFAULT 0,
  `documents_verified` BOOLEAN DEFAULT FALSE,
  `last_login` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `idx_status` (`status`),
  INDEX `idx_branch_id` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 5. BRANCHES TABLE
-- ============================================================
CREATE TABLE `branches` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL,
  `code` VARCHAR(20) NOT NULL UNIQUE,
  `email` VARCHAR(100),
  `phone` VARCHAR(20),
  `address` TEXT NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `state` VARCHAR(50),
  `country` VARCHAR(50),
  `postal_code` VARCHAR(20),
  `latitude` DECIMAL(10, 8) NOT NULL,
  `longitude` DECIMAL(11, 8) NOT NULL,
  `manager_name` VARCHAR(100),
  `manager_phone` VARCHAR(20),
  `opening_hours` VARCHAR(100),
  `services_offered` JSON,
  `status` ENUM('active', 'inactive', 'closed') DEFAULT 'active',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `idx_city` (`city`),
  INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add foreign key after branches table is created
ALTER TABLE `drivers` 
ADD CONSTRAINT `fk_drivers_branch` 
FOREIGN KEY (`branch_id`) REFERENCES `branches`(`id`) ON DELETE SET NULL;

-- ============================================================
-- 6. VEHICLES TABLE
-- ============================================================
CREATE TABLE `vehicles` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `branch_id` INT NOT NULL,
  `registration_number` VARCHAR(50) NOT NULL UNIQUE,
  `model` VARCHAR(100),
  `make` VARCHAR(100),
  `year` YEAR,
  `type` ENUM('van', 'truck', 'motorcycle', 'car', 'lorry') DEFAULT 'van',
  `capacity_kg` DECIMAL(10, 2),
  `status` ENUM('active', 'inactive', 'maintenance', 'retired') DEFAULT 'active',
  `last_service_date` DATE,
  `insurance_expiry` DATE,
  `inspection_expiry` DATE,
  `driver_id` INT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`branch_id`) REFERENCES `branches`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`driver_id`) REFERENCES `drivers`(`id`) ON DELETE SET NULL,
  INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add vehicle foreign key to drivers
ALTER TABLE `drivers` 
ADD CONSTRAINT `fk_drivers_vehicle` 
FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles`(`id`) ON DELETE SET NULL;

-- ============================================================
-- 7. ADDRESSES TABLE (Save multiple addresses)
-- ============================================================
CREATE TABLE `addresses` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT NOT NULL,
  `type` ENUM('home', 'office', 'other') DEFAULT 'home',
  `label` VARCHAR(50),
  `full_name` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `email` VARCHAR(100),
  `address` TEXT NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `state` VARCHAR(50),
  `country` VARCHAR(50),
  `postal_code` VARCHAR(20),
  `latitude` DECIMAL(10, 8),
  `longitude` DECIMAL(11, 8),
  `is_default` BOOLEAN DEFAULT FALSE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  INDEX `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 8. SHIPMENTS TABLE
-- ============================================================
CREATE TABLE `shipments` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `tracking_number` VARCHAR(50) NOT NULL UNIQUE,
  `qr_code` VARCHAR(255),
  `barcode` VARCHAR(255),
  `user_id` INT NOT NULL,
  `sender_name` VARCHAR(100) NOT NULL,
  `sender_phone` VARCHAR(20) NOT NULL,
  `sender_email` VARCHAR(100),
  `sender_address` TEXT NOT NULL,
  `sender_city` VARCHAR(50) NOT NULL,
  `sender_state` VARCHAR(50),
  `sender_country` VARCHAR(50),
  `sender_latitude` DECIMAL(10, 8),
  `sender_longitude` DECIMAL(11, 8),
  `receiver_name` VARCHAR(100) NOT NULL,
  `receiver_phone` VARCHAR(20) NOT NULL,
  `receiver_email` VARCHAR(100),
  `receiver_address` TEXT NOT NULL,
  `receiver_city` VARCHAR(50) NOT NULL,
  `receiver_state` VARCHAR(50),
  `receiver_country` VARCHAR(50),
  `receiver_latitude` DECIMAL(10, 8),
  `receiver_longitude` DECIMAL(11, 8),
  `package_description` TEXT,
  `package_type` ENUM('documents', 'fragile', 'electronics', 'food', 'clothing', 'other') DEFAULT 'other',
  `weight_kg` DECIMAL(10, 2),
  `length_cm` DECIMAL(8, 2),
  `width_cm` DECIMAL(8, 2),
  `height_cm` DECIMAL(8, 2),
  `package_value` DECIMAL(12, 2),
  `currency` VARCHAR(3) DEFAULT 'NGN',
  `insurance_required` BOOLEAN DEFAULT FALSE,
  `insurance_amount` DECIMAL(12, 2),
  `delivery_type` ENUM('standard', 'express', 'same_day', 'scheduled') DEFAULT 'standard',
  `estimated_delivery_days` INT DEFAULT 3,
  `pickup_date` DATE NOT NULL,
  `scheduled_delivery_date` DATE,
  `delivery_instructions` TEXT,
  `special_instructions` TEXT,
  `status` ENUM('pending', 'booked', 'pickup_scheduled', 'picked_up', 'at_branch', 'in_transit', 'out_for_delivery', 'delivered', 'failed_delivery', 'returned') DEFAULT 'pending',
  `pickup_branch_id` INT,
  `delivery_branch_id` INT,
  `assigned_driver_id` INT,
  `signature_required` BOOLEAN DEFAULT FALSE,
  `signature_image` VARCHAR(255),
  `delivery_photo` VARCHAR(255),
  `failed_reason` TEXT,
  `attempt_count` INT DEFAULT 0,
  `total_cost` DECIMAL(12, 2),
  `payment_status` ENUM('pending', 'partial', 'paid', 'refunded') DEFAULT 'pending',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estimated_delivery_date` DATE GENERATED ALWAYS AS (DATE_ADD(pickup_date, INTERVAL estimated_delivery_days DAY)) STORED,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`pickup_branch_id`) REFERENCES `branches`(`id`) ON DELETE SET NULL,
  FOREIGN KEY (`delivery_branch_id`) REFERENCES `branches`(`id`) ON DELETE SET NULL,
  FOREIGN KEY (`assigned_driver_id`) REFERENCES `drivers`(`id`) ON DELETE SET NULL,
  INDEX `idx_tracking_number` (`tracking_number`),
  INDEX `idx_user_id` (`user_id`),
  INDEX `idx_status` (`status`),
  INDEX `idx_pickup_date` (`pickup_date`),
  INDEX `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 9. SHIPMENT TRACKING HISTORY TABLE
-- ============================================================
CREATE TABLE `shipment_tracking` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `shipment_id` INT NOT NULL,
  `status` ENUM('pending', 'booked', 'pickup_scheduled', 'picked_up', 'at_branch', 'in_transit', 'out_for_delivery', 'delivered', 'failed_delivery', 'returned') NOT NULL,
  `branch_id` INT,
  `driver_id` INT,
  `latitude` DECIMAL(10, 8),
  `longitude` DECIMAL(11, 8),
  `notes` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`shipment_id`) REFERENCES `shipments`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`branch_id`) REFERENCES `branches`(`id`) ON DELETE SET NULL,
  FOREIGN KEY (`driver_id`) REFERENCES `drivers`(`id`) ON DELETE SET NULL,
  INDEX `idx_shipment_id` (`shipment_id`),
  INDEX `idx_status` (`status`),
  INDEX `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 10. PAYMENTS TABLE
-- ============================================================
CREATE TABLE `payments` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `shipment_id` INT,
  `user_id` INT NOT NULL,
  `amount` DECIMAL(12, 2) NOT NULL,
  `currency` VARCHAR(3) DEFAULT 'NGN',
  `payment_method` ENUM('paystack', 'flutterwave', 'bank_transfer', 'cash_on_delivery', 'wallet') DEFAULT 'paystack',
  `transaction_id` VARCHAR(255) UNIQUE,
  `reference_number` VARCHAR(100) UNIQUE,
  `status` ENUM('pending', 'processing', 'completed', 'failed', 'refunded') DEFAULT 'pending',
  `payment_gateway_response` JSON,
  `notes` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`shipment_id`) REFERENCES `shipments`(`id`) ON DELETE SET NULL,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  INDEX `idx_user_id` (`user_id`),
  INDEX `idx_status` (`status`),
  INDEX `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 11. NOTIFICATIONS TABLE
-- ============================================================
CREATE TABLE `notifications` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT,
  `driver_id` INT,
  `admin_id` INT,
  `type` ENUM('shipment', 'payment', 'delivery', 'system', 'message', 'alert') DEFAULT 'system',
  `title` VARCHAR(200),
  `message` TEXT NOT NULL,
  `shipment_id` INT,
  `action_url` VARCHAR(255),
  `is_read` BOOLEAN DEFAULT FALSE,
  `read_at` TIMESTAMP NULL,
  `sent_via` ENUM('email', 'sms', 'whatsapp', 'push', 'in_app') DEFAULT 'in_app',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`driver_id`) REFERENCES `drivers`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`admin_id`) REFERENCES `admins`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`shipment_id`) REFERENCES `shipments`(`id`) ON DELETE CASCADE,
  INDEX `idx_user_id` (`user_id`),
  INDEX `idx_is_read` (`is_read`),
  INDEX `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 12. SUPPORT TICKETS TABLE
-- ============================================================
CREATE TABLE `support_tickets` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `ticket_number` VARCHAR(50) NOT NULL UNIQUE,
  `user_id` INT NOT NULL,
  `shipment_id` INT,
  `subject` VARCHAR(200) NOT NULL,
  `description` TEXT NOT NULL,
  `category` ENUM('billing', 'delivery', 'damage', 'lost', 'other', 'general') DEFAULT 'general',
  `priority` ENUM('low', 'medium', 'high', 'urgent') DEFAULT 'medium',
  `status` ENUM('open', 'in_progress', 'resolved', 'closed', 'reopened') DEFAULT 'open',
  `assigned_admin_id` INT,
  `attachments` JSON,
  `resolution_notes` TEXT,
  `resolved_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`shipment_id`) REFERENCES `shipments`(`id`) ON DELETE SET NULL,
  FOREIGN KEY (`assigned_admin_id`) REFERENCES `admins`(`id`) ON DELETE SET NULL,
  INDEX `idx_status` (`status`),
  INDEX `idx_user_id` (`user_id`),
  INDEX `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 13. REVIEWS & RATINGS TABLE
-- ============================================================
CREATE TABLE `reviews` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `shipment_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `driver_id` INT,
  `rating` INT CHECK (rating BETWEEN 1 AND 5),
  `title` VARCHAR(200),
  `comment` TEXT,
  `delivery_rating` INT,
  `packaging_rating` INT,
  `communication_rating` INT,
  `would_recommend` BOOLEAN DEFAULT TRUE,
  `status` ENUM('pending', 'approved', 'rejected', 'published') DEFAULT 'pending',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`shipment_id`) REFERENCES `shipments`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`driver_id`) REFERENCES `drivers`(`id`) ON DELETE SET NULL,
  INDEX `idx_shipment_id` (`shipment_id`),
  INDEX `idx_rating` (`rating`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 14. WALLET TABLE
-- ============================================================
CREATE TABLE `wallet` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT NOT NULL UNIQUE,
  `balance` DECIMAL(12, 2) DEFAULT 0.00,
  `currency` VARCHAR(3) DEFAULT 'NGN',
  `total_loaded` DECIMAL(12, 2) DEFAULT 0.00,
  `total_spent` DECIMAL(12, 2) DEFAULT 0.00,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  INDEX `idx_balance` (`balance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 15. WALLET TRANSACTIONS TABLE
-- ============================================================
CREATE TABLE `wallet_transactions` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `wallet_id` INT NOT NULL,
  `type` ENUM('credit', 'debit') DEFAULT 'debit',
  `amount` DECIMAL(12, 2) NOT NULL,
  `previous_balance` DECIMAL(12, 2),
  `new_balance` DECIMAL(12, 2),
  `description` VARCHAR(255),
  `shipment_id` INT,
  `payment_id` INT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`wallet_id`) REFERENCES `wallet`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`shipment_id`) REFERENCES `shipments`(`id`) ON DELETE SET NULL,
  FOREIGN KEY (`payment_id`) REFERENCES `payments`(`id`) ON DELETE SET NULL,
  INDEX `idx_wallet_id` (`wallet_id`),
  INDEX `idx_type` (`type`),
  INDEX `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 16. PROMO CODES TABLE
-- ============================================================
CREATE TABLE `promo_codes` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `code` VARCHAR(50) NOT NULL UNIQUE,
  `description` TEXT,
  `discount_type` ENUM('percentage', 'fixed') DEFAULT 'percentage',
  `discount_value` DECIMAL(10, 2) NOT NULL,
  `max_discount_amount` DECIMAL(12, 2),
  `min_order_amount` DECIMAL(12, 2),
  `max_usage` INT,
  `used_count` INT DEFAULT 0,
  `usage_per_user` INT DEFAULT 1,
  `valid_from` DATE,
  `valid_until` DATE,
  `applicable_to` ENUM('all', 'new_users', 'specific_services') DEFAULT 'all',
  `status` ENUM('active', 'inactive', 'expired') DEFAULT 'active',
  `created_by` INT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`created_by`) REFERENCES `admins`(`id`) ON DELETE SET NULL,
  INDEX `idx_code` (`code`),
  INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 17. USER PROMO CODE USAGE TABLE
-- ============================================================
CREATE TABLE `promo_code_usage` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `promo_code_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `shipment_id` INT,
  `discount_amount` DECIMAL(12, 2),
  `used_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`promo_code_id`) REFERENCES `promo_codes`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`shipment_id`) REFERENCES `shipments`(`id`) ON DELETE SET NULL,
  INDEX `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 18. SHIPMENT DOCUMENTS TABLE
-- ============================================================
CREATE TABLE `shipment_documents` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `shipment_id` INT NOT NULL,
  `document_type` ENUM('invoice', 'shipping_label', 'receipt', 'insurance', 'customs', 'other') DEFAULT 'other',
  `file_name` VARCHAR(255) NOT NULL,
  `file_path` VARCHAR(255) NOT NULL,
  `file_size` INT,
  `mime_type` VARCHAR(100),
  `uploaded_by` INT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`shipment_id`) REFERENCES `shipments`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`uploaded_by`) REFERENCES `users`(`id`) ON DELETE SET NULL,
  INDEX `idx_shipment_id` (`shipment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 19. ACTIVITY LOGS TABLE
-- ============================================================
CREATE TABLE `activity_logs` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_type` ENUM('customer', 'driver', 'admin') NOT NULL,
  `user_id` INT,
  `action` VARCHAR(255) NOT NULL,
  `entity_type` VARCHAR(100),
  `entity_id` INT,
  `ip_address` VARCHAR(45),
  `user_agent` VARCHAR(255),
  `changes` JSON,
  `status` ENUM('success', 'failed', 'pending') DEFAULT 'success',
  `description` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX `idx_user_id` (`user_id`),
  INDEX `idx_action` (`action`),
  INDEX `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 20. SETTINGS TABLE
-- ============================================================
CREATE TABLE `settings` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `setting_key` VARCHAR(100) NOT NULL UNIQUE,
  `setting_value` LONGTEXT,
  `type` ENUM('string', 'integer', 'boolean', 'json', 'array') DEFAULT 'string',
  `description` TEXT,
  `updated_by` INT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`updated_by`) REFERENCES `admins`(`id`) ON DELETE SET NULL,
  INDEX `idx_key` (`setting_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 21. BLOG/NEWS TABLE
-- ============================================================
CREATE TABLE `blog_posts` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `title` VARCHAR(255) NOT NULL,
  `slug` VARCHAR(255) NOT NULL UNIQUE,
  `content` LONGTEXT NOT NULL,
  `excerpt` VARCHAR(500),
  `featured_image` VARCHAR(255),
  `author_id` INT NOT NULL,
  `category` VARCHAR(100),
  `tags` JSON,
  `status` ENUM('draft', 'published', 'archived') DEFAULT 'draft',
  `view_count` INT DEFAULT 0,
  `meta_description` VARCHAR(255),
  `meta_keywords` VARCHAR(255),
  `published_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`author_id`) REFERENCES `admins`(`id`) ON DELETE CASCADE,
  INDEX `idx_status` (`status`),
  INDEX `idx_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 22. NEWSLETTER SUBSCRIBERS TABLE
-- ============================================================
CREATE TABLE `newsletter_subscribers` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  `first_name` VARCHAR(50),
  `last_name` VARCHAR(50),
  `status` ENUM('subscribed', 'unsubscribed', 'bounced') DEFAULT 'subscribed',
  `confirmation_token` VARCHAR(255),
  `confirmed_at` TIMESTAMP NULL,
  `subscribed_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `unsubscribed_at` TIMESTAMP NULL,
  INDEX `idx_email` (`email`),
  INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 23. CONTACT FORM SUBMISSIONS TABLE
-- ============================================================
CREATE TABLE `contact_submissions` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(20),
  `subject` VARCHAR(200) NOT NULL,
  `message` TEXT NOT NULL,
  `category` VARCHAR(50),
  `status` ENUM('new', 'read', 'responded', 'closed') DEFAULT 'new',
  `response` TEXT,
  `responded_by` INT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`responded_by`) REFERENCES `admins`(`id`) ON DELETE SET NULL,
  INDEX `idx_email` (`email`),
  INDEX `idx_status` (`status`),
  INDEX `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 24. REFERRAL PROGRAM TABLE
-- ============================================================
CREATE TABLE `referrals` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `referrer_id` INT NOT NULL,
  `referred_user_id` INT,
  `referral_code` VARCHAR(50) NOT NULL UNIQUE,
  `referral_link` VARCHAR(255),
  `bonus_amount` DECIMAL(12, 2),
  `status` ENUM('pending', 'approved', 'completed', 'expired') DEFAULT 'pending',
  `referred_at` TIMESTAMP NULL,
  `bonus_given_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`referrer_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`referred_user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL,
  INDEX `idx_referrer_id` (`referrer_id`),
  INDEX `idx_code` (`referral_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 25. DRIVER DOCUMENTS TABLE
-- ============================================================
CREATE TABLE `driver_documents` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `driver_id` INT NOT NULL,
  `document_type` ENUM('license', 'national_id', 'insurance', 'vehicle_registration', 'bank_details', 'other') DEFAULT 'other',
  `file_name` VARCHAR(255) NOT NULL,
  `file_path` VARCHAR(255) NOT NULL,
  `file_size` INT,
  `status` ENUM('pending', 'verified', 'rejected', 'expired') DEFAULT 'pending',
  `expiry_date` DATE,
  `uploaded_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `verified_at` TIMESTAMP NULL,
  `verified_by` INT,
  `rejection_reason` TEXT,
  FOREIGN KEY (`driver_id`) REFERENCES `drivers`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`verified_by`) REFERENCES `admins`(`id`) ON DELETE SET NULL,
  INDEX `idx_driver_id` (`driver_id`),
  INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- INSERT DEFAULT ROLES
-- ============================================================
INSERT INTO `roles` (`name`, `description`) VALUES
('customer', 'Regular customer user'),
('admin', 'Administrator with full access'),
('super_admin', 'Super administrator with all permissions'),
('driver', 'Delivery driver'),
('branch_manager', 'Branch manager');

-- ============================================================
-- INSERT SAMPLE SETTINGS
-- ============================================================
INSERT INTO `settings` (`setting_key`, `setting_value`, `type`, `description`) VALUES
('app_name', 'Consignment & Logistics Management System', 'string', 'Application name'),
('app_tagline', 'Fast, Reliable & Secure Shipping Solutions', 'string', 'Application tagline'),
('company_email', 'info@consignmentlogistics.com', 'string', 'Company email address'),
('company_phone', '+234 XXX XXX XXXX', 'string', 'Company phone number'),
('company_address', 'Lagos, Nigeria', 'string', 'Company address'),
('currency', 'NGN', 'string', 'Default currency'),
('timezone', 'Africa/Lagos', 'string', 'Default timezone'),
('items_per_page', '15', 'integer', 'Items per page for pagination'),
('enable_sms_notifications', 'false', 'boolean', 'Enable SMS notifications'),
('enable_whatsapp_notifications', 'false', 'boolean', 'Enable WhatsApp notifications'),
('standard_delivery_days', '3', 'integer', 'Days for standard delivery'),
('express_delivery_days', '1', 'integer', 'Days for express delivery'),
('maintenance_mode', 'false', 'boolean', 'Enable maintenance mode'),
('allow_user_registration', 'true', 'boolean', 'Allow new user registration');

-- ============================================================
-- CREATE INDEXES FOR BETTER PERFORMANCE
-- ============================================================
CREATE INDEX idx_shipments_user_status ON `shipments`(`user_id`, `status`);
CREATE INDEX idx_shipments_tracking_status ON `shipments`(`tracking_number`, `status`);
CREATE INDEX idx_payments_user_status ON `payments`(`user_id`, `status`);
CREATE INDEX idx_tracking_shipment_status ON `shipment_tracking`(`shipment_id`, `status`);
CREATE INDEX idx_notifications_user_read ON `notifications`(`user_id`, `is_read`);

-- ============================================================
-- DATABASE SETUP COMPLETE
-- ============================================================
