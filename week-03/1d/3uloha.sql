WITH customer_sales AS (
    SELECT
        customers.customer_name,
        SUM(orders.sales) AS total_sales
    FROM customers
    INNER JOIN orders
        ON customers.customer_id = orders.customer_id
    GROUP BY customers.customer_name
),
quartiles AS (
    SELECT
        customer_name,
        total_sales,
        NTILE(4) OVER (
            ORDER BY total_sales DESC
        ) AS quartile
    FROM customer_sales
)
SELECT
    customer_name,
    total_sales,
    quartile
FROM quartiles
ORDER BY total_sales DESC;
