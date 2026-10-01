SELECT product_name, region, total_amount, 
    (SELECT MIN(total_amount)
    FROM flourmills_sales f2
    WHERE f2.region = f1.region)
FROM flourmills_sales f1
