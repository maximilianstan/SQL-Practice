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

