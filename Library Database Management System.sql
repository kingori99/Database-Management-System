-- 1. Patrons Table: Stores information about library members.
CREATE TABLE Patrons (
    patron_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    address VARCHAR(255),
    membership_date DATE NOT NULL
);

-- 2. Books Table: Stores information about books in the library.
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    publication_date DATE,
    genre VARCHAR(50),
    total_copies INT NOT NULL,
    available_copies INT NOT NULL,
    CHECK (total_copies >= 0),
    CHECK (available_copies >= 0 AND available_copies <= total_copies)
);

-- 3. Loans Table:  Stores information about book loans.
CREATE TABLE Loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    patron_id INT,
    book_id INT,
    loan_date DATE NOT NULL,
    return_date DATE,
    due_date DATE NOT NULL,
    FOREIGN KEY (patron_id) REFERENCES Patrons(patron_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    CHECK (loan_date <= due_date),
    CHECK (return_date IS NULL OR return_date >= loan_date)
);

-- 4. Authors Table: Stores the details of the authors.
CREATE TABLE Authors (
  author_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  biography TEXT
);

-- 5. BookAuthors Table:  Many-to-Many relationship between Books and Authors
CREATE TABLE BookAuthors (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

-- 6. Categories Table: Stores the details of the book categories.
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- 7. BookCategories Table: Many-to-Many relationship between Books and Categories
CREATE TABLE BookCategories (
    book_id INT,
    category_id INT,
    PRIMARY KEY (book_id, category_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);
