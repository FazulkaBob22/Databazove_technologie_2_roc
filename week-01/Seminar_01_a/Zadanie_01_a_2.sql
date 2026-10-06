SELECT orders.order_id, customers.customer_name, orders.profit
FROM orders 
INNER JOIN customers ON orders.customer_id = customers.customer_id
WHERE orders.profit >= 500;

SELECT orders.order_id, customers.customer_name, orders.sales
FROM orders 
INNER JOIN customers ON orders.customer_id = customers.customer_id
WHERE orders.sales >= 500;

--Neviem ci si pod "hodnota predaja" mam predstavovat profit alebo sales tak nechavam oboje