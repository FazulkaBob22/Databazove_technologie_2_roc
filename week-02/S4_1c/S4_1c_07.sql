
WITH monthly AS (
    SELECT country, DATE_TRUNC('month', invoice_date)::date AS month,
    SUM(quantity * unit_price) AS total_amount
    FROM retail_sales
    GROUP BY country, date_trunc('month', invoice_date)
),
sales_q AS(
    SELECT country, month, total_amount,
    NTILE(4) OVER(
        PARTITION BY country 
        ORDER BY total_amount DESC
    )AS sales_quartile
    FROM monthly
)
SELECT country, month, total_amount, sales_quartile
FROM sales_q
ORDER BY country ASC, month ASC