WITH each_category AS(
    SELECT product_category, SUM(total_amount) AS category_sales
    FROM flourmills_sales
    GROUP BY product_category
)
SELECT * FROM each_category;