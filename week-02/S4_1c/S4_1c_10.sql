WITH celk AS (
    SELECT country, date_trunc('month', invoice_date)::date AS month,
    customer_id, SUM(quantity * unit_price) AS total_amount
    FROM retail_sales
    WHERE customer_id IS NOT NULL
    GROUP BY country, date_trunc('month', invoice_date), customer_id 
),
zorad AS (
    SELECT country, month, customer_id, total_amount,
    DENSE_RANK() OVER(
        PARTITION BY country, month 
        ORDER BY total_amount DESC
    ) AS sales_rank
    FROM celk
)
SELECT country, month, customer_id, total_amount, sales_rank
FROM zorad
WHERE sales_rank <= 5
ORDER BY country, month, sales_rank, customer_id