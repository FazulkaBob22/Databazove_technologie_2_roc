

WITH RECURSIVE datumy AS(
    SELECT MIN(sales_date) AS start_date, MAX(sales_date) AS end_date
    FROM flourmills_sales
),

kalendar AS(
    SELECT start_date AS sales_date
    FROM datumy
    WHERE start_date IS NOT NULL

    UNION ALL

    SELECT (k.sales_date + INTERVAL '1 day')::date
    FROM kalendar k 
    CROSS JOIN datumy d 
    WHERE k.sales_date < d.end_date
)

SELECT sales_date
FROM kalendar
ORDER BY sales_date ASC