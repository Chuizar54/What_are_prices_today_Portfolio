# What_are_prices_today_Portfolio
Brief introductory portfolio showing trading card pricing observations. For this very brief project I used TCGPlayer.com pricing data to answer the questions: 
1) what is the price today(of any card)?
2) Which prices are rising or falling?
3) What are the biggest moves in terms of dollar amount or percent change?
4) Are these price movements trends or one day blips
I have provided the SQL scripts i used to create the tables and query them to answer questions.

**Tools & Languages:**

- MySQL databases

- SQL queries

**Database structure:**

```Main DB

├── cards - table that contains metada about the cards
│  ├── SKU (Primary Key)
│  ├── card_name 
│  ├── set_code (3 or 4 letter code used to identify a set of cards, structure varies by game)
│  ├── card_number (numeric identifier of a card WITHIN a set)
│  ├── finish  (type of printing. Ex: normal, foil, borderless, ...)
│  ├── rarity (stated rarity of the card)
│  ├── set_name (full set name)
│  ├── sub_set_code (3 to 6 letter code used I use to identify sub sets of a larger set EX: BlB, ASBLB)
│  ├── sub_set_name (full name i use to identify sub sets of a larger set Ex: Bloomburrow, Art Series: Bloomburrow)
│  └── game_name (name of the game the card is from)
│
├──  latest_prices - table that stores the most current (today's) pricing data of cards. Used when looking up current pricing. 
│  ├── SKU (Primary Key)
│  ├── tcgplayer_market_price (average reported sale price of a card across the tcgplayer ecosystem)
│  ├── tcgplayer_low_price (lowest listing price for a card on the tcgplayer platform)
│  └── last_price_check (quick easy verify that query results are current data)
│
├──  inventory_current - table that tracks inventory of cards 
│  ├── SKU (Primary Key)
│  ├── quantity_on_hand (current stock of cards on hand)
│  └── last_inventory_checked (quick easy verify that query results are current data)
│
├──  price_observation_history - table that logs all pricing observations
│  ├── id (Primary Key) (generic auto increment key to identify each unique entry)
│  ├── SKU (Used to identify which car the pricing data is for
│  ├── tcgplayer_market_price (average reported sale price of a card across the tcgplayer ecosystem)
│  ├── tcgplayer_low_price (lowest listing price for a card on the tcgplayer platform)
│  ├── created_at (timestamp of when the entry was created)
│  └──date_created_at (Date only time stamp of when the entry was created)
```


