CREATE DATABASE IF NOT EXISTS cursbd_8;
CREATE TABLE ofertaturistica(
  id_ofertaturistica INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  destinatie VARCHAR(200),
  pret DOUBLE(7,2),
  tip VARCHAR(100),
  durata int(2)  #un numar de doua cifre int(2)
);

CREATE TABLE rezervare(
  id_rezervare INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  turist VARCHAR(100),
  nr_turisti INT(2),
  data_rezervare DATE,
  id_ofertaturistica INT(11),
  FOREIGN KEY (id_ofertaturistica) REFERENCES ofertaturistica(id_ofertaturistica)
);

INSERT INTO ofertaturistica VALUES
(NULL, 'Londra',1200,'sejur',5),
(NULL, 'Paris', 1000, 'citybreak',3),
(NULL, 'Italia', 2300, 'circuit',10),
(NULL, 'Grecia',800,'sejur',6),
(NULL, 'Scotia', 1700, 'circuit',11);

SELECT * FROM ofertaturistica;

INSERT INTO rezervare VALUES
(NULL,'Popescu',2,20170715,2),
(NULL,'Ionescu',3,20170710,5),
(NULL,'Georgescu',2,20170725,1),
(NULL,'Marinescu',4,20170730,1),
(NULL,'Teopescu',2,20170701,3),
(NULL,'Andrescu',3,20170705,4);

SELECT * FROM rezervare;

# VARIABILE GLOBALE
SET @X = 10;
SELECT @X;

SET @X = "hello";
SELECT @X;

# varianta 2:
SELECT @y := 100;

#varianta 3:
SELECT 30 INTO @z; # seteaza var globala z cu valoarea 30
SELECT @z;

SET @u = 100;
SELECT 1000 INTO @u;
SELECT @u;

#PROCEDURI !!  - atentie!!! nu putem avea doua proceduri cu acelasi nume - eroare
/*
	= un asamblu de instructiuni care se stocheaza pe un server
    
    Cand se folosesc procedurile / la ce sunt utile?
    - se folosesc pt operatii complexe repetitive - care se fac f des
    - informatia este securizata oferind acces indirect la BD prin intermediul procedurii 

sintaxa crearea procedura:

	DELIMITER//
    CREATE PROCEDURE nume_procedura (param1, param2, ... , paramn)
    BEGIN
		..... INSTRUCTIUNI ;...
    END
    //
    DELIMITER;

sintaxa pentru apelarea unei proceduri:
	CALL nume_procedura(param1, param2, ... , paramn)
    
sintaxa pentru stergerea unei proceduri:
	DROP PROCEDURE nume_procedura; # obs! nu ne intereaza lista de parametri

*/

SELECT COUNT(turist) FROM rezervare;

# sa se construiasca o procedura ce determina numarul de rezervari din tabela;

DELIMITER //
CREATE PROCEDURE afisareNrRezervari()
BEGIN
    SELECT COUNT(id_rezervare) FROM rezervare;
END;
//
DELIMITER ;

CALL afisareNrRezervari();

# inserati o noua rezervare in tabela;

INSERT INTO rezervare VALUES
(NULL,'Draganescu',3,20170714,2);

SELECT COUNT(*) FROM ofertaturistica WHERE tip = "sejur";
SELECT COUNT(*) FROM ofertaturistica WHERE tip = "citybreak";
SELECT COUNT(*) FROM ofertaturistica WHERE tip = "circuit";

# afisareNrOferteTuristice("sejur");

DELIMITER //
CREATE PROCEDURE afisareNrOferteTuristice( IN tipOfertaTuristica VARCHAR(100))
BEGIN 
    SELECT COUNT(*) FROM ofertaturistica WHERE tip = tipOfertaTuristica;
END;
//
DELIMITER ;

CALL afisareNrOferteTuristice("sejur");
CALL afisareNrOferteTuristice("citybreak");
CALL afisareNrOferteTuristice("circuit");

# sa se calculeze valoarea unei rezervari 
# valoare rezervare = pret * nr_turisti;
# cat valoreaza prima rezervare din tabel?

SELECT ofertaturistica.pret * rezervare.nr_turisti FROM ofertaturistica INNER JOIN rezervare ON ofertaturistica.id_ofertaturistica = rezervare.id_ofertaturistica;

