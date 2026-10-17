WITH customer_orders AS (
    SELECT
        customers.customer_id,
        customers.customer_name,
        orders.order_date,
        MAX(orders.order_date) OVER (PARTITION BY customers.customer_id) AS last_order_date,
        MAX(orders.order_date) OVER () AS latest_order_date
    FROM customers
    INNER JOIN orders
        ON customers.customer_id = orders.customer_id
)
SELECT
    customer_id,
    customer_name,
    last_order_date
FROM customer_orders
WHERE last_order_date < latest_order_date - INTERVAL '90 days'
ORDER BY last_order_date ASC;
