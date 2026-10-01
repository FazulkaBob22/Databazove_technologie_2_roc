SELECT product_name
FROM flourmills_sales f1
WHERE EXISTS (
    SELECT product_name
    FROM flourmills_sales f2
    WHERE f2.product_name = f1.product_name
    GROUP BY product_name
    HAVING COUNT(DISTINCT (extract(MONTH FROM sales_date))) > 1
)