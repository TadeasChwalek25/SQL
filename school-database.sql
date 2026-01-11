-- VYTVOŘENÍ DATABÁZE
CREATE DATABASE skola_db;
USE skola_db;

-- TABULKA STUDENTŮ
CREATE TABLE studenti (
    id_student INT PRIMARY KEY AUTO_INCREMENT,
    jmeno VARCHAR(50),
    prijmeni VARCHAR(50),
    email VARCHAR(100),
    vek INT,
    trida VARCHAR(10)
);

-- TABULKA UČITELŮ
CREATE TABLE ucitele (
    id_ucitel INT PRIMARY KEY AUTO_INCREMENT,
    jmeno VARCHAR(50),
    prijmeni VARCHAR(50),
    predmet VARCHAR(50)
);

-- TABULKA PŘEDMĚTŮ
CREATE TABLE predmety (
    id_predmet INT PRIMARY KEY AUTO_INCREMENT,
    nazev VARCHAR(50),
    id_ucitel INT,
    FOREIGN KEY (id_ucitel) REFERENCES ucitele(id_ucitel)
);

-- TABULKA ZNÁMEK
CREATE TABLE znamky (
    id_znamka INT PRIMARY KEY AUTO_INCREMENT,
    id_student INT,
    id_predmet INT,
    znamka INT,
    datum DATE,
    FOREIGN KEY (id_student) REFERENCES studenti(id_student),
    FOREIGN KEY (id_predmet) REFERENCES predmety(id_predmet)
);

-- VLOŽENÍ STUDENTŮ
INSERT INTO studenti (jmeno, prijmeni, email, vek, trida) VALUES
('Jan', 'Novák', 'jan.novak@email.cz', 17, '3.A'),
('Veronika', 'Malá', 'veronika.m@email.cz', 18, '4.B'),
('Tomáš', 'Dvořák', 'tomas.d@email.cz', 16, '2.C'),
('Lucie', 'Králová', 'lucie.k@email.cz', 17, '3.A'),
('Adam', 'Svoboda', 'adam.s@email.cz', 18, '4.B');

-- VLOŽENÍ UČITELŮ
INSERT INTO ucitele (jmeno, prijmeni, predmet) VALUES
('Petr', 'Horák', 'Matematika'),
('Alena', 'Černá', 'Český jazyk'),
('Martin', 'Beneš', 'Informatika');

-- VLOŽENÍ PŘEDMĚTŮ
INSERT INTO predmety (nazev, id_ucitel) VALUES
('Matematika', 1),
('Český jazyk', 2),
('Informatika', 3);

-- VLOŽENÍ ZNÁMEK
INSERT INTO znamky (id_student, id_predmet, znamka, datum) VALUES
(1, 1, 2, '2024-10-01'),
(1, 3, 1, '2024-10-10'),
(2, 2, 1, '2024-10-03'),
(3, 1, 3, '2024-10-05'),
(4, 2, 2, '2024-10-07'),
(5, 3, 1, '2024-10-09'),
(2, 1, 2, '2024-10-11'),
(3, 3, 2, '2024-10-12');

-- VÝPIS STUDENTŮ A JEJICH ZNÁMEK
SELECT s.jmeno, s.prijmeni, p.nazev AS predmet, z.znamka
FROM znamky z
JOIN studenti s ON z.id_student = s.id_student
JOIN predmety p ON z.id_predmet = p.id_predmet
ORDER BY s.prijmeni;

-- PRŮMĚRNÁ ZNÁMKA KAŽDÉHO STUDENTA
SELECT s.jmeno, s.prijmeni, AVG(z.znamka) AS prumer
FROM znamky z
JOIN studenti s ON z.id_student = s.id_student
GROUP BY s.id_student;

-- AKTUALIZACE ZNÁMKY
UPDATE znamky
SET znamka = 1
WHERE id_student = 1 AND id_predmet = 1;

-- SMAZÁNÍ JEDNÉ ZNÁMKY
DELETE FROM znamky
WHERE id_znamka = 4;
