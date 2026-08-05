<?php
/**
 * Index File - Application Entry Point
 */

// Start session
session_start();

// Include configuration
require_once 'config/config.php';

// Include database class
require_once 'includes/Database.php';

// Simple routing
$request = isset($_GET['page']) ? $_GET['page'] : 'home';
$action = isset($_GET['action']) ? $_GET['action'] : '';

// Load appropriate view
switch ($request) {
    case 'home':
        include 'views/home.php';
        break;
    case 'about':
        include 'views/about.php';
        break;
    case 'services':
        include 'views/services.php';
        break;
    case 'booking':
        include 'views/booking.php';
        break;
    case 'tracking':
        include 'views/tracking.php';
        break;
    case 'contact':
        include 'views/contact.php';
        break;
    case 'login':
        include 'views/login.php';
        break;
    case 'register':
        include 'views/register.php';
        break;
    case 'dashboard':
        if (!isset($_SESSION['user_id'])) {
            header('Location: ?page=login');
            exit();
        }
        include 'customer/dashboard.php';
        break;
    case 'admin':
        if (!isset($_SESSION['admin_id'])) {
            header('Location: ?page=login&role=admin');
            exit();
        }
        include 'admin/dashboard.php';
        break;
    case 'driver':
        if (!isset($_SESSION['driver_id'])) {
            header('Location: ?page=login&role=driver');
            exit();
        }
        include 'driver/dashboard.php';
        break;
    default:
        include 'views/home.php';
}
