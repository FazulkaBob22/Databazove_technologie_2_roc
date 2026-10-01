
SELECT product_name, product_category, total_amount
FROM flourmills_sales f1
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM flourmills_sales f2
    WHERE f2.product_category = f1.product_category )