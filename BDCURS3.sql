#        Tema CURS4 – baze de date
#        Sa se creeze o baza de date cu numele ‘tema3_bd’ ce contine 2 tabele ( librarii si carti) intre care va exista o relatie de 1-n (one to many).

#        Cerinte:
# 1.	Sa se defineasca baza de date cu tabele .
#       Tabela CARTI: (id, titlu, autor, data_apartie, editura, gen -> ENUM (‘drama’, ‘SF’…etc)
#       Tabela LIBRARII: (id, nume, nr_carti, vechime)
# 2.	Sa se adauge o noua coloana in tabela CARTI denumita pret si sa se stearga coloana editura.
# 3.	Sa se populeze cele doua tabele cu date, tinand cont de schimbarile facute la nivelul tabelei carti ( existenta coloanei pret si eliminarea coloanei editura)
# 4.	Sa se updateze titlul cartii cu id-ul 3 in ‘carte3‘. 
# 5.	Sa se majoreze pretul cartilor din genul drama si SF cu 15% din pretul initial avut.
# 6.	Sa se determine pretul maxim, minim si mediu a cartilor existente.
# 7.	Sa se determine cartile care au pretul ce depaseste valoarea de 15lei.
# 8.	Sa se determine librariile cu o vechime mai mare de 10 ani.
# 9.	Sa se determine numarul de carti. (Cate carti avem?)
# 10.	Sa se determine cartile a caror nume contine in componenta sa litera ‘a’.
# 11.	Sa se ordoneze in ordine alfabetica cartile dupa titlu.
# 12.	Sa se determine cea mai scumpa carte si cea mai ieftina carte. (indicatie: clauza LIMIT)
# 13.	Stergea tuturor cartilor care au anul de aparitie mai mic de 2000. 
#       (indicatie: YEAR(data_apartie) – pentru extragerea anului din data_aparitie )
# 14.	Sa se elimine cheia primara a tabelei carti.
# 15.	Sa se elimine foreign key a tabelei carti, dupa care sa se adauge la loc.
# 16.	Sa se stearga cele doua tabele.
# 17.	Sa se stearga baza de date  ‘tema3_bd’.
#18.    Explicati in cuvinte diferenta dintre clauza DELETE si TRUNCATE mentionand toate aspectele pe care le veti gasi cautand pe internet singuri


------------------------------------------------------------------------------------------------------------------------------------------------

# ****** REZOLVARE - 18  TRUNCATE - sterge si recreeaza tabela in cauza 

------------------------------------------------------------------------------------------------------------------------------------------------

CREATE DATABASE tema3_bd;
CREATE TABLE IF NOT EXISTS LIBRARII (
id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nume VARCHAR(50),
nr_carti MEDIUMINT,
vechime YEAR
);

CREATE TABLE IF NOT EXISTS carti (
id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
titlu VARCHAR(50),
autor VARCHAR(100),
data_aparitiei DATE,
editura VARCHAR(50),
gen ENUM('Drama','SF','Romantic','Motivational','Stiintific','Filozofie','Educatie','Arta','Politica','Poezie','Memorialistica','Nuvela'),
id_librarie TINYINT,
FOREIGN KEY(id_librarie) REFERENCES librarii(id)
);

DESCRIBE librarii;
DESCRIBE carti;
ALTER TABLE carti ADD pret TINYINT;
ALTER TABLE carti DROP editura;

INSERT INTO librarii VALUES 
(NULL, 'Libraria Mihai Eminescu', '3', '1967'),
(NULL, 'Libraria Humanitas', '10', '1990'),
(NULL, 'Libraria Ion Creanga', '7', '1985'),
(NULL, 'Libraria Carturesti', '12', '2000'),
(NULL, 'Libraria Delfin', '8', '1997');

INSERT INTO carti VALUES
(NULL, 'Amintiri din copilarie', 'Ion Creanga', '2020-03-02', 'Memorialistica', '4', '20'),
(NULL, 'Poezii', 'George Cosbuc', '2002-01-07', 'Poezie', '2', '15'),
(NULL, 'Lebada Neagra', 'Nassim Nicholas Taleb', '2007-04-17', 'Filozofie', '4', '35'),
(NULL, 'Dune', 'Frank Herbert', '1965-08-03', 'SF', '3', '25'),
(NULL, 'Hagi Tudose', 'Barbu Stefanescu Delavrancea', '2017-02-02', 'Nuvela', '2', '20'),
(NULL, 'Pretty Woman', 'Fern Michaels', '2005-04-01', 'Romantic', '1', '17'),
(NULL, 'Sanatoriul', 'Sarah Pearse', '2022-01-02', 'Drama', '4', '43'),
(NULL, 'Puterea Prezentului', 'Eckhart Tolle', '2016-04-10', 'Motivational', '2', '32'),
(NULL, 'Vincent Van Gogh', 'Pierre Leprohon', '2010-08-07', 'Arta', '3', '50'),
(NULL, 'Originea Speciilor', 'Charles Darwin', '2023-02-12', 'Stiintific', '1', '46'),
(NULL, 'Managementul Riscului', 'Robert Berezovzky', '2021-06-08', 'Educatie', '2', '35'),
(NULL, 'O istorie traita', 'Paul Niculescu Mizil', '2022-01-10', 'Politica', '5', '28');

SELECT * FROM carti;
SELECT * FROM librarii;

UPDATE carti SET titlu = 'carte3' WHERE id = 3;

SET sql_safe_updates = 0;
UPDATE carti SET pret = 1.15 * pret WHERE gen IN('SF', 'Drama');
SELECT MIN(pret) AS pret_minim FROM carti;
SELECT MAX(pret) AS pret_maxim FROM carti; 
SELECT * FROM carti WHERE pret >15;
SELECT * FROM librarii where vechime <2013;
SELECT SUM(nr_carti) FROM librarii;
SELECT * FROM carti WHERE titlu LIKE '%a%';
SELECT * FROM carti WHERE autor LIKE '%a%';
SELECT * FROM carti ORDER BY titlu ASC;
SELECT * FROM carti ORDER BY pret DESC LIMIT 1;
SELECT * FROM carti ORDER BY pret ASC LIMIT 1;
DELETE FROM carti WHERE data_aparitiei > '2000-00-00';
ALTER TABLE carti DROP PRIMARY KEY;
DROP TABLE carti;
DROP TABLE librarii;
