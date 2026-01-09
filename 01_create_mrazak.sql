DROP DATABASE IF EXISTS mrazak;
CREATE DATABASE mrazak
CHARACTER SET utf8mb4
COLLATE utf8mb4_czech_ci;

USE mrazak;

CREATE TABLE kategorie (
    id_kategorie INT AUTO_INCREMENT PRIMARY KEY,
    nazev VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE polozka (
    id_polozky INT AUTO_INCREMENT PRIMARY KEY,
    nazev VARCHAR(100) NOT NULL,
    id_kategorie INT NOT NULL,
    datum_expirace DATE NOT NULL,
    pocet_kusu INT NOT NULL,

    CONSTRAINT chk_pocet_kusu CHECK (pocet_kusu > 0),
    CONSTRAINT chk_datum_expirace CHECK (datum_expirace >= CURRENT_DATE),

    CONSTRAINT fk_kategorie
        FOREIGN KEY (id_kategorie)
        REFERENCES kategorie(id_kategorie)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);
