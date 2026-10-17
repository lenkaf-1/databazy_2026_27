WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', orders.order_date) AS month,
        SUM(orders.sales) AS monthly_sales
    FROM orders
    GROUP BY DATE_TRUNC('month', orders.order_date)
),
lagged AS (
    SELECT
        month,
        monthly_sales,
        LAG(monthly_sales) OVER (ORDER BY month) AS prev_month_sales
    FROM monthly_sales
),
changes AS (
    SELECT
        month,
        monthly_sales,
        prev_month_sales,
        monthly_sales - prev_month_sales AS sales_change
    FROM lagged
),
final AS (
    SELECT
        month,
        monthly_sales,
        prev_month_sales,
        sales_change,
        ROUND(
            (sales_change / prev_month_sales) * 100.0,
            2
        ) AS growth_percentage
    FROM changes
)
SELECT
    month,
    monthly_sales,
    prev_month_sales,
    sales_change,
    growth_percentage
FROM final
ORDER BY month ASC;
