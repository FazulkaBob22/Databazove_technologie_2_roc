-- Active: 1790185795336@@127.0.0.1@5432@superstore
WITH zorad AS (
    SELECT c.customer_name, o.order_id, o.order_date,
    ROW_NUMBER() OVER(
        PARTITION BY o.customer_id
        ORDER BY o.order_date DESC
    ) AS row_num 
    FROM customers c 
    JOIN orders o ON c.customer_id = o.customer_id
)
SELECT customer_name, order_id, order_date
FROM zorad
WHERE row_num <=2
ORDER BY customer_name, row_num