WITH RECURSIVE monthly_revenue AS (
    SELECT date_trunc('month', sales_date) AS month,
    SUM(total_amount) AS revenue
    FROM flourmills_sales
    GROUP BY date_trunc('month', sales_date)
),
ordered_months AS (
   SELECT ROW_NUMBER() OVER(ORDER BY month) AS rn,
   month, revenue
   FROM monthly_revenue
),
cumulative_target AS (
    SELECT rn, month, revenue, revenue AS cumulative_revenue 
    FROM ordered_months
    WHERE rn = 1

    UNION ALL

    SELECT o.rn, o.month, o.revenue, c.cumulative_revenue + o.revenue
    FROM cumulative_target c
    JOIN ordered_months o 
    ON o.rn = c.rn+1
    WHERE c.cumulative_revenue < 500000000
)
SELECT rn, to_char(month, 'YYYY-MM-DD'), revenue, cumulative_revenue
FROM cumulative_target
WHERE cumulative_revenue >= 500000000
ORDER BY rn
LIMIT 1;
