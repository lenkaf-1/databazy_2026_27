WITH ranked_orders AS (
    SELECT
        customer_name,
        order_id,
        order_date,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY order_date DESC
        ) AS rn
    FROM customers
    JOIN orders USING (customer_id)
)
SELECT
    customer_name,
    order_id,
    order_date
FROM ranked_orders
WHERE rn IN (1, 2)
ORDER BY customer_name, rn;
