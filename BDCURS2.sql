#crearea primei noastre baze de date 
#sintaxa: CREATE DATABASE IF NOT EXISTS <nume_baza_de_date>;
CREATE DATABASE IF NOT EXISTS bdcurs2;
#activarea unei baze de date - sa spun la nivelul carei baze de date vreau sa execut comenziile viitoare
#sintaxa: USE <nume_baza_de_date>;
USE bdcurs2;

#stergerea unei baze de date
#sintaxa: DROP DATABASE <nume_baza_de_date>;
#DROP DATABASE bdcurs2;

/*
CREATE TABLE IF NOT EXISTS <nume_tabela> (
	<nume_atribut> <tip_date> <modificator> <restrictrii>,
	<nume_atribut> <tip_date> <modificator> <restrictrii>,
	<nume_atribut> <tip_date> <modificator> <restrictrii>,
	...................................................
	<nume_atribut> <tip_date> <modificator> <restrictrii>
);
*/

#persoane - id- pk, nume,  prenume, data_nastare, cnp, stare_civila, nationalitate
CREATE TABLE IF NOT EXISTS persoane(
	id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nume VARCHAR(50) NOT NULL,
    prenume VARCHAR(100) NOT NULL,
    data_nastere DATE NOT NULL,
    CNP CHAR(13) NOT NULL UNIQUE,
    stare_civila ENUM ('Necasatorit', 'Casatorit', 'Divortat'),
    nationalitate VARCHAR(100) NOT NULL DEFAULT 'Romana'
);

#vizualizarea datelor din tabela 
#varianta 1: sintaxa: DESCRIBE <nume_tabela>; - pt vizualizarea structuri tabelei (atribut/tip data/restrictii)
DESCRIBE persoane;
#varianta 2: sintaxa: SELECT * FROM <nume_tabela>; - pt vizualizarea inregistrarilor din tabela 
SELECT * FROM persoane;

#comenzi pentru modificarea structurii tabelei
#1.adaugarea unui nou atribut in tabela - email;
#SINTAXa: ALTER TABLE <nume_tabela> ADD <nume_atribut> <tip_date> <restricii>;
ALTER TABLE persoane ADD email VARCHAR(200);
#tema - studiu : cum pot face (ce comanda folosesc) sa adaug atribut telefon dupa atribut CNP

#2.modifcarea unui atribut existent din email vreau sa il redenumesc adresa_email si sa contina restrictia not null
#sintaxa: ALTER TABLE <nume_tabela> CHANGE <atribut_vechi> <atribut_nou> <tip_date> <restricii>;
ALTER TABLE persoane CHANGE email adresa_email VARCHAR(250) NOT NULL;

#3. stergerea unui atribut din tabela;
#sintaxa: ALTER TABLE <nume_tabela> DROP <nume_atribut>;
ALTER TABLE persoane DROP stare_civila;

#4. redenumirea unei tabele
#v1:ALTER TABLE <nume_tabela_existenta> RENAME TO <nume_nou_tabela>;
ALTER TABLE persoane RENAME TO angajati;
#v2:
RENAME TABLE angajati TO studenti;

/*
ALTER TABLE - ADD - adaugare atribut
			- CHANGE - modificarea unui atribut
            - DROP - stergerea unui atribut
            - RENAME TO - modificarea numelui unei tabele
*/

DESCRIBE studenti;

#eliminare primary key  - se face in 2 pasi 
#paSul 1: eliminare AUTOINCREMENTUL 
ALTER TABLE studenti CHANGE id id TINYINT NOT NULL;
#pasul2: eliminare CHEIE PRIMARE
ALTER TABLE studenti DROP PRIMARY KEY;
/*
OBS! - putem avea o cheie primara fara auto_increment 
	 - nu putem avea auto_increment fara cheie primara
*/

# 2 tabele - care se afla intr-o relatie one-to-many 
# edituri - carti (1 - n)  
# edituri - atributele: id, denumire; PARINTE
# carti - atributele: id, titlu, autor, isbn , pret; COPIL - cheie externa

#INTOTDEAUNA IMPLEMENTAREA VA INCEPE CU TABELA PARINTE 

