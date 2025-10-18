CREATE TABLE `inventory_current` (
  `SKU` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity_on_hand` smallint unsigned NOT NULL DEFAULT ''0'',
  `last_inventory_checked` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`SKU`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci