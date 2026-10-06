SELECT c.customer_name, SUM(o.sales) AS total_sales, AVG(o.discount) AS avg_discount, COUNT(o.order_id) AS total_orders,
CASE 
    WHEN SUM(o.sales) > 2500 THEN 'VIP' 
    ELSE  'REGULAR'
END AS customer_type
FROM customers c 
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_sales DESC

-- V zadani je povedané kazdy zakaznik, preto som pouzil LEFT JOIN namiesto INNER