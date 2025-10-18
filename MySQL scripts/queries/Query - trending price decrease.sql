WITH today AS (
	SELECT SKU, MAX(tcgplayer_market_price) AS price_today
	FROM price_observation_history
	WHERE date_created_at = CURDATE()
	GROUP BY SKU
),
yesterweek AS (
	SELECT SKU, MAX(tcgplayer_market_price) AS price_yesterweek
	FROM price_observation_history
	WHERE date_created_at = CURDATE() - INTERVAL 7 DAY -- can modify date of first comparison by changing interval (3 for a 3 day comparison)
	GROUP BY SKU
),
yesterday AS (
	SELECT SKU, MAX(tcgplayer_market_price) AS price_yesterday
	FROM price_observation_history
	WHERE date_created_at = CURDATE() - INTERVAL 1 DAY
	GROUP BY SKU
),
quantity_on_hand AS(
	SELECT SKU, quantity_on_hand
	FROM inventory_current
)
SELECT
	t.SKU,
	qoh.quantity_on_hand,
	yw.price_yesterweek,
	y.price_yesterday,
	t.price_today,  
	(t.price_today - y.price_yesterday) AS price_difference_day,
	(t.price_today - yw.price_yesterweek) AS price_difference_week
FROM today t
JOIN yesterday y USING (SKU)
Join yesterweek yw USING (SKU)
JOIN quantity_on_hand qoh USING (SKU)
WHERE t.price_today < y.price_yesterday AND t.price_today < yw.price_yesterweek 
AND qoh.quantity_on_hand > 0 -- optional filter to quantity on hand
ORDER BY price_difference_week;
