WITH prv AS(
    SELECT customer_id, date_trunc('month', MIN(order_date)) AS f_mon
    FROM orders
    GROUP BY customer_id
)
SELECT COUNT(*) AS customers_return
FROM prv p
WHERE f_mon = '2024-06-01' AND EXISTS(
    SELECT 1
    FROM orders o
    WHERE o.customer_id = p.customer_id
    AND date_trunc('month', o.order_date) > p.f_mon
)