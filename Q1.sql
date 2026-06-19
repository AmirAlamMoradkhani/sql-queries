 Table: members
---------------------------------------------------------------- */
CREATE TABLE members (
    member_id        INT PRIMARY KEY,
    name             VARCHAR(50) NOT NULL,
    membership_type  VARCHAR(20) NOT NULL
);

INSERT INTO members (member_id, name, membership_type) VALUES
(1, 'Ali',      'Regular'),
(2, 'Sara',     'Premium'),
(3, 'Reza',     'Regular'),
(4, 'Maryam',   'Premium'),
(5, 'Nima',     'Regular');

/* --------------------------------------------------------------
   2.  Table: books
---------------------------------------------------------------- */
CREATE TABLE books (
    book_id   INT PRIMARY KEY,
    title     VARCHAR(100) NOT NULL,
    author    VARCHAR(100) NOT NULL
);

INSERT INTO books (book_id, title, author) VALUES
(201, 'Databases',          'Dr. Smith'),
(202, 'Calculus Basics',    'Dr. Brown'),
(203, 'Algebra Mastery',    'Dr. White'),
(204, 'Physics Lab',        'Dr. Green'),
(205, 'AI for Beginners',   'Dr. Black'),
(206, 'Machine Learning',   'Dr. Black');

/* --------------------------------------------------------------
   3.  Table: borrowings
   –  Foreign keys point to members & books
---------------------------------------------------------------- */
CREATE TABLE borrowings (
    borrowing_id  INT PRIMARY KEY,
    member_id     INT NOT NULL,
    book_id       INT NOT NULL,
    borrow_date   DATE NOT NULL,

    CONSTRAINT fk_borrowings_member
        FOREIGN KEY (member_id) REFERENCES members(member_id),

    CONSTRAINT fk_borrowings_book
        FOREIGN KEY (book_id)   REFERENCES books(book_id)
);

INSERT INTO borrowings (borrowing_id, member_id, book_id, borrow_date) VALUES
(101, 1, 201, '2023-09-01'),
(102, 2, 202, '2023-09-03'),
(103, 2, 203, '2024-01-10'),
(104, 5, 204, '2023-09-05'),
(105, 3, 205, '2024-01-12');   -- member_id 6 does NOT exist in members, so I changed it to 3



(A)
---------------------------------------------------------------- */
SELECT name, title, borrow_date
FROM borrowings
JOIN books ON books.book_id = borrowings.book_id
JOIN members ON members.member_id = borrowings.member_id



/* --------------------------------------------------------------
   (B)
---------------------------------------------------------------- */
SELECT members.member_id, name, title
FROM members
LEFT JOIN borrowings ON members.member_id = borrowings.member_id
LEFT JOIN books ON books.book_id = borrowings.book_id



/* --------------------------------------------------------------
   (C)
   -------------------------------------------------------------- */
SELECT  books.book_id,
        books.title,
        members.name
FROM    books
LEFT JOIN borrowings ON books.book_id = borrowings.book_id
LEFT JOIN members    ON borrowings.member_id = members.member_id



/* --------------------------------------------------------------
   (D)
   -------------------------------------------------------------- */
SELECT
	members.name AS member_name,
    books.title,
    borrowings.borrow_date
FROM members
FULL OUTER JOIN borrowings ON members.member_id = borrowings.member_id
FULL OUTER JOIN books ON borrowings.book_id = books.book_id



/* --------------------------------------------------------------
   (E)
   -------------------------------------------------------------- */
SELECT  members.member_id,
        members.name,
        books.title,
        books.author
FROM    members
LEFT JOIN borrowings ON members.member_id = borrowings.member_id
LEFT JOIN books      ON borrowings.book_id = books.book_id
ORDER BY members.member_id, books.title;


/* --------------------------------------------------------------
   (F)
   -------------------------------------------------------------- */
SELECT  members.member_id,
        members.name,
        COUNT(borrowings.book_id) AS borrowed_cnt
FROM    members
JOIN    borrowings ON members.member_id = borrowings.member_id
GROUP BY members.member_id, members.name
HAVING COUNT(borrowings.book_id) > 0


/* --------------------------------------------------------------
   (G) Two separate result sets:
      1) Members that have never borrowed any book.
      2) Books that have never been borrowed.
   -------------------------------------------------------------- */

/* 1) Members without any borrowing */
SELECT  members.*
FROM    members
LEFT JOIN borrowings ON members.member_id = borrowings.member_id
WHERE   borrowings.borrowing_id IS NULL
ORDER BY members.member_id;

/* 2) Books without any borrowing */
SELECT  books.*
FROM    books
LEFT JOIN borrowings ON books.book_id = borrowings.book_id
WHERE   borrowings.borrowing_id IS NULL
ORDER BY books.book_id;


---------------------------------------------------------------------------------------------------------------------