CREATE TABLE IF NOT EXISTS edituri(
	id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    denumire VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS carti (
	id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    titlu VARCHAR(100) NOT NULL,
    autor VARCHAR(50) NOT NULL,
    ISBN CHAR(13) NOT NULL UNIQUE,
    pret DECIMAL(5,2),
    id_editura TINYINT,
    FOREIGN KEY(id_editura) REFERENCES edituri(id)
);

DESCRIBE carti;

#eliminare foreign key - elimare legatura/relatie dintre cele 2 tabele 
# carti_ibfk_1 ( tabelacopil_ibfk_1)
ALTER TABLE carti DROP FOREIGN KEY carti_ibfk_1;

#adaugarea unei relatii la loc intre 2 tabele
ALTER TABLE carti ADD FOREIGN KEY(id_editura) REFERENCES edituri(id);


#comanza SHOW - vizualizarea diferitor informatii intr-o bazadedate
SHOW TABLES; #LISTA CU TOATE TABELELE EXISTE IN ACEAST BD
SHOW DATABASES;#LISTA CU TOATE BAZELE DE DATE EXISTENTE
SHOW ERRORS;
SHOW WARNINGS;

#STERGEREA TABELELOR
#OBS! - atunci cand tabele se afla relatie 1-n prima data se sterge tabela copil dupa care tabela parinte
DROP TABLE carti;
DROP TABLE edituri;

#sa construiti o relatie 1-n intre cele 2 tabele
#departamente - angajati ( 1 - n)
#departamente - id, denumire, acronim (prescurtare denumire)
#angajati - id, nume, prenume, data_angajare DATE, data_demisie DATE, salariu 

#PAS0: CINE E PARINTE? CINE E COPIL?
#PAS1: UNDE ADAUG FK?
#PAS2: PE CINE IMPLEMENTEZ PRIMA DATA? parintele 

CREATE TABLE IF NOT EXISTS departamente (
	id TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	denumire VARCHAR(100) NOT NULL,
	acronim VARCHAR(5) NOT NULL
);
CREATE TABLE IF NOT EXISTS angajati(
	id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	nume VARCHAR(50) NOT NULL ,
	prenume VARCHAR(50) NOT NULL ,
	data_angajare DATE NOT NULL ,
	data_demisie DATE,
	salariu FLOAT NOT NULL,
	id_departamente TINYINT,
	FOREIGN KEY (id_departamente) REFERENCES departamente(id)
);
#popularea tabelor cu date
#varianta1 - cea mai restrictiva cand nu se specifica ce atribute se insereaza este obligatoriu sa le populam in ordine 

INSERT INTO departamente VALUES 
(NULL, 'Development', 'DEV'),
(NULL, 'QualityInsurance', 'QA');

SELECT * FROM departamente;

#varainta2 - specificam doar atributele pe care vrem sa le inseram in ordinea aleasa de noi
INSERT INTO departamente(acronim, denumire) VALUES
('HR', 'HumanResources'),
('Acc', 'Accounting');

#varianta3 - specificam nominal valorile folosita de obicei cand vrem sa introducem o singura inregistrare
INSERT INTO departamente SET denumire = 'Operations', acronim = 'op';

#varianta4 - inserarea unei inregistrari cu valorile DEFAULT sau doar NULL
INSERT INTO departamente VALUES (),(); #introducere de 2 inregistrari goale intr o tabela 
INSERT INTO departamente VALUES ();


INSERT INTO angajati VALUES
(NULL, 'Preda', 'Dan', '2019-02-22', NULL, 4300, 2),
(NULL, 'Adrian', 'Matei', '2018-05-05', NULL, 5700, 3),
(NULL, "Savu", "Dan", "2020-05-15", "2021-06-28", 5000, 3),
(NULL, 'GEORGE','MIHAI','2020-03-04', NULL, 2500, 2),
(NULL, 'Popa', 'Vasile', '2022-02-15', NULL, 3500, 4),
(NULL, 'Florescu', 'Marian', '2020-04-02', NULL, 6000, 3),
(NULL, 'Stan', 'Georgiana', '2023-01-25', NULL, 4200, 1),
(NULL, 'Iordache', 'Vlad', '2021-08-14', NULL, 3400, 4),
(NULL, 'Gheorghe', 'Ana', '2022-05-30', NULL, 4800, 2),
(NULL, 'Petrescu', 'Ionut', '2021-09-03', NULL, 3900, 3),
(NULL, 'Dragoi', 'Catalina', '2020-12-22', NULL, 4300, 1),
(NULL, 'Barbu', 'Valentin', '2023-04-01', NULL, 4100, 4),
(NULL, 'Dobre', 'Roxana', '2022-02-08', NULL, 3600, 2),
(NULL, 'Marin', 'Eugenia', '2021-07-09', NULL, 5200, 3),
(NULL, 'Nicolescu', 'Stefan', '2022-11-11', NULL, 4700, 1),
(NULL, 'Vasilescu', 'Diana', '2023-03-19', NULL, 3900, 4),
(NULL, 'Tudor', 'Bogdan', '2020-10-05', NULL, 5100, 2),
(NULL, 'Gavril', 'Simona', '2021-12-14', NULL, 4300, 3),
(NULL, 'Filip', 'Mirela', '2023-08-22', NULL, 4800, 1),
(NULL, 'Stoica', 'George', '2022-06-29', NULL, 4200, 4),
(NULL, 'Radu', 'Ioana', '2021-10-09', NULL, 4000, 2),
(NULL, 'Dinu', 'Gabriel', '2020-03-18', NULL, 5300, 3),
(NULL, 'Stefanescu', 'Larisa', '2023-05-07', NULL, 4400, 1),
(NULL, 'Popa', 'Mihai', '2022-09-02', NULL, 3800, 4),
(NULL, 'Georgescu', 'Carmen', '2021-12-05', NULL, 4700, 2),
(NULL, 'Ciobanu', 'Victor', '2020-05-30', NULL, 5500, 3),
(NULL, 'Munteanu', 'Roxana', '2023-03-15', NULL, 4100, 1),
(NULL, 'Dima', 'Paul', '2022-10-10', NULL, 4000, 4);

SELECT * FROM angajati;


#actualizarea datelor din tabela 

#sintaxa: UPDATE <nume_tabela> SET atribut1=val1, atribut2 = val2 , .... WHERE conditie;

#astazi dima paul si-a dat demisia, sa se actualizeze tabela angajati
SET sql_safe_updates = 0; #dezactiveaza
UPDATE angajati SET data_demisie = CURDATE() WHERE nume = 'Dima' AND prenume = 'Paul';
SET sql_safe_updates = 1; #activare

#preda dan a primit o majorare cu 10 la suta a salariului
UPDATE angajati SET salariu = 1.1 * salariu WHERE id = 1;


#salariu + 10/100 * salariu = salariu + 0.1 *salariu = salariu ( 1 + 0.1 ) = salariu * 1.1