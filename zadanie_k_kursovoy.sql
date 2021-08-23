# Пункт 6 заданий для курсовой работы 

# Вывести все предметы, относящиеся к конкретному игровому пулу, отсортированные по редкости 

USE isaac_items;

SELECT item_name, item_rarity FROM items 
WHERE pool_name_id = 3
ORDER BY item_rarity DESC;


# Показать принадлежность того или иного брелка (trinket) к определенному пулу

SELECT trinkets.trinket_name, pool.pool_name  FROM trinkets
JOIN pool ON trinkets.pool_name_id = pool.id;


# Выбрать названия таких карт, которые относятся к конкретному пулу при условии, что название данного пула известно частично

SELECT card_name FROM cards 
WHERE pool_name_id IN (SELECT id FROM pool WHERE pool_name LIKE "Ange%");


# Пункт 7 заданий для курсовой работы

# Представление, позволяющее определить к какой из версий игры относится тот или иной предмет 

CREATE OR REPLACE VIEW items_and_version AS
SELECT items.item_name, game_version.g_version FROM items
JOIN game_version ON items.game_version_id = game_version.id

SELECT * FROM items_and_version


# Представление, показывающее предметы, пилюли, расходники, карты и брелоки в зависимости от версии игры

CREATE OR REPLACE VIEW items_version_id AS
SELECT item_name, game_version_id FROM items
WHERE items.game_version_id = 1

UNION 

SELECT card_name, game_version_id FROM cards
WHERE cards.game_version_id = 1

UNION 

SELECT pill_name, game_version_id FROM pills
WHERE pills.game_version_id = 1

UNION 

SELECT collectible_name, game_version_id FROM collectibles
WHERE collectibles.game_version_id = 1

UNION 

SELECT rune_name, game_version_id FROM runes
WHERE runes.game_version_id = 1;



SELECT * FROM items_version_id

# Пункт 8 заданий для курсовой работы

# Процедура, позволяющая регулировать темную тему в зависимости от времени суток

DROP PROCEDURE IF EXISTS black_theme;
DELIMITER //
CREATE PROCEDURE black_theme()
BEGIN
	IF("00:00:00" <= CURTIME() AND CURTIME() < "06:00:00") THEN
	 	UPDATE isaac_items.settings SET status= TRUE  ;
 		SELECT * FROM settings;
	 
	ELSEIF ("06:00:00" <= CURTIME() AND CURTIME() < "24:00:00") THEN
		UPDATE isaac_items.settings SET status= FALSE WHERE isaac_items.settings.setting_name = "Темная тема";
	 	SELECT * FROM settings;
	END IF;
END//

DELIMITER ;

CALL black_theme();


# Триггер на проверку конкретной версии игры

USE isaac_items;

DROP TRIGGER IF EXISTS version_check;
DELIMITER //
CREATE TRIGGER version_check BEFORE INSERT ON items FOR EACH ROW
BEGIN
	IF(NEW.game_version_id = 1 or NEW.game_version_id = 2 or NEW.game_version_id = 3) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Wrong Version! Only Repentance version";
	END IF;
END //
DELIMITER ;


INSERT INTO items (pool_name_id, game_version_id, item_name, item_img, item_description, item_rarity)
VALUES
	(5, 4, "Repentance", "rndm", "Holy Light", 2);

INSERT INTO items (pool_name_id, game_version_id, item_name, item_img, item_description, item_rarity)
VALUES
	(5, 2, "Brimstone", "rndm", "Bloody Tears", 2);
