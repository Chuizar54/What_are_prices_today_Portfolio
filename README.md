# What_are_prices_today_Portfolio
Brief introductory project showing trading card pricing observations. For this very brief project I used TCGPlayer.com pricing data to answer the questions: 
1) what is the price today(of any card)?
2) Which prices are rising or falling?
3) What are the biggest moves by dollar amount or percent change?
4) Are these price movements trends?
I have provided the SQL scripts i used to create the tables and query them to answer questions. The work done in this projects assumes that pricing data is collected data. The data used in the the visualizations are incomplete sample data. 

**Tools & Languages:**

- MySQL databases

- SQL queries

- Tableau

**Links to Visualizations:**

Tableau: https://public.tableau.com/shared/4SBFRCFZ7?:display_count=n&:origin=viz_share_link

  - This interactive Tableau dashboard analyzes pricing trends for a sample of trading cards over a one-week period. The primary view displays card names alongside their current market and low prices. A set of filters across the top, including game, set, rarity, and quantity on hand, allows for focused exploration without scrolling through the entire ~16,000 row dataset. When a card is selected, the supporting panes dynamically update to visualize its day-over-day and week-over-week price changes, as well as a chart tracking daily market movements. This design enables quick identification of price shifts and trend patterns across sets, supporting data-driven pricing and inventory decisions.

**Database structure:**

```
Main DB
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

**Queries**

- prices today
  - Returns what the most current prices are.
  - Optional filters to sort by game, set, finish, rarity, tc. (What is the most expensive Rare Foil card)
  - Answeres the question: What is the price today?
- price increase/decrease day to day
  - Query that checks which cards have a higher (or lower) market price today than it did yesterday
  - Answers questions: Which prices are rising and falling? What are the biggest movers by dollar amount or percent change?
  - Returns results in dollar difference and percent difference
    - sortable by both options as well
  - filter by only cards that are in stock and/or price differences over a certain amount
    - trying to reduce the amount of low value cards that increase a few cents resulting in high percentage differences.
- trending price increase/decrease
  - Query that checks if the price today is higher than yesterday and last week
  - Answers the question: Are these price movements trends?
  - filter by cards that are in stock
