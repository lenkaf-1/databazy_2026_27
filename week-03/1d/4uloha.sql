WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', orders.order_date) AS month,
        SUM(orders.sales) AS monthly_sales
    FROM orders
    GROUP BY DATE_TRUNC('month', orders.order_date)
),
lag_lead AS (
    SELECT
        month,
        monthly_sales,
        LAG(monthly_sales, 1) OVER (ORDER BY month) AS prev_month_sales,
        LEAD(monthly_sales, 1) OVER (ORDER BY month) AS next_month_sales
    FROM monthly_sales
)
SELECT
    month,
    monthly_sales,
    prev_month_sales,
    next_month_sales
FROM lag_lead
ORDER BY month ASC;
