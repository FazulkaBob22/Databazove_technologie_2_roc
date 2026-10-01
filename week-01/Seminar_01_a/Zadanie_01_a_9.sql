SELECT p.category, AVG(o.discount) AS discount
FROM products p 
LEFT JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category

-- nie je upresnena zase subcategory