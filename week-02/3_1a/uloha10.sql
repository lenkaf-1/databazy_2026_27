CREATE OR REPLACE PROCEDURE apply_regional_discount(
    IN region_name VARCHAR,
    IN discount_rate DECIMAL
)
LANGUAGE plpgsql
AS $procedure$
BEGIN
    UPDATE orders 
    SET sales = sales * (1 - discount_rate)
    FROM customers 
    WHERE orders.customer_id = customers.customer_id
      AND customers.region = region_name;

    RAISE NOTICE 'Applied discount % to region %', discount_rate, region_name;
END;
$procedure$;
