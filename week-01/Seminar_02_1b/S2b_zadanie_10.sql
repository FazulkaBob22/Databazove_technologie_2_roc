
SELECT product_category, product_name, total_amount
FROM flourmills_sales f1
WHERE EXISTS (
    SELECT 1
    FROM flourmills_sales f2
    WHERE f2.product_category = f1.product_category AND total_amount > 200000

)