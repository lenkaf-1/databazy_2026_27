CREATE INDEX idx_orders_region_category 
ON orders(customer_id, order_date);


select orders.order_id, orders.customer_id, orders.order_date, orders.sales, orders.profit
FROM orders
inner join customers on orders.customer_id = customers.customer_id 
where customers.region = 'West' and order_date >= '2024-01-01'
order by orders.order_date;