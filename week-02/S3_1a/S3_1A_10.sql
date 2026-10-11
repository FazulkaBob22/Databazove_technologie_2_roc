-- Active: 1790185795336@@127.0.0.1@5432@retail_sales
CREATE PROCEDURE get_sales_between (start_date DATE, end_date DATE)
LANGUAGE plpgsql
AS $procedure$
DECLARE 
    p_total_sales NUMERIC(13, 2);
BEGIN
    SELECT SUM(sales)
    INTO p_total_sales
    FROM orders
    WHERE order_date BETWEEN start_date AND end_date;
    RAISE NOTICE 'total sales: %, between % and %', p_total_sales, start_date, end_date;
END;
$procedure$;

DROP PROCEDURE get_sales_between;

CALL get_sales_between('2024-01-01','2024-03-31');