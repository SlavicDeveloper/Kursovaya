# Создаем базу данных

DROP DATABASE IF EXISTS isaac_items;
CREATE DATABASE isaac_items;
USE isaac_items;

ALTER DATABASE isaac_items CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

# Создаем таблицу с текущими версиями игры (набор предметов зависит от версии)
DROP TABLE IF EXISTS game_version;
CREATE TABLE game_version(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	g_version VARCHAR(20)
);

INSERT INTO game_version(g_version)
VALUES
	("Rebirth"),
	("Afterbirth"),
	("Afterbirth+"),
	("Repentance");

# Создаем таблицу с игровыми локациями (от той или иной локации зависит набор предметов)
DROP TABLE IF EXISTS pool;
CREATE TABLE pool(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	pool_name VARCHAR(20)

);

INSERT INTO pool (pool_name)
VALUES
	("Shop room pool"),
	("Boss room pool"),
	("Library"),
	("Angel room pool"),
	("Treasure room"),
	("Devil room pool"),
	("Secret room pool"),
	("Cursed room pool"),
	("Challenge room"),
	("Bum"),
	("Devil bum"),
	("Key bum"),
	("Bomb bum"),
	("Chest"),
	("Red chest"),
	("Golden chest");

# Создаем таблицу с предметами (при помощи ключей связываем с таблицами pool и game_version)
DROP TABLE IF EXISTS items;
CREATE TABLE items(
	pool_name_id BIGINT UNSIGNED NOT NULL,
	game_version_id BIGINT UNSIGNED NOT NULL,
	item_name VARCHAR(20),
	item_img CHAR(10),
	item_description TEXT,
	item_rarity INT UNSIGNED,
	
	INDEX items_name_idx(item_name) # c целью более быстрого поиска по предметам
);


INSERT INTO items (pool_name_id, game_version_id, item_name, item_img, item_description, item_rarity)
VALUES
	(5, 1, "Eye Sore", "rndm", "More Eyes", 2),
	(3, 2, "Pyromaniac", "rndm", "It Hurts So Good", 4),
	(4, 1, "Scorpio", "rndm", "Poison Tears", 2),
	(6, 4, "Charged Baby", "rndm", "Bbbzzzzzt!", 3),
	(6, 4, "Chaos", "rndm", "!!!", 3),
	(5, 2, "Sacrfical Altar", "rndm", "He demands a sacrifice", 2),
	(3, 3, "Red Key", "rndm", "Explore the other side", 3),
	(3, 2, "Holy Light", "rndm", "Holy shot", 3);
	

ALTER TABLE items ADD CONSTRAINT fk_game_version_item_id
	FOREIGN KEY (game_version_id) REFERENCES game_version(id)
	ON UPDATE CASCADE
	ON DELETE RESTRICT;

ALTER TABLE items ADD CONSTRAINT fk_pool_item_id
	FOREIGN KEY (pool_name_id) REFERENCES pool(id)
	ON UPDATE CASCADE
	ON DELETE RESTRICT;

# Создаем таблицу с брелоками (при помощи ключей связываем с таблицами pool и game_version)
DROP TABLE IF EXISTS trinkets;
CREATE TABLE trinkets(
	pool_name_id BIGINT UNSIGNED NOT NULL,
	game_version_id BIGINT UNSIGNED NOT NULL,
	trinket_name VARCHAR(20),
	trinket_img CHAR(10),
	trinket_description TEXT,

	INDEX trinkets_name_idx(trinket_name) # c целью более быстрого поиска по брелокам
);

INSERT INTO trinkets (pool_name_id, game_version_id, trinket_name, trinket_img, trinket_description)
VALUES
	(5, 4, "Brain Worm", "rndm", "Ding"),
	(3, 2, "Broken Syringe", "rndm", "Mystery Medicine"),
	(2, 1, "Blue Key", "rndm", "Look between the rooms"),
	(4, 3, "Ring cap", "rndm", "Twice the bang!"),
	(1, 2, "Flat worm", "rndm", "Blub blup!");

ALTER TABLE trinkets ADD CONSTRAINT fk_game_version_trinket_id
	FOREIGN KEY (game_version_id) REFERENCES game_version(id)
	ON UPDATE CASCADE
	ON DELETE RESTRICT;

ALTER TABLE trinkets ADD CONSTRAINT fk_pool_trinket_id
	FOREIGN KEY (pool_name_id) REFERENCES pool(id)
	ON UPDATE CASCADE
	ON DELETE RESTRICT;

# Создаем таблицу с картами (при помощи ключей связываем с таблицами pool и game_version)
DROP TABLE IF EXISTS cards;
CREATE TABLE cards (
	pool_name_id BIGINT UNSIGNED NOT NULL,
	game_version_id BIGINT UNSIGNED NOT NULL,
	card_name VARCHAR(20),
	card_img CHAR(10),
	card_description TEXT,

	INDEX cards_name_idx(card_name) # c целью более быстрого поиска по картам 
);

INSERT INTO cards (pool_name_id, game_version_id, card_name, card_img, card_description)
VALUES
	(4, 3, "The Judgement", "rndm", "May your future become balanced"),
	(4, 3, "The World", "rndm", "Open your eyes and see"),
	(5, 4, "The Tower", "rndm", "Destruction brings creation"),
	(4, 2, "The Fool", "rndm", "Where your journey begins");

