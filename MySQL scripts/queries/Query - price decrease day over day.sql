WITH today AS(
	SELECT SKU, MAX(tcgplayer_market_price) AS price_today
	FROM price_observation_history
    WHERE date_created_at = curdate()
	GROUP BY SKU
),
yesterday AS(
	SELECT SKU, MAX(tcgplayer_market_price) AS price_yesterday
    FROM price_observation_history
    WHERE date_created_at = curdate() - INTERVAL 1 DAY
    GROUP BY SKU
),
quantity AS(
	SELECT SKU, quantity_on_hand
	FROM inventory_current
),
percent AS(
	SELECT 
		SKU,
        t.price_today,
        y.price_yesterday,
        (((t.price_today - y.price_yesterday)/y.price_yesterday)*100) AS percentage
    FROM today t
    JOIN yesterday y USING (SKU)
)
SELECT
	t.SKU, 
	y.price_yesterday,
	t.price_today,
    (t.price_today - y.price_yesterday) AS price_difference,
	CONCAT(ROUND(p.percentage, 2),'%') AS percent_difference,
    qoh.quantity_on_hand
FROM today t
JOIN yesterday y USING (SKU)
JOIN quantity qoh USING (SKU)
JOIN percent p USING (SKU)
WHERE (t.price_today - y.price_yesterday) < 0
AND (t.price_today - y.price_yesterday) < -0.03 -- optional filter for minimum price change (eliminates .01 to .02 = 100% price change)
AND qoh.quantity_on_hand > 0 -- optional filter for quantity on hand. 
-- ORDER BY percent -- optional order by highest percent difference. Must comment out if not using
ORDER BY price_difference -- optional order by largest price difference. Must Comment out if not using
;
