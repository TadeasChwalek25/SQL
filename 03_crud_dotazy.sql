USE mrazak;

SELECT p.id_polozky, p.nazev, k.nazev AS kategorie,
       p.datum_expirace, p.pocet_kusu
FROM polozka p
JOIN kategorie k ON p.id_kategorie = k.id_kategorie;

INSERT INTO polozka (nazev, id_kategorie, datum_expirace, pocet_kusu)
VALUES ('Ledový hrášek', 4, '2026-06-20', 3);

UPDATE polozka
SET pocet_kusu = 5
WHERE id_polozky = 1;

UPDATE polozka
SET datum_expirace = '2026-04-01'
WHERE id_polozky = 2;

DELETE FROM polozka
WHERE id_polozky = 16;
