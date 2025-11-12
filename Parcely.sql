-- 1️. Vytvoření databáze
CREATE DATABASE parcely_db;
USE parcely_db;

-- 2️. Vytvoření tabulek

-- Tabulka vlastníků (1)
CREATE TABLE owners (
    owner_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100)
);

-- Tabulka pozemků (N)
CREATE TABLE plots (
    plot_id INT AUTO_INCREMENT PRIMARY KEY,
    owner_id INT NOT NULL,
    area DECIMAL(10,2) NOT NULL,
    kind ENUM('stavebni','zpf','mixed') NOT NULL,
    note VARCHAR(255),
    FOREIGN KEY (owner_id) REFERENCES owners(owner_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- 3️. Vložení testovacích dat

INSERT INTO owners (name, email)
VALUES 
    ('Prokop Dveře', 'prokop.dvere@email.cz'),
    ('Tomáš Jedno', 'tomas.jedno@email.cz');

INSERT INTO plots (owner_id, area, kind, note)
VALUES
    (1, 350.5, 'stavebni', 'Pozemek v Praze'),
    (1, 820.0, 'zpf', 'Zemědělská půda'),
    (2, 500.0, 'mixed', 'Kombinovaný pozemek');

-- 4️. Vytvoření role s potřebnými oprávněními

CREATE ROLE parcely_role;

-- Přiřazení oprávnění k celé databázi
GRANT SELECT, INSERT, UPDATE, DELETE ON parcely_db.* TO parcely_role;

-- 5️. Vytvoření nového uživatele a přiřazení role

CREATE USER 'uzivatel_parcely'@'localhost' IDENTIFIED BY 'heslo123';
GRANT parcely_role TO 'uzivatel_parcely'@'localhost';

-- Aktivace role při přihlášení
SET DEFAULT ROLE parcely_role TO 'uzivatel_parcely'@'localhost';

-- 6️. Přihlášení jako nový uživatel

-- Zobrazení všech vlastníků
SELECT * FROM owners;

-- Vložení nového vlastníka
INSERT INTO owners (name, email)
VALUES ('Petr Svoboda', 'petr.svoboda@email.cz');

-- Vložení nového pozemku
INSERT INTO plots (owner_id, area, kind, note)
VALUES (3, 250.00, 'zpf', 'Menší pole');

-- Aktualizace údajů o pozemku
UPDATE plots
SET note = 'Aktualizovaná poznámka'
WHERE plot_id = 1;

-- Smazání pozemku
DELETE FROM plots
WHERE plot_id = 2;

-- 7️. Ověření změn
SELECT * FROM owners;
SELECT * FROM plots;
