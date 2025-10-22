-- Vytvoření tabulky hockeyPlayer
CREATE TABLE hockeyPlayer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fname VARCHAR(30) NOT NULL,
    lname VARCHAR(50) NOT NULL,
    team VARCHAR(50) NOT NULL
);

DELIMITER $$

-- Vytvoření procedury insert_player
CREATE PROCEDURE insert_player(
    IN p_fname VARCHAR(30),
    IN p_lname VARCHAR(50),
    IN p_team VARCHAR(50)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Rollback transakce při výskytu chyby
        ROLLBACK;
        -- Výstup o chybě 
        SELECT 'Chyba při vkládání záznamu' AS error_message;
    END;

    -- Začátek transakce
    START TRANSACTION;

    -- Vložení záznamu do tabulky
    INSERT INTO hockeyPlayer(fname, lname, team) VALUES (p_fname, p_lname, p_team);

    -- Potvrzení transakce
    COMMIT;
END$$

DELIMITER ;

-- Volání procedury s platnými daty
CALL insert_player('David', 'Pastrňák', 'Boston Bruins');
-- Tento insert proběhne v pořádku, záznam bude vložen.

-- Volání procedury s hodnotou NULL pro NOT NULL sloupec
CALL insert_player('Pavel', 'Zacha', NULL);
-- Dojde k výjimce, spustí se handler, transakce se rollbackne,
-- a vypíše se zpráva "Chyba při vkládání záznamu".
