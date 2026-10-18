WITH jedin_ob AS(
    SELECT DISTINCT customer_id, invoice_no, invoice_date
    FROM retail_sales
    WHERE customer_id IS NOT NULL
),
dals_ob AS(
    SELECT customer_id, invoice_no, invoice_date,
    LEAD(invoice_date) OVER(
        PARTITION BY customer_id
        ORDER BY invoice_date 
       ) AS next_invoice_date
       FROM jedin_ob
)

SELECT customer_id, invoice_no, invoice_date, next_invoice_date,
       
next_invoice_date::date - invoice_date::date AS days_to_next_invoice


FROM dals_ob
WHERE next_invoice_date IS NOT NULL
ORDER BY days_to_next_invoice DESC
