-- ## Create table from data
CREATE TABLE order_count_by_status
AS
SELECT order_status, COUNT(*) AS order_count
FROM orders
GROUP BY 1;

SELECT * FROM order_count_by_status;

-- ## Create empty table
CREATE TABLE order_stg
AS
SELECT *
FROM orders
WHERE false;

SELECT * FROM order_stg;

-- ## Create Cummulative Aggregation table
CREATE TABLE daily_revenue
AS
SELECT o.order_date,
	round(SUM(oi.order_item_subtotal)::numeric, 2) AS order_revenue
FROM orders AS o
	JOIN order_items AS oi
		ON o.order_id = oi.order_item_order_id
WHERE o.order_status IN ('COMPLETE','CLOSED')
GROUP BY 1;

SELECT * FROM daily_revenue
ORDER BY order_date;

create table daily_product_revenue
as
select o.order_date,
	oi.order_item_product_id,
	round(sum(oi.order_item_subtotal)::numeric, 2) as order_revenue
from orders as o
	join order_items as oi
		on o.order_id = oi.order_item_order_id
where o.order_status in ('COMPLETE', 'CLOSED')
group by 1, 2;

select * from daily_product_revenue
order by 1, 3 desc;

-- ## Window function -- partition by
select to_char(dr.order_date::timestamp, 'yyyy-MM') as order_month,
	dr.order_date,
	dr.order_revenue,
	sum(order_revenue) over(partition by to_char(dr.order_date::timestamp, 'yyyy-MM')) as monthly_order_revenue
from daily_revenue as dr
order by order_date;

select dr.*,
	sum(order_revenue) over(partition by 1) as total_order_revenue
from daily_revenue as dr
order by 1;