DELIMITER //
CREATE PROCEDURE valoareRezervare(IN id_rezervare TINYINT, OUT valoare DOUBLE)
BEGIN
   SELECT o.pret * r.nr_turisti INTO valoare FROM
   ofertaturistica AS o INNER JOIN rezervare AS r
   ON o.id_ofertaturistica = r.id_ofertaturistica
   WHERE r.id_rezervare = id_rezervare;

END;
//
DELIMITER ;
DROP PROCEDURE valoareRezervare;

# parametrii de iesire se transmit intotdeauna ca variabile globale
CALL valoareRezervare(1, @valoare);
SELECT @valoare;

# FOLOSIREA UNUI PARAMETRU DE TIP INTRARE IESIRE

DELIMITER //
CREATE PROCEDURE modificaNr(INOUT nr INT)
BEGIN
   SET nr = nr * 2;
END;
//
DELIMITER ;

SELECT @numar := 10;
CALL modificaNr(@numar);
SELECT @numar;

# TEMA - scoateti niste concluzii la proceduri - UTILE (idei principale)

# FUNCTII

SELECT destinatie, COUNT(id_rezervare) FROM ofertaturistica INNER JOIN rezervare WHERE ofertaturistica.id_ofertaturistica = rezervare.id_ofertaturistica GROUP BY destinatie;

DELIMITER //
CREATE FUNCTION nrRezervariPerDestinatie (numeDestinatie VARCHAR(100)) RETURNS INT
BEGIN

   DECLARE rezultat INT DEFAULT 0;

   SELECT COUNT(id_rezervare) INTO rezultat FROM rezervare r INNER JOIN ofertaturistica o 
   WHERE o.id_ofertaturistica = r.id_ofertaturistica
   AND o.destinatie = numeDestinatie;
   
   RETURN rezultat;
   
END;
//
DELIMITER ;

SELECT nrRezervariPerDestinatie("Londra");
SELECT nrRezervariPerDestinatie("Grecia");
SELECT nrRezervariPerDestinatie("Italia");



DELIMITER //
CREATE FUNCTION decizieOferta (idOferta INT, bugetMax INT ) RETURNS VARCHAR(100)
BEGIN
	DECLARE pretOferta INT; 
    DECLARE mesaj VARCHAR(100);
    SELECT pret INTO pretOferta FROM ofertaturistica WHERE id_ofertaturistica = idOferta;
  
	IF pretOferta <= bugetMax THEN
        SET mesaj := "Oferta acceptata!";
	ELSE
		SET mesaj := "Oferta refuzata!";
	END IF;
    
    RETURN mesaj;
END;
//
DELIMITER ;

SELECT decizieOferta(1, 1000);
SELECT decizieOferta(1, 1500);

# O functie care determina ziua saptamanii a inceputului unei rezervari al carui ID este parametrul de intrare


DELIMITER //
CREATE FUNCTION ziuaSaptamanii_inceput(id_rezervare INT) RETURNS VARCHAR(100)
BEGIN
	DECLARE ziuaSaptamanii INT;
    DECLARE zi VARCHAR(100);
    
    SELECT dayofweek(data_rezervare) INTO ziuaSaptamanii FROM rezervare WHERE id_rezervare = rezervare.id_rezervare;

CASE ziuaSaptamanii
    WHEN  1 THEN SET zi := "Duminica";
    WHEN  2 THEN SET zi := "Luni";
    WHEN  3 THEN SET zi := "Marti";
    WHEN  4 THEN SET zi := "Miercuri";
    WHEN  5 THEN SET zi := "Joi";
    WHEN  6 THEN SET zi := "Vineri";
    WHEN  7 THEN SET zi := "Sambata";
 END CASE;
 
 RETURN zi;
 
END;
 //
 DELIMITER ;
 
 SELECT ziuaSaptamanii_inceput(4);
 
 
 DELIMITER //
 CREATE FUNCTION factorial(N INT) returns int
 BEGIN
     DECLARE rezultat INT DEFAULT 1;
     
     factorial:LOOP
        SET rezultat = N * rezultat;
        SET N:= N - 1;
        IF N = 0 THEN
            LEAVE factorial;
		END IF;
	END LOOP;
     
	RETURN rezultat;
 END;
 //
 DELIMITER ;
 
SELECT factorial(4);
SELECT factorial(5);


