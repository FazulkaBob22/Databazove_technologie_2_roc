WITH latest_sale AS(
    SELECT customer_id, product_name, sales_date, total_amount,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id
        ORDER BY sales_date DESC
    ) AS row_num 
    FROM flourmills_sales
)
SELECT customer_id, product_name, sales_date, total_amount
FROM latest_sale
WHERE row_num = 1
ORDER BY customer_id ASC
LIMIT 5