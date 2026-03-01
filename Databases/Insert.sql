WITH Numbers AS (
    SELECT TOP 200
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM (VALUES (0),(0),(0),(0),(0),(0),(0),(0),(0),(0)) a(n)
    CROSS JOIN (VALUES (0),(0),(0),(0),(0),(0),(0),(0),(0),(0)) b(n)
    CROSS JOIN (VALUES (0),(0),(0),(0),(0),(0),(0),(0),(0),(0)) c(n)
)

INSERT INTO customers
(customer_id, full_name, email, phone, city, country, signup_date)

SELECT
    CONCAT('CUST', FORMAT(n, '0000')),
    CONCAT('Customer ', n),
    CONCAT('customer', n, '@gmail.com'),
    CONCAT('267', RIGHT(ABS(CHECKSUM(NEWID())), 7)),
    CASE (ABS(CHECKSUM(NEWID())) % 10) + 1
        WHEN 1 THEN 'New York'
        WHEN 2 THEN 'Los Angeles'
        WHEN 3 THEN 'Chicago'
        WHEN 4 THEN 'Houston'
        WHEN 5 THEN 'Phoenix'
        WHEN 6 THEN 'Philadelphia'
        WHEN 7 THEN 'San Antonio'
        WHEN 8 THEN 'San Diego'
        WHEN 9 THEN 'Dallas'
        ELSE 'San Jose'
    END,
    'USA',
    DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 120, CAST(GETDATE() AS DATE))

FROM Numbers;


INSERT INTO appliance_categories (category_id, category_name)
VALUES
('CAT01', 'Kitchen'),
('CAT02', 'Home'),
('CAT03', 'Entertainment'),

INSERT INTO products
(product_id, appliance_name, category_id, brand_name, unit_price, cost_price, created_at)
VALUES

-- Kitchen (CAT01)
('P001','Refrigerator','CAT01','LG',1200.00,1050.00,'2025-10-05'),
('P002','Microwave Oven','CAT01','Samsung',350.00,380.00,'2025-10-12'),
('P003','Electric Kettle','CAT01','Philips',80.00,60.00,'2025-10-18'),
('P004','Blender','CAT01','Ninja',220.00,200.00,'2025-11-01'),
('P005','Dishwasher','CAT01','Bosch',900.00,870.00,'2025-11-10'),

-- Home (CAT02)
('P006','Washing Machine','CAT02','Whirlpool',1100.00,980.00,'2025-10-08'),
('P007','Clothes Dryer','CAT02','GE',950.00,1000.00,'2025-10-20'),
('P008','Air Conditioner','CAT02','Daikin',1300.00,1250.00,'2025-11-05'),
('P009','Vacuum Cleaner','CAT02','Dyson',600.00,550.00,'2025-11-18'),
('P010','Water Heater','CAT02','Rheem',750.00,780.00,'2025-12-01'),

-- Entertainment (CAT03)
('P011','Smart Television','CAT03','Sony',1500.00,1400.00,'2025-10-15'),
('P012','Sound Bar','CAT03','JBL',400.00,360.00,'2025-10-25'),
('P013','Gaming Console','CAT03','Microsoft',520.00,560.00,'2025-11-12'),
('P014','DVD Player','CAT03','Panasonic',180.00,150.00,'2025-11-22'),
('P015','Home Theatre System','CAT03','LG',900.00,1000.00,'2025-12-05'),

-- Personal (CAT04)
('P016','Electric Iron','CAT04','Binatone',90.00,70.00,'2025-10-10'),
('P017','Hair Dryer','CAT04','Remington',120.00,95.00,'2025-10-28'),
('P018','Electric Shaver','CAT04','Braun',250.00,230.00,'2025-11-08'),
('P019','Air Purifier','CAT04','Xiaomi',450.00,420.00,'2025-11-26'),
('P020','Standing Fan','CAT04','Lasko',300.00,280.00,'2025-12-10');