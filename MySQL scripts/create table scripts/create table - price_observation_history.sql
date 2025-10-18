CREATE TABLE `price_observation_history` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `SKU` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tcgplayer_market_price` decimal(10,2) DEFAULT NULL,
  `tcgplayer_low_price` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_created_at` date GENERATED ALWAYS AS (cast(`created_at` as date)) STORED,
  PRIMARY KEY (`id`),
  KEY `price_history_sku_date` (`SKU`,`date_created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=424340 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci


