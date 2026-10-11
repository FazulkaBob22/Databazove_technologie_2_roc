WITH cat_name AS(
    SELECT product_category, product_name,
    SUM(total_amount) AS total_product_sales
    FROM flourmills_sales
    GROUP BY product_category, product_name
),
ranked_prod AS(
    SELECT product_category, product_name, total_product_sales,
    RANK() OVER(
        PARTITION BY product_category
        ORDER BY total_product_sales DESC
    ) AS category_rank 
    FROM cat_name
)
SELECT * 
FROM ranked_prod 
WHERE category_rank BETWEEN 1 AND 3
ORDER BY product_category ASC, category_rank ASC
LIMIT 10