ALTER TABLE cards ADD CONSTRAINT fk_game_version_card_id
	FOREIGN KEY (game_version_id) REFERENCES game_version(id)
	ON UPDATE CASCADE
	ON DELETE RESTRICT;

ALTER TABLE cards ADD CONSTRAINT fk_pool_card_id
	FOREIGN KEY (pool_name_id) REFERENCES pool(id)
	ON UPDATE CASCADE
	ON DELETE RESTRICT;


# Создаем таблицу с пилюлями (при помощи ключей связываем с таблицами pool и game_version)
DROP TABLE IF EXISTS pills;
CREATE TABLE pills (
	pool_name_id BIGINT UNSIGNED NOT NULL,
	game_version_id BIGINT UNSIGNED NOT NULL,
	pill_name VARCHAR(20),
	pill_img CHAR(10),
	pill_description TEXT,
	
	INDEX pill_name_idx(pill_name) # c целью более быстрого поиска по пилюлям
);

INSERT INTO pills (pool_name_id, game_version_id, pill_name, pill_img, pill_description)
VALUES
	(1, 1, "Pills of Rebirth", "rndm", "Random effects"),
	(2, 2, "Pills of Afterbirth", "rndm", "Random effects"),
	(3, 3, "Pills of Afterbirth+", "rndm", "Random effects"),
	(4, 4, "Pills of Repentance", "rndm", "Random effects");

ALTER TABLE pills ADD CONSTRAINT fk_game_version_pill_id
	FOREIGN KEY (game_version_id) REFERENCES game_version(id)
	ON UPDATE CASCADE
	ON DELETE RESTRICT;

ALTER TABLE pills ADD CONSTRAINT fk_pool_pill_id
	FOREIGN KEY (pool_name_id) REFERENCES pool(id)
	ON UPDATE CASCADE
	ON DELETE RESTRICT;

# Создаем таблицу с рунами (при помощи ключей связываем с таблицами pool и game_version)
DROP TABLE IF EXISTS runes;
CREATE TABLE runes (
	pool_name_id BIGINT UNSIGNED NOT NULL,
	game_version_id BIGINT UNSIGNED NOT NULL,
	rune_name VARCHAR(20),
	rune_img CHAR(10),
	rune_description TEXT,
	
	INDEX rune_name_idx(rune_name) # c целью более быстрого поиска по рунам
);

INSERT INTO runes (pool_name_id, game_version_id, rune_name, rune_img, rune_description)
VALUES
	(1, 1, "Black Rune", "rndm", "Void"),
	(2, 1, "Rune of Algiz", "rndm", "Resistance"),
	(1, 1, "Rune of Jera", "rndm", "Abundance"),
	(1, 4, "Rune of Perthro", "rndm", "VChange");


ALTER TABLE runes ADD CONSTRAINT fk_game_version_rune_id
	FOREIGN KEY (game_version_id) REFERENCES game_version(id)
	ON UPDATE CASCADE
	ON DELETE RESTRICT;

ALTER TABLE runes ADD CONSTRAINT fk_pool_rune_id
	FOREIGN KEY (pool_name_id) REFERENCES pool(id)
	ON UPDATE CASCADE
	ON DELETE RESTRICT;

# Создаем таблицу с расходниками (при помощи ключей связываем с таблицами pool и game_version)
DROP TABLE IF EXISTS collectibles;
CREATE TABLE collectibles(
	pool_name_id BIGINT UNSIGNED NOT NULL,
	game_version_id BIGINT UNSIGNED NOT NULL,
	collectible_name VARCHAR(20),
	collectible_img CHAR(10),
	collectible_description TEXT,
	
	INDEX collectible_name_idx(collectible_name) # c целью более быстрого поиска по предметам
);

INSERT INTO collectibles (pool_name_id, game_version_id, collectible_name, collectible_img, collectible_description)
VALUES
	(1, 1, "Coin", "rndm", "Silver, golden, platinum"),
	(2, 2, "Bomb", "rndm", "Simple or golden"),
	(3, 3, "Key", "rndm", "Simple, golden or charged");

ALTER TABLE collectibles ADD CONSTRAINT fk_game_version_collectible_id
	FOREIGN KEY (game_version_id) REFERENCES game_version(id)
	ON UPDATE CASCADE
	ON DELETE RESTRICT;

ALTER TABLE collectibles ADD CONSTRAINT fk_pool_collectible_id
	FOREIGN KEY (pool_name_id) REFERENCES pool(id)
	ON UPDATE CASCADE
	ON DELETE RESTRICT;

# Создаем таблицу с информацией
DROP TABLE if EXISTS information;
CREATE TABLE information(
	information_name VARCHAR(40),
	inf_reference VARCHAR(20)
);

INSERT INTO information (information_name, inf_reference)
VALUES
	("FAQ/помощь", "https..."),
	("Трансформации", "https..."),
	("Рецепты мешка", "https..."),
	("PlatinumGod", "https..."),
	("Русская вики", "https..."),
	("Сайт по Dead Cells", "https..."),
	("Донаты", "https...");


# Создать таблицу с настройками платформы
DROP TABLE if EXISTS settings;
CREATE TABLE settings(
	setting_name VARCHAR(20),
	status BOOL
);

INSERT INTO settings (setting_name, status)
VALUES
	("Темная тема", TRUE),
	("Помощник", TRUE);
	


