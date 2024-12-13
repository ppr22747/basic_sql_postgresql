CREATE OR REPLACE VIEW order_detail_v
AS
SELECT o.*,
	oi.order_item_product_id,
	oi.order_item_subtotal,
	oi.order_item_id
FROM orders as O
	JOIN order_items AS oi
		ON o.order_id = oi.order_item_order_id;

/*call VIEW*/
SELECT * FROM order_detail_v WHERE order_id = 2;