WITH product_sales AS (
    SELECT
        products.category,
        products.product_name,
        SUM(orders.sales) AS product_sales
    FROM orders
    JOIN products ON orders.product_id = products.product_id
    GROUP BY products.category, products.product_name
)
SELECT
    category,
    product_name,
    product_sales,
    SUM(product_sales) OVER (PARTITION BY category) AS category_total,
    ROUND(
        product_sales * 100.0 /
        SUM(product_sales) OVER (PARTITION BY category),
        2
    ) AS pct_of_category
FROM product_sales
ORDER BY category, product_sales DESC;
