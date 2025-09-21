-- library_db.sql
-- Simple Library Management System Schema


-- Create new database
CREATE DATABASE library_db;
USE library_db;

-- ---------------------------------------------------
-- Table: Members
-- ---------------------------------------------------
CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    join_date DATE NOT NULL
);

-- ---------------------------------------------------
-- Table: Authors
-- ---------------------------------------------------
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL
);

-- ---------------------------------------------------
-- Table: Books
-- ---------------------------------------------------
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    published_year INT
);

-- ---------------------------------------------------
-- Table: BookAuthors (Many-to-Many: Books <-> Authors)
-- ---------------------------------------------------
CREATE TABLE BookAuthors (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE CASCADE
);

-- ---------------------------------------------------
-- Table: BookCopies (physical copies of books)
-- ---------------------------------------------------
CREATE TABLE BookCopies (
    copy_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'available', -- available, borrowed, reserved
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE
);

-- ---------------------------------------------------
-- Table: BorrowRecords (who borrows which copy)
-- ---------------------------------------------------
CREATE TABLE BorrowRecords (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    copy_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (copy_id) REFERENCES BookCopies(copy_id) ON DELETE CASCADE
);

-- ---------------------------------------------------
-- Sample Data
-- ---------------------------------------------------
INSERT INTO Members (first_name, last_name, email, phone, join_date)
VALUES 
('Alice', 'Johnson', 'alice@example.com', '1234567890', '2024-01-15'),
('Bob', 'Smith', 'bob@example.com', '9876543210', '2024-02-10');

INSERT INTO Authors (first_name, last_name)
VALUES 
('George', 'Orwell'),
('Jane', 'Austen');

INSERT INTO Books (title, isbn, published_year)
VALUES 
('1984', '9780451524935', 1949),
('Pride and Prejudice', '9780141439518', 1813);

INSERT INTO BookAuthors (book_id, author_id)
VALUES 
(1, 1), -- 1984 by George Orwell
(2, 2); -- Pride and Prejudice by Jane Austen

INSERT INTO BookCopies (book_id, status)
VALUES 
(1, 'available'),
(1, 'borrowed'),
(2, 'available');
