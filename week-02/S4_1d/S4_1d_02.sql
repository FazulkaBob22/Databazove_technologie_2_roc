WITH zakaz AS (
    SELECT c.region, c.customer_name, SUM(o.profit) AS total_profit
    FROM orders o  
    JOIN customers c on o.customer_id = c.customer_id
    GROUP BY c.region, c.customer_id, c.customer_id
)
SELECT region, customer_name, total_profit,
RANK() OVER(
    PARTITION BY region 
    ORDER BY total_profit DESC
) AS profit_rank,
DENSE_RANK() OVER(
    PARTITION BY region 
    ORDER BY total_profit DESC
) AS profit_dense_rank
FROM zakaz 
ORDER BY region ASC, total_profit DESC
LIMIT 5 