SELECT *
FROM (
    SELECT product_category, SUM(total_amount) AS total_sales
    FROM flourmills_sales
    GROUP BY product_category
)
WHERE total_sales > 50000000
ORDER BY total_sales DESC