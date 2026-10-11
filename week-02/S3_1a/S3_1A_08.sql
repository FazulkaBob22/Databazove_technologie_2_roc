-- Active: 1790185795336@@127.0.0.1@5432@superstore
CREATE PROCEDURE get_customer_sales(p_customer_id VARCHAR(20))
LANGUAGE plpgsql
AS $procedure$
DECLARE
    total_sales NUMERIC(10, 2);
BEGIN
    SELECT COALESCE(SUM(sales))
    INTO total_sales
    FROM orders
    WHERE customer_id = p_customer_id;

    RAISE NOTICE 'customer: %, sales total: %', p_customer_id, total_sales;
END;
$procedure$

DROP PROCEDURE get_customer_sales;

CALL get_customer_sales('C001');