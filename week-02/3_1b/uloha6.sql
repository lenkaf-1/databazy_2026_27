WITH RECURSIVE date_bounds AS (
    SELECT 
        MIN(sale_date) AS start_date,
        MAX(sale_date) AS end_date
    FROM flourmills_sales
),
calendar AS (
    SELECT start_date::date AS calendar_date
    FROM date_bounds

    UNION ALL

    SELECT (calendar_date + INTERVAL '1 day')::date
    FROM calendar, date_bounds
    WHERE calendar_date < end_date
)
SELECT calendar_date
FROM calendar
ORDER BY calendar_date ASC;
