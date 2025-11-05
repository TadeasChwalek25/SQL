-- ---------------------------------------------
-- Databáze pro evidenci sportovních potřeb
-- ---------------------------------------------

-- Vytvoření databáze
CREATE DATABASE IF NOT EXISTS sportovni_potreby;
USE sportovni_potreby;

-- -------------------------------------------------
-- Tabulka Kategorie
-- -------------------------------------------------
CREATE TABLE IF NOT EXISTS Kategorie (
    id_kategorie INT AUTO_INCREMENT PRIMARY KEY,
    nazev VARCHAR(100) NOT NULL UNIQUE
);

-- -------------------------------------------------
-- Tabulka Vyrobce
-- -------------------------------------------------
CREATE TABLE IF NOT EXISTS Vyrobce (
    id_vyrobce INT AUTO_INCREMENT PRIMARY KEY,
    nazev VARCHAR(100) NOT NULL,
    kontakt VARCHAR(255)
);

-- -------------------------------------------------
-- Tabulka Sportovni_potreba
-- -------------------------------------------------
CREATE TABLE IF NOT EXISTS Sportovni_potreba (
    id_potreba INT AUTO_INCREMENT PRIMARY KEY,
    nazev VARCHAR(100) NOT NULL,
    cena DECIMAL(10,2) CHECK (cena >= 0),
    mnozstvi_sklad INT DEFAULT 0 CHECK (mnozstvi_sklad >= 0),
    id_kategorie INT NOT NULL,
    id_vyrobce INT NOT NULL,
    FOREIGN KEY (id_kategorie) REFERENCES Kategorie(id_kategorie),
    FOREIGN KEY (id_vyrobce) REFERENCES Vyrobce(id_vyrobce)
);

-- -------------------------------------------------
-- Vložení testovacích dat do Kategorie
-- -------------------------------------------------
INSERT INTO Kategorie(nazev) VALUES ('Kola'), ('Helmy'), ('Oblečení');

-- -------------------------------------------------
-- Vložení testovacích dat do Vyrobce
-- -------------------------------------------------
INSERT INTO Vyrobce(nazev, kontakt) VALUES 
('Specialized', 'info@specialized.com'), 
('Giro', 'kontakt@giro.com');

-- -------------------------------------------------
-- Uložená procedura pro vložení nové sportovní potřeby
-- -------------------------------------------------
DELIMITER $$

CREATE PROCEDURE pridat_sportovni_potrebu(
    IN p_nazev VARCHAR(100),
    IN p_cena DECIMAL(10,2),
    IN p_mnozstvi INT,
    IN p_id_kategorie INT,
    IN p_id_vyrobce INT
)
BEGIN
    -- Zachytávání chyb
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Chyba při vkládání záznamu. Transakce byla zrušena.' AS message;
    END;

    START TRANSACTION;

    INSERT INTO Sportovni_potreba(nazev, cena, mnozstvi_sklad, id_kategorie, id_vyrobce)
    VALUES (p_nazev, p_cena, p_mnozstvi, p_id_kategorie, p_id_vyrobce);

    COMMIT;
END $$

DELIMITER ;

-- -------------------------------------------------
-- Testovací volání procedury (úspěšné)
-- -------------------------------------------------
CALL pridat_sportovni_potrebu('Horský bike', 15000.00, 5, 1, 1);
CALL pridat_sportovni_potrebu('Cyklistická helma', 2500.00, 10, 2, 2);

-- -------------------------------------------------
-- Testovací volání procedury (chyba)
-- -------------------------------------------------
CALL pridat_sportovni_potrebu('Tričko na kolo', 1200.00, 15, 99, 1);
