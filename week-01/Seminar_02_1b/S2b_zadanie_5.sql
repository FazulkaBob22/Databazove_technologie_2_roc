
SELECT month, monthly_sales
FROM (
    SELECT EXTRACT(MONTH FROM sales_date) AS month, SUM(total_amount) AS monthly_sales
    FROM flourmills_sales
    GROUP BY month
)