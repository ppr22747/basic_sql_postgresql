-- /*Inner join*/
-- SELECT o.order_date,
-- 	oi.order_item_product_id,
-- 	oi.order_item_subtotal
-- FROM orders AS o
-- 	JOIN order_items AS oi
-- 		ON o.order_id = oi.order_item_order_id;

-- /*Outer join*/
-- SELECT o.order_id,
-- 	o.order_date,
-- 	oi.order_item_id,
-- 	oi.order_item_product_id,
-- 	oi.order_item_subtotal
-- FROM orders AS o
-- 	LEFT OUTER JOIN order_items AS oi
-- 		ON o.order_id = oi.order_item_order_id
-- ORDER BY 1;

/*Filter and aggregrate joining result*/
SELECT o.order_date,
	oi.order_item_product_id,
	round(sum(oi.order_item_subtotal)::numeric, 2) AS order_revenue
FROM orders AS o
	JOIN order_items AS oi
		ON o.order_id = oi.order_item_order_id
WHERE o.order_status IN ('COMPLETE', 'CLOSED')
GROUP BY 1, 2
ORDER BY 1, 3 DESC;
