CREATE TABLE IF NOT EXISTS Products2
(
    ProductID      INT PRIMARY KEY,
    ProductName    VARCHAR(255) NOT NULL,
    Category       VARCHAR(50) NOT NULL DEFAULT 'Electronics',
    Price          NUMERIC(10,2) NOT NULL CHECK (Price >= 0),
    StockQuantity  INT NOT NULL DEFAULT 1 CHECK (StockQuantity >= 0),
    AddedDate      DATE NOT NULL DEFAULT CURRENT_DATE,

    CONSTRAINT chk_category
        CHECK (Category IN ('Electronics','Clothing','Books','Toys')),

    CONSTRAINT uq_product_name_category
        UNIQUE (ProductName, Category)
);
------------------------------------------------------------
/* --------------------------------------------------------------
   table: Categories
   -------------------------------------------------------------- */
CREATE TABLE Categories
(
    CategoryID   INT PRIMARY KEY,                
    CategoryName VARCHAR(50) NOT NULL UNIQUE      
);


INSERT INTO Categories (CategoryID, CategoryName) VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Books'),
(4, 'Toys');


/* --------------------------------------------------------------
    Re‑create the Products table so that it uses CategoryID
   -------------------------------------------------------------- */
DROP TABLE IF EXISTS Products CASCADE;  

CREATE TABLE Products
(
    ProductID      INT PRIMARY KEY,                     
    ProductName    VARCHAR(255) NOT NULL,              
    CategoryID     INT NOT NULL DEFAULT 1,              
    Price          NUMERIC(10,2) NOT NULL CHECK (Price >= 0),  
    StockQuantity  INT NOT NULL DEFAULT 1 CHECK (StockQuantity >= 0), 
    AddedDate      DATE NOT NULL DEFAULT CURRENT_DATE,

    -- 1) Restrict CategoryID to existing rows in Categories
    CONSTRAINT fk_products_category
        FOREIGN KEY (CategoryID)
        REFERENCES Categories (CategoryID)
        ON DELETE CASCADE          -- if a category disappears, its products disappear
        ON UPDATE CASCADE,         -- if CategoryID is changed, propagate the change

    -- 2) ProductName + Category must be unique (the same product name cannot appear twice in the same category)
    CONSTRAINT uq_productname_category
        UNIQUE (ProductName, CategoryID)
);
----------------------------------------------------------------
/* Ali ---------------------------------------------------------- */
GRANT INSERT ON TABLE products   TO ali;            -- can add new products
GRANT SELECT ON TABLE categories TO ali;            -- can only read categories

/* Sara ---------------------------------------------------------- */
GRANT SELECT, UPDATE ON TABLE products TO sara;    -- can read & edit products


/* Reza ---------------------------------------------------------- */
GRANT SELECT ON TABLE products TO reza;            -- read‑only on products



/* --------------------------------------------------------------
   Revoke ALL privileges from Ali on the products table
   -------------------------------------------------------------- */
REVOKE ALL PRIVILEGES ON TABLE products FROM ali;