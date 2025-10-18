CREATE TABLE `latest_prices` (
  `SKU` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tcgplayer_market_price` decimal(10,2) DEFAULT NULL,
  `tcgplayer_low_price` decimal(10,2) DEFAULT NULL,
  `last_price_check` datetime DEFAULT NULL,
  PRIMARY KEY (`SKU`),
  KEY `idx_latest_prices_sku` (`SKU`),
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci