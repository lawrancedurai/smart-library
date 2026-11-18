-- =====================================================================
-- Smart Library Management System - Database Schema (MySQL 8.0 / 9.x)
-- =====================================================================

DROP DATABASE IF EXISTS smart_library_db;
CREATE DATABASE smart_library_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE smart_library_db;

-- 1. Base Users Table (Inheritance: Joined Table Strategy)
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20),
    role VARCHAR(20) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_user_username (username),
    INDEX idx_user_role (role)
) ENGINE=InnoDB;

-- 2. Librarians (Subclass of users)
CREATE TABLE librarians (
    id BIGINT PRIMARY KEY,
    employee_id VARCHAR(30) UNIQUE,
    department VARCHAR(50),
    CONSTRAINT fk_librarian_user FOREIGN KEY (id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 3. Members (Subclass of users)
CREATE TABLE members (
    id BIGINT PRIMARY KEY,
    membership_number VARCHAR(30) UNIQUE,
    membership_type VARCHAR(20) NOT NULL DEFAULT 'GENERAL',
    membership_start_date DATE,
    membership_expiry_date DATE,
    max_allowed_books INT NOT NULL DEFAULT 5,
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    address VARCHAR(255),
    CONSTRAINT fk_member_user FOREIGN KEY (id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_member_status (status),
    INDEX idx_member_number (membership_number)
) ENGINE=InnoDB;

-- 4. Books Table
CREATE TABLE books (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(150) NOT NULL,
    category VARCHAR(80) NOT NULL,
    publisher VARCHAR(150),
    publication_year INT,
    description TEXT,
    cover_image_url VARCHAR(500),
    shelf_location VARCHAR(50),
    total_copies INT NOT NULL DEFAULT 1,
    available_copies INT NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_book_isbn (isbn),
    INDEX idx_book_category (category),
    INDEX idx_book_title (title)
) ENGINE=InnoDB;

-- 5. Book Copies (Physical Inventory Tracking)
CREATE TABLE book_copies (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    copy_barcode VARCHAR(50) NOT NULL UNIQUE,
    book_id BIGINT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'AVAILABLE',
    condition_notes VARCHAR(255) DEFAULT 'Good condition',
    acquisition_date DATE,
    CONSTRAINT fk_copy_book FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE,
    INDEX idx_copy_status (status),
    INDEX idx_copy_barcode (copy_barcode)
) ENGINE=InnoDB;

-- 6. Loans Table (Borrowing and Returns)
CREATE TABLE loans (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    loan_number VARCHAR(40) NOT NULL UNIQUE,
    member_id BIGINT NOT NULL,
    book_id BIGINT NOT NULL,
    book_copy_id BIGINT,
    borrow_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    status VARCHAR(20) NOT NULL DEFAULT 'ISSUED',
    notes VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_loan_member FOREIGN KEY (member_id) REFERENCES members(id),
    CONSTRAINT fk_loan_book FOREIGN KEY (book_id) REFERENCES books(id),
    CONSTRAINT fk_loan_copy FOREIGN KEY (book_copy_id) REFERENCES book_copies(id),
    INDEX idx_loan_status (status),
    INDEX idx_loan_due_date (due_date)
) ENGINE=InnoDB;

-- 7. Reservations Table
CREATE TABLE reservations (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    reservation_number VARCHAR(40) NOT NULL UNIQUE,
    member_id BIGINT NOT NULL,
    book_id BIGINT NOT NULL,
    reservation_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    expiry_date TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    queue_position INT DEFAULT 1,
    notes VARCHAR(255),
    CONSTRAINT fk_reservation_member FOREIGN KEY (member_id) REFERENCES members(id),
    CONSTRAINT fk_reservation_book FOREIGN KEY (book_id) REFERENCES books(id),
    INDEX idx_reservation_status (status)
) ENGINE=InnoDB;

-- 8. Fines Table
CREATE TABLE fines (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    fine_number VARCHAR(40) NOT NULL UNIQUE,
    loan_id BIGINT NOT NULL,
    member_id BIGINT NOT NULL,
    amount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    paid_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    fine_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'UNPAID',
    reason VARCHAR(255),
    waive_reason VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_fine_loan FOREIGN KEY (loan_id) REFERENCES loans(id),
    CONSTRAINT fk_fine_member FOREIGN KEY (member_id) REFERENCES members(id),
    INDEX idx_fine_status (status)
) ENGINE=InnoDB;

-- 9. Payments Table
CREATE TABLE payments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    payment_number VARCHAR(40) NOT NULL UNIQUE,
    fine_id BIGINT NOT NULL,
    member_id BIGINT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(20) NOT NULL,
    payment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    transaction_reference VARCHAR(100),
    collected_by BIGINT,
    CONSTRAINT fk_payment_fine FOREIGN KEY (fine_id) REFERENCES fines(id),
    CONSTRAINT fk_payment_member FOREIGN KEY (member_id) REFERENCES members(id),
    CONSTRAINT fk_payment_collector FOREIGN KEY (collected_by) REFERENCES users(id)
) ENGINE=InnoDB;

-- 10. Notifications Table
CREATE TABLE notifications (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    title VARCHAR(150) NOT NULL,
    message TEXT NOT NULL,
    type VARCHAR(30) NOT NULL DEFAULT 'GENERAL',
    is_read BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_notification_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_notif_user_read (user_id, is_read)
) ENGINE=InnoDB;
