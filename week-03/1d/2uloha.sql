WITH customer_profit AS (
    SELECT
        customers.region,
        customers.customer_name,
        SUM(orders.profit) AS total_profit
    FROM customers
    INNER JOIN orders
        ON customers.customer_id = orders.customer_id
    GROUP BY customers.region, customers.customer_name
),
ranked AS (
    SELECT
        region,
        customer_name,
        total_profit,
        RANK() OVER (
            PARTITION BY region
            ORDER BY total_profit DESC
        ) AS profit_rank,
        DENSE_RANK() OVER (
            PARTITION BY region
            ORDER BY total_profit DESC
        ) AS profit_dense_rank
    FROM customer_profit
)
SELECT
    region,
    customer_name,
    total_profit,
    profit_rank,
    profit_dense_rank
FROM ranked
ORDER BY region, total_profit DESC;
