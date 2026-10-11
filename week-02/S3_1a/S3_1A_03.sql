
CREATE VIEW analyst_orders AS
SELECT o.order_id, o.customer_id, o.product_id, o.sales, o.quantity, o.discount
FROM orders o;

DROP VIEW analyst_orders;

SELECT * FROM analyst_orders;