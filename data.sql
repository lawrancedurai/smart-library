-- =====================================================================
-- Smart Library Management System - Sample Seed Data
-- =====================================================================

USE smart_library_db;

-- 1. Insert Base Users (BCrypt hashed passwords)
-- admin123 -> $2a$10$wN1q8q7eGZ/5C2R2nKj/E.g4MfsG0g5q7j5m1aQY0U8P3K2Z5G9Xa
-- librarian123 -> $2a$10$wN1q8q7eGZ/5C2R2nKj/E.g4MfsG0g5q7j5m1aQY0U8P3K2Z5G9Xa
-- member123 -> $2a$10$wN1q8q7eGZ/5C2R2nKj/E.g4MfsG0g5q7j5m1aQY0U8P3K2Z5G9Xa

INSERT INTO users (id, username, password, email, full_name, phone_number, role, active) VALUES
(1, 'admin', '$2a$10$8.UnVuG9HHgffUDAlk8qfOuVGkqRzgVymGe07xd00DMxs.AQubh4a', 'admin@smartlibrary.com', 'Eleanor Vance', '+1 555-0100', 'ROLE_LIBRARIAN', TRUE),
(2, 'librarian', '$2a$10$8.UnVuG9HHgffUDAlk8qfOuVGkqRzgVymGe07xd00DMxs.AQubh4a', 'librarian@smartlibrary.com', 'Marcus Wright', '+1 555-0101', 'ROLE_LIBRARIAN', TRUE),
(3, 'alice', '$2a$10$8.UnVuG9HHgffUDAlk8qfOuVGkqRzgVymGe07xd00DMxs.AQubh4a', 'alice.johnson@university.edu', 'Alice Johnson', '+1 555-0201', 'ROLE_MEMBER', TRUE),
(4, 'bob', '$2a$10$8.UnVuG9HHgffUDAlk8qfOuVGkqRzgVymGe07xd00DMxs.AQubh4a', 'prof.bob@university.edu', 'Dr. Robert Smith', '+1 555-0202', 'ROLE_MEMBER', TRUE),
(5, 'clara', '$2a$10$8.UnVuG9HHgffUDAlk8qfOuVGkqRzgVymGe07xd00DMxs.AQubh4a', 'clara.davis@gmail.com', 'Clara Davis', '+1 555-0203', 'ROLE_MEMBER', TRUE),
(6, 'david', '$2a$10$8.UnVuG9HHgffUDAlk8qfOuVGkqRzgVymGe07xd00DMxs.AQubh4a', 'david.miller@university.edu', 'David Miller', '+1 555-0204', 'ROLE_MEMBER', TRUE);

-- 2. Insert Librarians
INSERT INTO librarians (id, employee_id, department) VALUES
(1, 'LIB-ADM-001', 'Head Administration'),
(2, 'LIB-AST-002', 'Circulation Desk');

-- 3. Insert Members
INSERT INTO members (id, membership_number, membership_type, membership_start_date, membership_expiry_date, max_allowed_books, status, address) VALUES
(3, 'LIB-M-1001', 'STUDENT', CURDATE() - INTERVAL 60 DAY, CURDATE() + INTERVAL 305 DAY, 3, 'ACTIVE', 'Room 402, North Dormitory'),
(4, 'LIB-M-1002', 'FACULTY', CURDATE() - INTERVAL 120 DAY, CURDATE() + INTERVAL 245 DAY, 7, 'ACTIVE', 'Faculty Office 315, Science Hall'),
(5, 'LIB-M-1003', 'GENERAL', CURDATE() - INTERVAL 90 DAY, CURDATE() + INTERVAL 275 DAY, 5, 'ACTIVE', '742 Evergreen Terrace'),
(6, 'LIB-M-1004', 'STUDENT', CURDATE() - INTERVAL 30 DAY, CURDATE() + INTERVAL 335 DAY, 3, 'ACTIVE', 'Room 210, West Dormitory');

