SELECT c.customer_name, SUM(o.sales) AS total_spent
FROM customers c 
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING SUM(o.sales) >= 2000