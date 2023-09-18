create DATABASE IF NOT EXISTS bdcurs9;

CREATE TABLE IF NOT EXISTS bilete_avion(

    ID TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,

    oras_plecare VARCHAR(200) NOT NULL,

    oras_destinatie VARCHAR(100) NOT NULL,
 
    data_plecare DATE NOT NULL,

    data_intoarcere DATE NOT NULL,

    pret FLOAT(7,2) NOT NULL,

    discount TINYINT NOT NULL

);

INSERT INTO bilete_avion VALUES

(NULL, 'Bucuresti','Madrid','2017-11-14','2017-11-23',135, 20),

(NULL, 'Paris', 'Roma', '2017-10-26', '2017-10-31', 115,5),

(NULL, 'Londra', 'Lisabona', '2017-06-10','2017-06-14', 139, 30),

(NULL, 'Bucuresti', 'New York', '2018-02-25', '2018-03-04', 940, 15),

(NULL, 'Bucuresti', 'Praga', '2017-01-26','2017-02-20',140, 5),

(NULL, 'Atena', 'Bucuresti','2017-07-01','2017-07-10', 80, 0),

(NULL, 'Bucuresti', 'Berlin', '2017-12-15','2018-01-05', 70,10),

(NULL, 'Bucuresti', 'Tokyo', '2018-03-26', '2018-04-14', 4000,20),
(NULL, 'Bucuresti', 'Oslo', '2014-09-26','2014-10-26',290,10),

(NULL, 'Tokyo','Ottawa', '2018-04-06', '2018-04-13', 750, 5);

SELECT * FROM bilete_avion;

CREATE TABLE IF NOT EXISTS bilete_vechi_avion(

    ID TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,

    oras_plecare VARCHAR(200) NOT NULL,

    oras_destinatie VARCHAR(100) NOT NULL,

    data_plecare DATE NOT NULL,

    data_intoarcere DATE NOT NULL

);

/*	 CURSORI 

cursor = mecanism prin care putem gestiona (modifica/filtra etc) rezultatul unei instructiuni select

ce ne permite sa facem un cursor?
	- cursorul permite parcurgerea inregistrare cu inregistrare a rezultatului unui select si realizarea diferitelor operatii pentru fiecare inregistrare
    
ETAPELE CARE TREBUIE PARCURSE PENTRU CREAREA UNUI CURSOR

1. setarea delimitatorilor 
2. definirea scheletului procedurii/functiei
3. definire cursor:
	DECLARE <nume_cursor> CURSOR FOR <instructiune_select_al_carui_rezultatul_vrem_sa_il_parcurgem>;
4. pentru fiecare atribut incarcat in cursor se va declara o variabila locala 
5. definirea unei variabile locale de tip semafor (boolean - adev/fals)
	ex: DECLARE semafor VARCHAR(10) DEFAULT 'verde';
6. definire handler: (handler = set de instructiuni care se vor executa atunci cand se genereaza eroarea pt care a fost declarat)
	ex: DECLARE <tip_handler> HANDLER FOR <tip_eroare> BEGIN <instructiuni_de_executat> END;
    
    <tip_handler> - CONTINUE - dupa aparatiei erorii se vor executa incontinuare restul de instructiuni
				  - EXIT - dupa aparatiei erorii executia se opreste in acel moment
7. deschidere cursor:
	OPEN <nume_cursor>;
8. verificare variabbila semafor in interiorul loop ului 
	
    nume_loop: LOOP
		FETCH <nume_cursor> INTO <variabile_locale_definite_la_pasul_4>;
        
	IF semafor == 'rosu' THEN
		LEAVE nume_loop;
	ELSE
		...instructiuni ...
	END IF;
	
    END LOOP;
9. inchidere cursor:
	CLOSE <nume_cursor>;
    

#sa se realizeze o procedura cu un cursor care sa insereze in tabela bilete_vechi_avion toate zborurile din trecut
*/
SELECT oras_plecare, oras_destinatie, data_plecare, data_intoarcere FROM bilete_avion
													WHERE data_intoarcere < curdate();
