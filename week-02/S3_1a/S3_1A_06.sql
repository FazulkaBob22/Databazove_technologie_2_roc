CREATE INDEX idx_orders_region_category
ON orders(customer_id, order_date);

DROP VIEW idx_orders_region_category;

SELECT *
FROM orders o  
INNER JOIN customers c ON o.customer_id = c.customer_id
WHERE c.region = 'West' AND order_date >= '2024-01-01';