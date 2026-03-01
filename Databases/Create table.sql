Create database Ecommerce_db;

Use Ecommerce_db;

CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    city VARCHAR(50),
    country VARCHAR(50),
    signup_date DATE NOT NULL,
    
    CONSTRAINT chk_signup_date 
        CHECK (signup_date <= CAST(GETDATE() AS DATE)),

    CONSTRAINT chk_email_format
        CHECK (email LIKE '%_@_%._%'));

CREATE TABLE appliance_categories (
    category_id VARCHAR(5) PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE);

CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    appliance_name VARCHAR(100) NOT NULL,
    category_id VARCHAR(5) NOT NULL,
    brand_name VARCHAR(50),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
    cost_price DECIMAL(10,2) NOT NULL CHECK (cost_price >= 0),
    created_at DATE NOT NULL,

    CONSTRAINT chk_price_logic
        CHECK (cost_price <= unit_price),

    CONSTRAINT chk_created_at
        CHECK (created_at <= CAST(GETDATE() AS DATE)),

    FOREIGN KEY (category_id) 
        REFERENCES appliance_categories(category_id));

CREATE TABLE orders (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10) NOT NULL,
    order_date DATE NOT NULL,
    order_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id));

CREATE TABLE order_items (
    order_item_id VARCHAR(12) PRIMARY KEY,
    order_id VARCHAR(10),
    product_id VARCHAR(10),
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id));

 CREATE TABLE inventory (
    product_id VARCHAR(10) PRIMARY KEY,
    initial_stock INT NOT NULL CHECK (initial_stock >= 0),
    FOREIGN KEY (product_id) REFERENCES products(product_id));

CREATE TABLE Dim_Date (
    full_date DATE PRIMARY KEY,
    year INT,
    month INT,
    day INT,
    month_name VARCHAR(20),
    month_year VARCHAR(20),
    month_year_sort INT);

DECLARE @start_date DATE = (SELECT MIN(order_date) FROM orders);
DECLARE @end_date   DATE = (SELECT MAX(order_date) FROM orders);

WHILE @start_date <= @end_date
BEGIN
    INSERT INTO Dim_Date
    SELECT
        @start_date,
        YEAR(@start_date),
        MONTH(@start_date),
        DAY(@start_date),
        DATENAME(MONTH, @start_date),
        FORMAT(@start_date, 'MMM yyyy'),
        (YEAR(@start_date) * 100) + MONTH(@start_date);

    SET @start_date = DATEADD(DAY, 1, @start_date);
END;