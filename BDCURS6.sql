CREATE DATABASE IF NOT EXISTS bd_curs6;
CREATE TABLE IF NOT EXISTS profesori(
  id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nume VARCHAR(40) NOT NULL,
  prenume VARCHAR(40) NOT NULL,
  tara_origine VARCHAR(40) NOT NULL DEFAULT 'Romania',
  email VARCHAR(80)
);
DESCRIBE profesori;

CREATE TABLE IF NOT EXISTS cursuri(	
  id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  denumire VARCHAR(40) NOT NULL
);
DESCRIBE cursuri;

CREATE TABLE IF NOT EXISTS programari(
  id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  id_profesor TINYINT,
  id_curs TINYINT,
  data_incepere DATE NOT NULL,
  data_finalizare DATE,
  foreign key (id_profesor) REFERENCES profesori(id),
  foreign key (id_curs) REFERENCES cursuri(id)
);
DESCRIBE programari;

INSERT INTO profesori(nume, prenume, tara_origine) VALUES
("Smith", "John" ,  "Australia"),
("Aurelian", "Tanase" , "Romania"),
("Kallen", "Allen", "Germania"),
("Ramachandran", "V.S.", "California"),
("Kalanithi", "Paul", "San Jose"),
('Popescu' , 'Claudia' , 'Romania'),
("Thomas", "Shelby", "Anglia"),
('Ionescu', 'Maria','Romania'),
('Dumitrescu', 'Eduard', 'Romania'),
("Gustav", "Klimt", "Austria");

SELECT * FROM profesori;
SET sql_safe_updates = 1;
UPDATE profesori SET email = CONCAT(nume, "_", prenume , "@pr.gmail.com");

UPDATE profesori SET email = LOWER(email);

INSERT INTO cursuri(denumire) VALUES
('Matematică 101'),
('Introducere în Programare'),
('Istoria Artei'),
('Bazele Chimiei'),
('Literatura Engleză'),
('Introducere în Psihologie'),
('Fundamentele Marketingului Digital'),
('Introducere în Economie'),
('Teoria Muzicii'),
('Introducere în Știința Datelor');

INSERT INTO programari(id_profesor, id_curs, data_incepere) VALUES
(3, 5, '2018-05-23'),
(5, 4, '2018-06-13'),
(4, 2, '2018-02-14'),
(2, 1, '2018-04-10'),
(2, 9, '2018-06-08'),
(1, 7, '2018-10-12'),
(1, 10, '2018-11-11'),
(7, 8, '2018-01-01'),
(6, 4, '2018-01-03'),
(3, 3, '2018-03-04');

SELECT * FROM programari;
SET sql_safe_updates = 0;
UPDATE programari SET data_finalizare = DATE_ADD(data_incepere, INTERVAL 4 MONTH);
SET sql_safe_updates = 1;
SELECT nume, prenume, denumire FROM profesori CROSS JOIN cursuri;
SELECT nume, prenume, denumire FROM profesori CROSS JOIN cursuri WHERE tara_origine = "Romania";
SELECT COUNT(nume) FROM profesori CROSS JOIN cursuri WHERE tara_origine = "Romania";

SELECT cursuri.denumire, programari.data_incepere FROM cursuri INNER JOIN programari WHERE cursuri.id = programari.id_curs;

SELECT profesori.nume, profesori.prenume FROM profesori JOIN programari ON profesori.id = programari.id_profesor AND tara_origine = "Romania" ;
SELECT * FROM cursuri;
#CERINTA: Sa se afiseze o lista cu profesorii si cursurile acestora.

SELECT profesori.nume, profesori.prenume, cursuri.denumire FROM profesori INNER JOIN programari ON profesori.id = programari.id_profesor INNER JOIN cursuri ON programari.id_curs = cursuri.id;
SELECT cursuri.denumire, programari.data_incepere, programari.data_finalizare
FROM cursuri LEFT JOIN programari ON cursuri.id = programari.id_curs;
SELECT cursuri.denumire, programari.data_incepere, programari.data_finalizare
FROM programari RIGHT JOIN cursuri ON cursuri.id = programari.id_curs;

# CERINTA: Profesorii si cursurile predate de acestia. Pentru cei ce nu predau cursuri, sa se afiseze NULL pentru campul de curs

# REZOLVARE:

SELECT profesori.nume, profesori.prenume, cursuri.denumire
FROM profesori 
LEFT JOIN programari ON profesori.id = programari.id_profesor
LEFT JOIN cursuri ON cursuri.id = programari.id_curs;

SELECT 1, 2
	UNION
SELECT 3, 4
	UNION
SELECT 5, 6;