DELIMITER //
CREATE PROCEDURE gaseste_zboruri_trecute()
BEGIN

    DECLARE v_oras_plecare VARCHAR(100);
    DECLARE v_oras_destinatie VARCHAR(100);
    DECLARE v_data_plecare DATE;
    DECLARE v_data_intoarcere DATE;
	DECLARE semafor VARCHAR(10) DEFAULT 'verde';

	DECLARE c CURSOR FOR SELECT oras_plecare, oras_destinatie, data_plecare, data_intoarcere FROM bilete_avion
													WHERE data_intoarcere < curdate();
                                                    

	DECLARE CONTINUE HANDLER FOR NOT FOUND
    BEGIN
		SET semafor = 'rosu';
    END;
    
    OPEN c;
    
    bilete_vechi: LOOP
		FETCH c INTO v_oras_plecare, v_oras_destinatie, v_data_plecare, v_data_intoarcere;
        
        IF semafor = 'rosu' THEN 
			LEAVE bilete_vechi;
		ELSE 
			INSERT INTO bilete_vechi_avion VALUES (NULL, v_oras_plecare, v_oras_destinatie, v_data_plecare, v_data_intoarcere);
		END IF;
	END LOOP;
    
    CLOSE c;
END;
//
DELIMITER ;

CALL gaseste_zboruri_trecute();
SELECT * FROM bilete_vechi_avion;


#sa se defineasca o functie care primeste ca parametru un oras dat si afiseaza toate destinatiile posibile de zbor din acel oras
#Bucuresti - madrid , new york, praga, tokyo, oslo 

#afisati toate zborurile care au oras de plecare bucuresti 

DELIMITER //
CREATE FUNCTION afla_posibile_destinatiiY( orasPlecare VARCHAR(100)) RETURNS VARCHAR(500)
BEGIN
	DECLARE v_oras_destinatie varchar(200);
    DECLARE semafor varchar(10) DEFAULT 'verde';
	DECLARE rezultat_listDestinatii VARCHAR(500);
	
	DECLARE c CURSOR FOR SELECT oras_destinatie FROM bilete_avion WHERE oras_plecare = orasPlecare;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND
    BEGIN
		SET semafor = 'rosu';
    END;
    
    OPEN c;
    
    destinatii:LOOP
		FETCH c INTO v_oras_destinatie;
        IF semafor = 'rosu' THEN
			LEAVE destinatii;
		ELSE
			SET rezultat_listDestinatii= concat_ws(',', v_oras_destinatie, rezultat_listDestinatii);
		END IF;
	END LOOP;
    
    CLOSE c;
    
    RETURN rezultat_listDestinatii;

END;
//
DELIMITER ;

SELECT afla_posibile_destinatiiY('Bucuresti');


#triggeri 
/*

trigger = set de instructiuni ce se executa automat atunci cand se realizeaza operatii de actualizare a datelor
(INSERT/UPDATE/DELETE) astfel putand sa se modifice valoriile care sunt adaugate/sterge/updatate dintr o tabela 

- un trigger poate fi activati ca si moment de timp INAINTE sau DUPA ce s-a executat instructiuniea asociata lui

sintaxa:

CREATE TRIGGER <nume_trigger> <moment_activare> <tip_operatie> ON <nume_tabela>
FOR EACH ROWN
BEGIN
	<instructiuni de executat>
END;

Legenda:
<nume_trigger> - denumirea pe care noi o dam
<moment_activare> - BEFORE / AFTER
<tip_operatie> - INSERT / UPDATE / DELETE
<nume_tabela> - tabela unde eu vreau sa activeze triggerul meu 
FOR EACH ROW - specifica ca instructiunile din interiorul triggerului se vor executa de fiecare data 
		cand triggerul este activat ;
        
obs! triggerele dintr o bd nu pot avea nume comune
obs! NU PUTEM AVEA DOUA TRIGGERE PE ACEEASI TABELA CARE AU ACELASI MOMENT DECLANSATOR SI ACELASI NUME
(ex: nu putem avea doi triggeri de tipul BEFORE INSERT)


interviu: Cati triggeri putem avea maxim la nivelul unei tabele? 
R: 6 triggeri ( BEFORE INSERT, BEFORE UPDATE, BEFORE DELETE, AFTER INSERT, AFTER UPDATE, AFTER DELETE)
*/

