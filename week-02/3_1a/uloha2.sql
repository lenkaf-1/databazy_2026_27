CREATE VIEW regional_monthly_sales AS 
SELECT 
    customers.region,
    DATE_TRUNC('month', orders.order_date) AS month,
    sum(orders.sales) AS monthly_sales
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY 
    customers.region,
    DATE_TRUNC('month', orders.order_date)
ORDER BY 
    customers.region,
    month;
