WITH zoradene AS (
    SELECT customer_id, invoice_no, invoice_date, stock_code,
    description, quantity, unit_price,
    ROW_NUMBER() OVER(
        PARTITION BY customer_id
        ORDER BY invoice_date ASC, invoice_no ASC
    ) AS row_n 
    FROM retail_sales
    WHERE customer_id IS NOT NULL
)
SELECT customer_id, invoice_no, invoice_date, stock_code,
        description, quantity, unit_price
FROM zoradene
WHERE row_n = 1
ORDER BY customer_id ASC