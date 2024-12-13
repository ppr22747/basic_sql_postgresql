-- rank() over()
-- dense_rank() over()

-- global ranking
	-- rank() over(order by col1 desc)
-- ranking based on key or partition key
	-- rank() over(partition by col2 order by col1 desc)

select order_date,
	order_item_product_id,
	order_revenue,
	rank() over(order by order_revenue desc) as rnk,																											
	dense_rank() over(order by order_revenue desc) as drnk
from daily_product_revenue
where order_date = '2014-01-01 00:00:00.0'
order by order_revenue desc;


select order_date,
	order_item_product_id,
	order_revenue																																																																																																																																																																																														,
	rank() over(
		partition by order_date
		order by order_revenue desc)
	as rnk,
		dense_rank() over(
		partition by order_date
		order by order_revenue desc)
	as drnk
from daily_product_revenue
where to_char(order_date::date, 'yyyy-MM') = '2014-01'
order by order_date, order_revenue desc;

select * from
(select order_date,
	order_item_product_id,
	order_revenue																																																																																																																																																																																														,
	rank() over(order by order_revenue desc) as rnk,																											
	dense_rank() over(order by order_revenue desc) as drnk
from daily_product_revenue
where to_char(order_date::date, 'yyyy-MM') = '2014-01'
) as q
where drnk <= 5;


with daily_product_revenue_ranks as (
select order_date,
	order_item_product_id,
	order_revenue																																																																																																																																																																																														,
	rank() over(order by order_revenue desc) as rnk,																											
	dense_rank() over(order by order_revenue desc) as drnk
from daily_product_revenue
where to_char(order_date::date, 'yyyy-MM') = '2014-01'
) select * from daily_product_revenue_ranks
where drnk <= 5
order by order_revenue desc;


-- ## Filtering based on Ranks per Partition using Nested Queries and CTEs in SQL
-- ## Top 5 products as of Jan 2014
select * from (
	select order_date,
		order_item_product_id,
		order_revenue																																																																																																																																																																																														,
		rank() over(
			partition by order_date
			order by order_revenue desc)
		as rnk,
			dense_rank() over(
			partition by order_date
			order by order_revenue desc)
		as drnk
	from daily_product_revenue
	where to_char(order_date::date, 'yyyy-MM') = '2014-01'
) as q
where drnk <= 5
order by order_date, order_revenue desc;

-- ## Top 5 products as of Jan 2014
with daily_product_revenue_ranks as (
	select order_date,
		order_item_product_id,
		order_revenue																																																																																																																																																																																														,
		rank() over(
			partition by order_date
			order by order_revenue desc)
		as rnk,
			dense_rank() over(
			partition by order_date
			order by order_revenue desc)
		as drnk
	from daily_product_revenue
	where to_char(order_date::date, 'yyyy-MM') = '2014-01'
) select * from daily_product_revenue_ranks
where drnk <= 5
order by order_date, order_revenue desc
;

