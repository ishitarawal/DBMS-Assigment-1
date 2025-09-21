CREATE DATABASE Library;
USE Library;

-- Create Authors Table
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(100)
);

-- Create Books Table
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(255),
    AuthorID INT,
    PublicationYear INT,
    IsAvailable BOOLEAN,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

-- Create Members Table
CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Email VARCHAR(100)
);

-- Create Borrowings Table
CREATE TABLE Borrowings (
    BorrowingID INT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    DateBorrowed DATE,
    DueDate DATE,
    DateReturned DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- Insert data into Authors
INSERT INTO Authors (AuthorID, AuthorName) VALUES
(1, 'J.R.R. Tolkien'),
(2, 'Jane Austen'),
(3, 'George Orwell'),
(4, 'Harper Lee'),
(5, 'Stephen King');

-- Insert data into Books
INSERT INTO Books (BookID, Title, AuthorID, PublicationYear, IsAvailable) VALUES
(101, 'The Lord of the Rings', 1, 1954, FALSE),
(102, 'Pride and Prejudice', 2, 1813, TRUE),
(103, '1984', 3, 1949, FALSE),
(104, 'To Kill a Mockingbird', 4, 1960, TRUE),
(105, 'The Shining', 5, 1977, FALSE),
(106, 'The Hobbit', 1, 1937, TRUE),
(107, 'Emma', 2, 1815, TRUE),
(108, 'Animal Farm', 3, 1945, TRUE);

-- Insert data into Members
INSERT INTO Members (MemberID, FirstName, LastName, Email) VALUES
(1, 'John', 'Smith', 'john.s@example.com'),
(2, 'Emily', 'Jones', 'emily.j@example.com'),
(3, 'Michael', 'Brown', 'michael.b@example.com'),
(4, 'Sarah', 'Davis', 'sarah.d@example.com'),
(5, 'Chris', 'Wilson', 'chris.w@example.com');

-- Insert data into Borrowings
INSERT INTO Borrowings (BorrowingID, BookID, MemberID, DateBorrowed, DueDate, DateReturned) VALUES
(1, 101, 1, '2025-09-01', '2025-09-22', NULL),
(2, 103, 2, '2025-08-25', '2025-09-15', '2025-09-14'),
(3, 105, 3, '2025-09-05', '2025-09-26', NULL),
(4, 102, 4, '2025-09-10', '2025-10-01', NULL),
(5, 108, 1, '2025-09-15', '2025-10-06', NULL);

-- Query 1: Find all books that are currently not available.
SELECT Title, AuthorName
FROM Books
JOIN Authors ON Books.AuthorID = Authors.AuthorID
WHERE IsAvailable = FALSE;

-- Query 2: List all books borrowed by a specific member (John Smith), ordered by the date they were borrowed.
SELECT B.Title, Bo.DateBorrowed
FROM Borrowings Bo
JOIN Books B ON Bo.BookID = B.BookID
JOIN Members M ON Bo.MemberID = M.MemberID
WHERE M.FirstName = 'John' AND M.LastName = 'Smith'
ORDER BY Bo.DateBorrowed;

-- Query 3: Find all books that are overdue.
SELECT B.Title, M.FirstName, M.LastName, Bo.DueDate
FROM Borrowings Bo
JOIN Books B ON Bo.BookID = B.BookID
JOIN Members M ON Bo.MemberID = M.MemberID
WHERE Bo.DateReturned IS NULL AND Bo.DueDate < CURRENT_DATE;

-- Query 4: Count the total number of books written by a specific author (J.R.R. Tolkien).
SELECT COUNT(BookID) AS NumberOfBooks
FROM Books
JOIN Authors ON Books.AuthorID = Authors.AuthorID
WHERE Authors.AuthorName = 'J.R.R. Tolkien';

-- Query 5: List all authors who have books published after the year 1950.
SELECT DISTINCT A.AuthorName
FROM Authors A
JOIN Books B ON A.AuthorID = B.AuthorID
WHERE B.PublicationYear > 1950;