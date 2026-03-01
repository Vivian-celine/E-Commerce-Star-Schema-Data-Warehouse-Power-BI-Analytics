CREATE VIEW vw_order_items AS
SELECT
    oi.order_item_id,
    oi.order_id,
    o.customer_id,
    o.order_date,
    oi.product_id,
    oi.quantity,
    oi.unit_price,
    oi.total_price
FROM order_items oi
JOIN orders o
  ON oi.order_id = o.order_id;


CREATE VIEW vw_clean_customers AS
SELECT *
FROM customers
WHERE 
    full_name IS NOT NULL
    AND email IS NOT NULL
    AND signup_date <= CAST(GETDATE() AS DATE);

CREATE VIEW vw_clean_products AS
SELECT *
FROM products
WHERE 
    appliance_name IS NOT NULL
    AND category_id IS NOT NULL
    AND unit_price >= 0
    AND cost_price >= 0;

CREATE VIEW view_inventory AS
SELECT
    i.product_id,
    i.initial_stock,
    COALESCE(SUM(oi.quantity), 0) AS sold_quantity,
    i.initial_stock - COALESCE(SUM(oi.quantity), 0) AS remaining_stock
FROM inventory i
LEFT JOIN order_items oi
    ON i.product_id = oi.product_id
GROUP BY i.product_id, i.initial_stock;