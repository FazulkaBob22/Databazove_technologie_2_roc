WITH m_p AS(
    SELECT date_trunc('month', order_date)::date AS month, SUM(sales) AS monthly_sales
    FROM orders
    GROUP BY date_trunc('month', order_date)
    
),
pred_m AS (
    SELECT month, monthly_sales,
    LAG(monthly_sales) OVER(ORDER BY month) AS prev_month_sales
    FROM m_p
) 

SELECT month, monthly_sales, prev_month_sales,
        monthly_sales - prev_month_sales AS sales_change,
        ROUND(((monthly_sales - prev_month_sales)
 / prev_month_sales) * 100, 2) AS growth_percentage


FROM pred_m