CREATE TABLE IF NOT EXISTS angajati(
	id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nume VARCHAR(50) NOT NULL,
    prenume VARCHAR(50) NOT NULL,
    data_angajare DATE NOT NULL,
    salariu FLOAT(7,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS audit_angajati(
	id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_angajat TINYINT NOT NULL,
    user VARCHAR(50) NOT NULL,
    data_modificare DATE NOT NULL,
    detalii VARCHAR(150) NOT NULL,
    foreign key(id_angajat) REFERENCES angajati(id)
);

DESCRIBE angajati;
DESCRIBE audit_angajati;


#sa se construiasca un trigger care se declanseaza dupa introducearea 
#unui nou angajat si populeaza tabela audit_angajati corespunzator

#ce moment are triggerul?   AFTER
#ce tip de operatie ? INSERT

DELIMITER //
CREATE TRIGGER after_angajati_insert AFTER INSERT ON angajati
FOR EACH ROW
BEGIN
	INSERT INTO audit_angajati VALUES (NULL, NEW.id, user(), curdate(), 
					concat('Angajat nou: ', NEW.nume, ' ',  NEW.prenume));
END;
//
DELIMITER ;


INSERT INTO angajati VALUES(NULL, 'Popa', 'Nicu', '2023-02-02', 5700);
SELECT * FROM angajati;
SELECT * FROM audit_angajati;


INSERT INTO angajati VALUES 
(NULL, 'Ionescu', 'Marian', 20200110, 2850),
(NULL, 'Radu', 'Andrei', 20210503, 3000);


#sa se contruiasca un trigger care se declanseaza inainte de fiecare adaugare a unui angajat
# before insert ( sunt folosit f des pentru validarea corectitudinii datelor introduse)
#numele sa fie intotdeauna scris cu majuscule, verificare data_angajare sa nu fie in viitor, salariu sa nu fie mai maic ca min pe economie

DELIMITER //
CREATE TRIGGER before_angajati_insert BEFORE INSERT ON angajati
FOR EACH ROW
BEGIN

	SET NEW.nume = upper(trim(NEW.nume));
    
    IF NEW.data_angajare > curdate() THEN 
		SET NEW.data_angajare = curdate();
	END IF;
    
    IF NEW.salariu < 1800 THEN
		SET NEW.salariu = 1800;
	END IF;

END;
//
DELIMITER ;

INSERT INTO angajati VALUES (NULL,"Alexandrescu", "Amalia", "2022-01-03", 700);
SELECT * FROM angajati;
SELECT * FROM audit_angajati;



#unui angajat i se modifica salariul sau isi schimba numele
#sa se realizeze un trigger care la fiecare update de salariu/nume logheaza aceasta informatie in tabela audit angajati

#moment/ actiune? AFTER UPDATE!

DELIMITER //
CREATE TRIGGER after_angajati_update AFTER UPDATE ON angajati
FOR EACH ROW
BEGIN

	IF OLD.nume != NEW.nume THEN 
		INSERT INTO audit_angajati VALUES (null, NEW.id, user(), curdate(), 
				concat('schimbare de nume:de la',  OLD.nume, 'la', NEW.nume));
	END IF;
    
    IF OLD.salariu != NEW.salariu THEN 
		INSERT INTO audit_angajati VALUES (NULL, new.id, user(), curdate(),
                   concat('schimbare salariu . ', OLD.salariu, ' -> ', NEW.salariu));
	END IF;
    
END;
//
DELIMITER ;

UPDATE angajati SET nume = 'Eremia', salariu = 5000 WHERE id = 2;


SELECT * FROM angajati;
SELECT * FROM audit_angajati;


