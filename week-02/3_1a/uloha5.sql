create index idx_orders_order_date on orders(order_date)

select date_trunc('month', order_date) AS month, sum(sales) as sum from orders
group by date_trunc('month', order_date)
order by month ASC