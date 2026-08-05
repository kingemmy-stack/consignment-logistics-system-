# Professional Consignment & Logistics Management System

A modern, enterprise-level consignment and logistics management system built with **PHP 8+, MySQL, HTML5, CSS3, JavaScript, and Bootstrap 5**. Optimized for shared hosting on cPanel.

## Features

### Public Website
- Responsive homepage with hero banner
- Shipment tracking (tracking number or QR code)
- Book shipment module
- Branch locator with Google Maps
- Pricing calculator
- FAQ, Blog, News sections
- Contact forms and support

### Customer Dashboard
- Book consignments
- Track shipments in real-time
- View shipment history
- Download invoices
- Manage addresses
- Upload documents
- Support tickets
- Payment history

### Admin Dashboard
- Shipment management
- Customer management
- Driver management
- Branch management
- Vehicle management
- Reports and analytics
- Payment management
- Website settings

### Driver Dashboard
- View assigned deliveries
- Navigate with Google Maps
- Scan QR codes
- Update shipment status
- Capture signatures
- Upload delivery photos

## Technology Stack

- **Backend:** PHP 8+
- **Database:** MySQL
- **Frontend:** HTML5, CSS3, JavaScript (Vanilla + jQuery)
- **Framework:** Bootstrap 5
- **APIs:** Google Maps API, Payment Gateways (Paystack, Flutterwave)
- **Hosting:** cPanel shared hosting compatible

## Payment Gateways

- Paystack
- Flutterwave
- Bank Transfer
- Cash on Delivery

## Notifications

- Email
- SMS (optional)
- WhatsApp (optional)

## Installation

See [INSTALLATION.md](docs/INSTALLATION.md) for detailed setup instructions.

## Documentation

- [Installation Guide](docs/INSTALLATION.md)
- [Configuration Guide](docs/CONFIGURATION.md)
- [API Documentation](docs/API.md)
- [Database Schema](docs/DATABASE.md)
- [User Roles & Permissions](docs/ROLES.md)

## Folder Structure

```
consignment-logistics-system-/
├── assets/              # CSS, JS, Images
├── uploads/             # User uploads
├── includes/            # Common includes
├── config/              # Configuration files
├── controllers/         # Business logic
├── models/              # Database models
├── views/               # HTML templates
├── admin/               # Admin dashboard
├── customer/            # Customer dashboard
├── driver/              # Driver dashboard
├── api/                 # API endpoints
├── database/            # SQL files
├── docs/                # Documentation
└── index.php            # Entry point
```

## Security Features

- Password hashing (bcrypt)
- Prepared SQL statements
- CSRF protection
- XSS prevention
- File upload validation
- Session management
- Role-based access control (RBAC)
- Activity logging
- HTTPS support

## Additional Features

- Light/Dark mode
- Multi-language support
- Multi-currency support
- QR Code generation
- Barcode generation
- Printable shipping labels
- Progressive Web App (PWA)
- Live chat support
- Customer reviews
- Referral system
- Promo codes
- Newsletter subscription

## License

Proprietary - All rights reserved

## Support

For support, contact: support@consignmentlogistics.com

## Authors

King Emmy (@kingemmy-stack)

---

**Version:** 1.0.0  
**Last Updated:** 2026-08-05