-- 4. Insert Books
INSERT INTO books (id, isbn, title, author, category, publisher, publication_year, description, cover_image_url, shelf_location, total_copies, available_copies) VALUES
(1, '978-0132350884', 'Clean Code: A Handbook of Agile Software Craftsmanship', 'Robert C. Martin', 'Computer Science', 'Prentice Hall', 2008, 'Even bad code can function. But if code isn\'t clean, it can bring a development organization to its knees.', 'https://images.unsplash.com/photo-1532012164546-f432f2e3777f?auto=format&fit=crop&w=400&q=80', 'CS-A1-04', 4, 3),
(2, '978-0201633610', 'Design Patterns: Elements of Reusable Object-Oriented Software', 'Erich Gamma, Richard Helm, Ralph Johnson, John Vlissides', 'Computer Science', 'Addison-Wesley', 1994, 'Capturing a wealth of experience about the design of object-oriented software, four top-notch designers present a catalog of simple and succinct solutions.', 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=400&q=80', 'CS-A2-11', 3, 2),
(3, '978-0262033848', 'Introduction to Algorithms, 3rd Edition', 'Thomas H. Cormen, Charles E. Leiserson, Ronald L. Rivest, Clifford Stein', 'Computer Science', 'MIT Press', 2009, 'Uniquely combines rigor and comprehensiveness. Detailed algorithms and proofs.', 'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=400&q=80', 'CS-B3-02', 2, 1),
(4, '978-0061120084', 'To Kill a Mockingbird', 'Harper Lee', 'Literature', 'J. B. Lippincott & Co.', 1960, 'The unforgettable novel of a childhood in a sleepy Southern town and the crisis of conscience that rocked it.', 'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&w=400&q=80', 'LIT-C1-09', 5, 5),
(5, '978-0553380163', 'A Brief History of Time', 'Stephen Hawking', 'Science', 'Bantam Books', 1988, 'A landmark volume in science writing by one of the great minds of our time.', 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?auto=format&fit=crop&w=400&q=80', 'SCI-D2-07', 3, 3),
(6, '978-0062316097', 'Sapiens: A Brief History of Humankind', 'Yuval Noah Harari', 'History', 'Harper', 2014, 'One hundred thousand years ago, at least six different species of humans inhabited Earth. Yet today there is only one.', 'https://images.unsplash.com/photo-1461360370896-922624d12aa1?auto=format&fit=crop&w=400&q=80', 'HIST-E4-15', 3, 2),
(7, '978-0374533557', 'Thinking, Fast and Slow', 'Daniel Kahneman', 'Philosophy', 'Farrar, Straus and Giroux', 2011, 'The groundbreaking book on the two systems that drive the way we think.', 'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?auto=format&fit=crop&w=400&q=80', 'PHIL-F1-03', 2, 0);

-- 5. Insert Book Copies
INSERT INTO book_copies (id, copy_barcode, book_id, status, condition_notes, acquisition_date) VALUES
(1, '978-0132350884-C01', 1, 'BORROWED', 'Good condition', CURDATE() - INTERVAL 100 DAY),
(2, '978-0132350884-C02', 1, 'AVAILABLE', 'Good condition', CURDATE() - INTERVAL 100 DAY),
(3, '978-0132350884-C03', 1, 'AVAILABLE', 'Good condition', CURDATE() - INTERVAL 100 DAY),
(4, '978-0132350884-C04', 1, 'AVAILABLE', 'Good condition', CURDATE() - INTERVAL 100 DAY),
(5, '978-0201633610-C01', 2, 'BORROWED', 'Good condition', CURDATE() - INTERVAL 90 DAY),
(6, '978-0201633610-C02', 2, 'AVAILABLE', 'Good condition', CURDATE() - INTERVAL 90 DAY),
(7, '978-0201633610-C03', 2, 'AVAILABLE', 'Good condition', CURDATE() - INTERVAL 90 DAY),
(8, '978-0262033848-C01', 3, 'BORROWED', 'Good condition', CURDATE() - INTERVAL 80 DAY),
(9, '978-0262033848-C02', 3, 'AVAILABLE', 'Good condition', CURDATE() - INTERVAL 80 DAY),
(10, '978-0061120084-C01', 4, 'AVAILABLE', 'Pristine', CURDATE() - INTERVAL 50 DAY),
(11, '978-0061120084-C02', 4, 'AVAILABLE', 'Pristine', CURDATE() - INTERVAL 50 DAY),
(12, '978-0061120084-C03', 4, 'AVAILABLE', 'Pristine', CURDATE() - INTERVAL 50 DAY),
(13, '978-0061120084-C04', 4, 'AVAILABLE', 'Pristine', CURDATE() - INTERVAL 50 DAY),
(14, '978-0061120084-C05', 4, 'AVAILABLE', 'Pristine', CURDATE() - INTERVAL 50 DAY),
(15, '978-0553380163-C01', 5, 'AVAILABLE', 'Good condition', CURDATE() - INTERVAL 40 DAY),
(16, '978-0553380163-C02', 5, 'AVAILABLE', 'Good condition', CURDATE() - INTERVAL 40 DAY),
(17, '978-0553380163-C03', 5, 'AVAILABLE', 'Good condition', CURDATE() - INTERVAL 40 DAY),
(18, '978-0062316097-C01', 6, 'BORROWED', 'Good condition', CURDATE() - INTERVAL 30 DAY),
(19, '978-0062316097-C02', 6, 'AVAILABLE', 'Good condition', CURDATE() - INTERVAL 30 DAY),
(20, '978-0062316097-C03', 6, 'AVAILABLE', 'Good condition', CURDATE() - INTERVAL 30 DAY),
(21, '978-0374533557-C01', 7, 'BORROWED', 'Minor cover wear', CURDATE() - INTERVAL 60 DAY),
(22, '978-0374533557-C02', 7, 'BORROWED', 'Good condition', CURDATE() - INTERVAL 60 DAY);

-- 6. Insert Loans
INSERT INTO loans (id, loan_number, member_id, book_id, book_copy_id, borrow_date, due_date, return_date, status, notes) VALUES
(1, 'LN-20261020-0001', 3, 1, 1, CURDATE() - INTERVAL 7 DAY, CURDATE() + INTERVAL 7 DAY, NULL, 'ISSUED', 'Standard student loan'),
(2, 'LN-20261022-0002', 4, 2, 5, CURDATE() - INTERVAL 4 DAY, CURDATE() + INTERVAL 10 DAY, NULL, 'ISSUED', 'Faculty research reference'),
(3, 'LN-20261005-0003', 5, 3, 8, CURDATE() - INTERVAL 22 DAY, CURDATE() - INTERVAL 8 DAY, NULL, 'ISSUED', 'Overdue loan'),
(4, 'LN-20261015-0004', 6, 6, 18, CURDATE() - INTERVAL 12 DAY, CURDATE() + INTERVAL 2 DAY, NULL, 'ISSUED', 'Student loan'),
(5, 'LN-20261018-0005', 3, 7, 21, CURDATE() - INTERVAL 9 DAY, CURDATE() + INTERVAL 5 DAY, NULL, 'ISSUED', 'Study reference'),
(6, 'LN-20261019-0006', 4, 7, 22, CURDATE() - INTERVAL 8 DAY, CURDATE() + INTERVAL 6 DAY, NULL, 'ISSUED', 'Seminar reading');

-- 7. Insert Fines
INSERT INTO fines (id, fine_number, loan_id, member_id, amount, paid_amount, fine_date, status, reason) VALUES
(1, 'FN-20261025-0001', 3, 5, 8.00, 0.00, CURDATE() - INTERVAL 8 DAY, 'UNPAID', 'Overdue by 8 days for Introduction to Algorithms');

-- 8. Insert Reservations
INSERT INTO reservations (id, reservation_number, member_id, book_id, reservation_date, expiry_date, status, queue_position, notes) VALUES
(1, 'RES-20261025-0001', 6, 7, NOW() - INTERVAL 2 DAY, NOW() + INTERVAL 5 DAY, 'PENDING', 1, 'Course reading requirement');

-- 9. Insert Notifications
INSERT INTO notifications (id, user_id, title, message, type, is_read, created_at) VALUES
(1, 3, 'Welcome to Smart Library!', 'Your student membership has been registered. You can borrow up to 3 books.', 'GENERAL', TRUE, NOW() - INTERVAL 60 DAY),
(2, 5, 'Urgent: Book Overdue', 'Your loan for Introduction to Algorithms was due 8 days ago. Overdue fine of $8.00 has accrued.', 'OVERDUE_ALERT', FALSE, NOW() - INTERVAL 8 DAY),
(3, 6, 'Reservation Placed', 'You are #1 in queue for Thinking, Fast and Slow. We will alert you when a copy returns.', 'GENERAL', FALSE, NOW() - INTERVAL 2 DAY);
