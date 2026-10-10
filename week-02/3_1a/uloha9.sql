CREATE OR REPLACE PROCEDURE get_customer_sales(IN p_customer_id VARCHAR)
LANGUAGE plpgsql
AS $procedure$
DECLARE
    total_sales DECIMAL(10,2);
BEGIN
    SELECT SUM(sales)
    INTO total_sales
    FROM orders
    WHERE customer_id = p_customer_id;
    RAISE NOTICE 'Customer: %, Total Sales: %', p_customer_id, total_sales;
END;
$procedure$;
