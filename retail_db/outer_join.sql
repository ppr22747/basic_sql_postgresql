-- SELECT * FROM order_detail_v;

-- SELECT * FROM products;

SELECT * 
FROM products AS p
	LEFT OUTER JOIN order_detail_v AS odv
		ON p.product_id = odv.order_item_product_id
			AND to_char(odv.order_date::timestamp, 'yyyy-MM') = '2014-01'
WHERE odv.order_item_product_id IS NULL;

SELECT * FROM products AS p
WHERE NOT EXISTS (
	SELECT 1 FROM order_detail_v AS odv
	WHERE p.product_id = odv.order_item_product_id
		AND to_char(odv.order_date::timestamp, 'yyyy-MM') = '2014-01'
)