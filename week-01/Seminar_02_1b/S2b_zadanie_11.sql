SELECT DISTINCT product_category
FROM flourmills_sales f1
WHERE EXISTS (
    SELECT 1 
    FROM flourmills_sales f2
    WHERE f2.product_category = f1.product_category
    GROUP BY product_category
    HAVING COUNT(DISTINCT region)  > 3
)