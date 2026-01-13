-- 1. VYTVOŘENÍ TABULEK
-- Tabulka studentů
CREATE TABLE Studenti (
    student_id INTEGER PRIMARY KEY AUTOINCREMENT,
    jmeno TEXT NOT NULL,
    trida TEXT,
    rocnik INTEGER
);

-- Tabulka známek (propojená se studenty přes student_id)
CREATE TABLE Znamky (
    znamka_id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER,
    predmet TEXT,
    hodnota INTEGER,
    datum DATE,
    FOREIGN KEY (student_id) REFERENCES Studenti(student_id)
);

-- 2. VLOŽENÍ TESTOVACÍCH DAT
INSERT INTO Studenti (jmeno, trida, rocnik) VALUES 
('Adam Rychlý', '4.A', 4),
('Sára Krátká', '4.A', 4),
('Honza Novák', '2.B', 2),
('Klára Veselá', '2.B', 2);

INSERT INTO Znamky (student_id, predmet, hodnota, datum) VALUES 
(1, 'Matematika', 1, '2026-01-10'),
(1, 'Fyzika', 2, '2026-01-12'),
(2, 'Matematika', 3, '2026-01-10'),
(3, 'Angličtina', 1, '2026-01-13'),
(4, 'Angličtina', 5, '2026-01-13'),
(1, 'Informatika', 1, '2026-01-13');

-- 3. ANALÝZA DAT (Dotazy)

-- A) Výpis studentů a jejich známek (propojení tabulek přes JOIN)
SELECT Studenti.jmeno, Znamky.predmet, Znamky.hodnota
FROM Studenti
JOIN Znamky ON Studenti.student_id = Znamky.student_id;

-- 

-- B) Výpočet průměrné známky pro každého studenta
SELECT jmeno, AVG(hodnota) as prumer
FROM Studenti
JOIN Znamky ON Studenti.student_id = Znamky.student_id
GROUP BY jmeno
ORDER BY prumer ASC;

-- C) Najdi studenty, kteří dostali 5 (nedostatečnou)
SELECT jmeno, predmet 
FROM Studenti 
JOIN Znamky ON Studenti.student_id = Znamky.student_id 
WHERE hodnota = 5;

-- D) Aktualizace (oprava známky Kláře)
UPDATE Znamky SET hodnota = 2 WHERE student_id = 4 AND predmet = 'Angličtina';

-- E) Smazání studenta (Honzovi skončila škola)
DELETE FROM Studenti WHERE student_id = 3;
