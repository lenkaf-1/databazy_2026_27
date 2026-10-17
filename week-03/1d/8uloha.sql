WITH first_purchase AS (
    SELECT
        customers.customer_id,
        DATE_TRUNC('month', MIN(orders.order_date)) AS first_purchase_month
    FROM customers
    JOIN orders ON customers.customer_id = orders.customer_id
    GROUP BY customers.customer_id
)
SELECT COUNT(*) AS returned_customers
FROM first_purchase
WHERE first_purchase_month = DATE '2024-06-01'
  AND EXISTS (
        SELECT 1
        FROM orders
        WHERE orders.customer_id = first_purchase.customer_id
          AND DATE_TRUNC('month', orders.order_date) > first_purchase.first_purchase_month
    );
