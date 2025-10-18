SELECT 
lp.SKU, 
lp.tcgplayer_market_price,
c.card_name,
c.set_code,
c.set_name,
c.finish,
c.rarity,
c.game_name,
ic.quantity_on_hand
FROM latest_prices AS LP
LEFT JOIN cards AS c USING (SKU)
LEFT JOIN inventory_current AS ic USING (SKU)
-- WHERE c.game_name = 'Magic: The Gathering' -- optional filter for game. Can change with any filter from cards metadata columns (c.xxxxxxx).
-- WHERE ic.quantity_on_hand > 0 -- optional filter to see prices only for what is on hand. must change to AND if using both optional filters
ORDER BY lp.tcgplayer_market_price DESC;