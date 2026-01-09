USE mrazak;

SELECT p.nazev, k.nazev AS kategorie, p.datum_expirace
FROM polozka p
JOIN kategorie k ON p.id_kategorie = k.id_kategorie
WHERE p.datum_expirace <= CURRENT_DATE + INTERVAL 30 DAY;

SELECT SUM(pocet_kusu) AS celkem_kusu
FROM polozka;

SELECT k.nazev AS kategorie, COUNT(p.id_polozky) AS pocet_polozek
FROM kategorie k
LEFT JOIN polozka p ON k.id_kategorie = p.id_kategorie
GROUP BY k.nazev;

SELECT nazev, datum_expirace
FROM polozka
WHERE datum_expirace = (SELECT MIN(datum_expirace) FROM polozka)
   OR datum_expirace = (SELECT MAX(datum_expirace) FROM polozka);

SELECT nazev, datum_expirace, pocet_kusu
FROM polozka
WHERE datum_expirace <= CURRENT_DATE + INTERVAL 14 DAY
UNION
SELECT nazev, datum_expirace, pocet_kusu
FROM polozka
WHERE pocet_kusu < 2;
