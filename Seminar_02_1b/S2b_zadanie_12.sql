SELECT region
FROM flourmills_sales f1
WHERE EXISTS (
    SELECT 1
    FROM flourmills_sales f2
    WHERE EXTRACT(YEAR FROM sales_date) = 2024
)