WITH today AS (
  SELECT SKU, MAX(tcgplayer_market_price) AS price_today
  FROM price_observation_history
  WHERE date_created_at = CURDATE()
  GROUP BY SKU
),
yesterday AS (
  SELECT SKU, MAX(tcgplayer_market_price) AS price_yesterday
  FROM price_observation_history
  WHERE date_created_at = CURDATE() - INTERVAL 1 DAY -- Change interval to compare todays prices to other days (example: 7 for last week)
  GROUP BY SKU
),
quantity_on_hand AS(
	SELECT SKU, quantity_on_hand
    FROM inventory_current
)
SELECT
  t.SKU,
  qoh.quantity_on_hand,
  y.price_yesterday,
  t.price_today,  
  (t.price_today - y.price_yesterday) AS price_difference
FROM today t
JOIN yesterday y USING (SKU)
JOIN quantity_on_hand qoh USING (SKU)
WHERE t.price_today < y.price_yesterday 
AND qoh.quantity_on_hand > 0 -- optional quantity on hand filter
ORDER BY price_difference;
