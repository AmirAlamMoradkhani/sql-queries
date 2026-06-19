/* --------------------------------------------------------
   1. Table: customers
   -------------------------------------------------------------- */
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name        VARCHAR(50) NOT NULL,
    city        VARCHAR(50) NOT NULL
);

INSERT INTO customers (customer_id, name, city) VALUES
(101, 'Ali',     'Tehran'),
(102, 'Sara',    'Isfahan'),
(103, 'Maryam',  'Mashhad'),
(104, 'Nima',    'Shiraz');


/* --------------------------------------------------------------
   2. Table: orders
   -------------------------------------------------------------- */
CREATE TABLE orders (
    order_id     INT PRIMARY KEY,
    customer_id  INT NOT NULL,
    order_date   DATE NOT NULL,
    total_amount NUMERIC(12,2) NOT NULL,

    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);

INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
(1, 101, '2024-01-10', 500),
(2, 102, '2024-01-12', 150),
(3, 101, '2024-01-15', 700),
(4, 103, '2024-02-01', 250),
(5, 104, '2024-02-05', 0);


/* --------------------------------------------------------------
   3. Table: products
   -------------------------------------------------------------- */
CREATE TABLE products (
    product_id  INT PRIMARY KEY,
    order_id    INT NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    quantity    INT NOT NULL,
    price       NUMERIC(12,2) NOT NULL,

    CONSTRAINT fk_products_order
        FOREIGN KEY (order_id) REFERENCES orders (order_id)
);

INSERT INTO products (product_id, order_id, product_name, quantity, price) VALUES
(201, 1, 'Laptop',   1, 500),
(202, 2, 'Mouse',    2, 75),
(203, 3, 'Monitor',  2, 350),
(204, 4, 'Keyboard', 1, 250),
(205, 5, 'Pen',      0, 0);
----------------------------------------------------------------------------------------------------------------
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