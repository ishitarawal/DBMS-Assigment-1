# Library Management System

## Project Overview

This project implements a mini database system for a Library Management System. It demonstrates fundamental database concepts including schema design, table creation, data insertion, and data retrieval using SQL queries. The system is designed to manage information about books, authors, library members, and borrowing records.

## Database Design

The database schema is designed with four main entities (tables) and their relationships:

1.  **Authors:** Stores information about the authors of the books.
    * `AuthorID` (Primary Key)
    * `AuthorName`
2.  **Books:** Contains details about the books available in the library.
    * `BookID` (Primary Key)
    * `Title`
    * `AuthorID` (Foreign Key referencing `Authors`)
    * `PublicationYear`
    * `IsAvailable` (Boolean indicating if the book is currently in the library)
3.  **Members:** Holds information about registered library members.
    * `MemberID` (Primary Key)
    * `FirstName`
    * `LastName`
    * `Email`
4.  **Borrowings:** Records each instance of a book being borrowed by a member.
    * `BorrowingID` (Primary Key)
    * `BookID` (Foreign Key referencing `Books`)
    * `MemberID` (Foreign Key referencing `Members`)
    * `DateBorrowed`
    * `DueDate`
    * `DateReturned`


## SQL Script (`library_management.sql`)

The `library_management.sql` file contains all the SQL commands for setting up and querying the database:

* **`CREATE DATABASE LibraryDB;`**: Command to create the database (you might need to run this separately in your SQL client before running the rest of the script).
* **`CREATE TABLE` statements**: Definitions for all four tables (`Authors`, `Books`, `Members`, `Borrowings`), including primary and foreign key constraints.
* **`INSERT INTO` statements**: Populates the tables with a minimum of 20 rows of sample data across the entities, ensuring realistic scenarios.
* **Meaningful Queries**: Five distinct SQL queries demonstrating various data retrieval operations.

### Meaningful Queries Explained:

1.  **Find all books that are currently not available.**
    * This query joins `Books` and `Authors` to list the title and author of all books marked as `IsAvailable = FALSE`.
2.  **List all books borrowed by a specific member (John Smith), ordered by the date they were borrowed.**
    * This query involves joining `Borrowings`, `Books`, and `Members` tables to retrieve borrowing details for a particular member, ordered chronologically.
3.  **Find all books that are overdue.**
    * This query identifies books that have not yet been returned (`DateReturned IS NULL`) and whose `DueDate` has passed (`DueDate < CURRENT_DATE`).
4.  **Count the total number of books written by a specific author (J.R.R. Tolkien).**
    * This query uses a `JOIN` and the `COUNT` aggregate function to determine how many books a specific author has in the database.
5.  **List all authors who have books published after the year 1950.**
    * This query uses `DISTINCT` with a `JOIN` to list unique author names who have published books in the latter half of the 20th century or later.

## Demo Video
* Link: 
