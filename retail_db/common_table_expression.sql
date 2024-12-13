WITH order_details_cte AS
(SELECT o.*,
	oi.order_item_product_id,
	oi.order_item_subtotal,
	oi.order_item_id
FROM orders AS o
	JOIN order_items AS oi
		ON o.order_id = oi.order_item_order_id)
SELECT * FROM order_details_cte
WHERE order_id = 2;