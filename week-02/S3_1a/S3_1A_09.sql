-- Active: 1790185795336@@127.0.0.1@5432@superstore
-- Active: 1790185795336@@127.0.0.1@5432@retail_sales
CREATE PROCEDURE apply_regional_discount(
    reg_n VARCHAR(20), disc_r NUMERIC
)
LANGUAGE plpgsql
AS $procedure$
BEGIN
    UPDATE orders AS o
    SET sales = o.sales * (1 - disc_r)
    FROM customers AS c
    WHERE o.customer_id = c.customer_id AND c.region = reg_n;
    RAISE NOTICE 'Discount: %, applies in region: %', disc_r, reg_n;
END;
$procedure$;

DROP PROCEDURE apply_regional_discount;

CALL apply_regional_discount('West', 0.10);

SELECT o.customer_id, o.sales, c.region
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE c.region = 'West';