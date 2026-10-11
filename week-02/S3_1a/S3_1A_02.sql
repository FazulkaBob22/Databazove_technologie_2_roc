CREATE VIEW regional_monthly_sales AS
SELECT c.region, DATE_TRUNC('month', order_date) AS month, SUM(o.sales) AS monthly_sales
FROM orders o 
INNER JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.region, date_trunc('month', order_date);

SELECT * FROM regional_monthly_sales
WHERE region = 'West'