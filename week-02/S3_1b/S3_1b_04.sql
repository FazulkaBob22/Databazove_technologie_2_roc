WITH money_per_type AS(
    SELECT customer_type, SUM(total_amount) AS revenue
    FROM flourmills_sales
    GROUP BY customer_type
),
percent_rev AS (
    SELECT customer_type, revenue, SUM(revenue) OVER() AS total_revenue,
    ROUND((revenue * 100.0 /SUM(revenue) OVER())::NUMERIC,2) AS revenue_percentage
    FROM money_per_type
)
SELECT *
FROM percent_rev
ORDER BY revenue DESC