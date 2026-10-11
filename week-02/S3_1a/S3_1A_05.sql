
CREATE INDEX idx_orders_order_date
ON orders(order_date);

DROP INDEX idx_orders_order_date;

SELECT date_trunc('month', order_date) AS month, SUM(sales) AS total_sales
FROM orders
GROUP BY date_trunc('month', order_date)
ORDER BY month ASC;