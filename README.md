# Library Management Database System

A complete relational database management system for library operations built with MySQL.

## Overview

This project implements a comprehensive Library Management System database that handles:

- Member registration and management
- Book cataloging with author information
- Physical book copy tracking
- Borrowing and return transactions

## Database Schema

### Tables Structure

1. **Members** - Library member information
2. **Authors** - Author details
3. **Books** - Book catalog information
4. **BookAuthors** - Many-to-many relationship between books and authors
5. **BookCopies** - Physical copies of books
6. **BorrowRecords** - Borrowing transaction history

### Key Features

- ✅ **Primary Keys** on all tables
- ✅ **Foreign Key Constraints** with CASCADE delete
- ✅ **Unique Constraints** on email and ISBN
- ✅ **NOT NULL Constraints** on essential fields
- ✅ **One-to-Many Relationships** (Members→BorrowRecords, Books→BookCopies)
- ✅ **Many-to-Many Relationships** (Books↔Authors)

## Installation

1. Run the SQL script in MySQL:

```sql
source answer.sql
```

2. The database will be created with sample data for testing.

## Usage

The database supports standard library operations:

- Register new members
- Add books and authors
- Track book copies
- Record borrowing transactions
- Manage returns

## Sample Queries

```sql
-- Find all books by a specific author
SELECT b.title, a.first_name, a.last_name
FROM Books b
JOIN BookAuthors ba ON b.book_id = ba.book_id
JOIN Authors a ON ba.author_id = a.author_id
WHERE a.first_name = 'George' AND a.last_name = 'Orwell';

-- Check available book copies
SELECT b.title, COUNT(bc.copy_id) as available_copies
FROM Books b
JOIN BookCopies bc ON b.book_id = bc.book_id
WHERE bc.status = 'available'
GROUP BY b.book_id, b.title;
```
