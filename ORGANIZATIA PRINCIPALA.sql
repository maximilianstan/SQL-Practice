CREATE DATABASE IF NOT EXISTS organizatia_principala;
USE organizatia_principala;
CREATE TABLE IF NOT EXISTS magazine (
id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
denumire VARCHAR(50),
telefon CHAR(10) NOT NULL UNIQUE,
faliment ENUM ("Da", "Nu") NOT NULL,
locatie VARCHAR(100),
cifra_afaceri CHAR(10) NOT NULL
);
DESCRIBE magazine;
CREATE TABLE IF NOT EXISTS angajati (
id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nume VARCHAR(100) NOT NULL,
prenume VARCHAR(100) NOT NULL,
telefon CHAR(10),
CNP CHAR(13) NOT NULL UNIQUE,
stare_civila ENUM ('Necasatorit', 'Casatorit', 'Divortat'),
e_mail VARCHAR(100),
departament VARCHAR(80),
salariu MEDIUMINT,
data_angajarii DATE,
id_magazin TINYINT,
FOREIGN KEY (id_magazin) REFERENCES magazine(id)
);
DESCRIBE angajati;
CREATE TABLE IF NOT EXISTS furnizori (
id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
denumire VARCHAR(50) NOT NULL,
locatie VARCHAR(100),
telefon CHAR(10)
);
DESCRIBE furnizori;

CREATE TABLE IF NOT EXISTS produse (
id MEDIUMINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
brand VARCHAR(100) NOT NULL,
denumire VARCHAR(200) NOT NULL,
pret_lei MEDIUMINT,
id_furnizor TINYINT,
id_magazin TINYINT,
stoc_furnizor ENUM ("Da", "Nu"),
FOREIGN KEY (id_furnizor) REFERENCES furnizori(id),
FOREIGN KEY (id_magazin) REFERENCES magazine(id)
);

DESCRIBE produse;

CREATE TABLE IF NOT EXISTS clienti (
id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nume VARCHAR(100) NOT NULL,
prenume VARCHAR(100) NOT NULL,
telefon CHAR(10),
locatie VARCHAR(100),
e_mail VARCHAR(100)
);
DESCRIBE clienti;

CREATE TABLE IF NOT EXISTS comenzi (
id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
total_plata_lei MEDIUMINT,
plata_cash BOOL,
id_magazin TINYINT,
id_produs MEDIUMINT,
id_client TINYINT,
FOREIGN KEY (id_magazin) REFERENCES magazine(id),
FOREIGN KEY (id_produs) REFERENCES produse(id),
FOREIGN KEY (id_client) REFERENCES clienti(id)
);

DESCRIBE comenzi;

INSERT INTO magazine VALUES
(NULL, "eMag", "0742726843", "Nu", "Șoseaua Virtuții 148", "7100000000");
SELECT * FROM magazine;
INSERT INTO magazine VALUES
(NULL, "Flamingo Computers", "0212108500", "Da", "Soseaua Bucuresti Ploiesti 44", "0"),
(NULL, "Flanco", "0318059212", "Nu", "Splaiul Independentei 210", "616622500"),
(NULL, "Altex", "0215289196", "Nu", "Calea Giulesti 1-3", "6500724000"),
(NULL, "PC Garage", "0372007075", "Nu", "Strada Ciorogarlei 214", "319100450"),
(NULL, "Germanos", "0214330760", "Da", "Bulevardul Iuliu Maniu 160", "0"),
(NULL, "UltraPro Computers", "0216643485", "Da", "Strada Aviator Mircea Zorileanu 74", "0"),
(NULL, "iStyle", "0743160282", "Nu", "Bulevardul General Paul Teodorescu 4", "17748092");

INSERT INTO magazine VALUES
(NULL, "Vexio", "0374477111", "Nu", "Strada Oxigenului 1H", "120450872"),
(NULL, "Orange", "0374300300", "Nu", "Calea Grivitei 216", "6022034200");

INSERT INTO angajati VALUES
(NULL, "Dragomir", "Alexandru", "0723998645", "1881773746322", "Casatorit", "dragomiralex2@yahoo.com", "Vanzari", "3400", "2022-01-10", "3"),
(NULL, "Cislariu", "Raluca", "0733789645", "1851773736312", "Necasatorit", "cislarium21@gmail.com", "HR", "4100", "2019-03-02", "4"),
(NULL, "Canacheu", "Adrian", "0743112645", "1831773736326", "Necasatorit", "canacheuar@gmail.com", "Marketing", "2500", "2022-02-01", "5"),
(NULL, "Petrescu", "Iulian", "0724131435", "1831343736326", "Casatorit", "petrescuene@outlook.com", "IT", "5000", "2021-05-02", "8"),
(NULL, "Antonache", "Sebastian", "0788463542", "1831213736355", "Divortat", "antonachezz@yahoo.com", "Management", "6300", "2020-04-03", "1"),
(NULL, "Paulescu", "Samirov", "0764238764", "1831213736361", "Casatorit", "raulpaul22@gmail.com", "IT", "7500", "2014-07-07", "4"),
(NULL, "Dragomirescu", "Cristian", "0742187455","1831213736362", "Casatorit", "coldragomir@yahoo.com", "Vanzari", "4000", "2017-06-02", "5"),
(NULL, "Predonescu", "Florin", "0729756332", "1831413736261", "Necasatorit", "predonescuss@gmail.com", "Management", "0", "2006-03-06", "6"),
(NULL, "Boanghina", "Alina", "0744674223", "3211413736261", "Casatorit", "boanghinaalina@outlook.com", "Management", "0", "2004-04-10", "7"),
(NULL, "Giurgiu", "Vlad", "0711234874", "1831419936261", "Necasatorit", "girgiuleu@yahoo.com", "Management", "0", "2008-01-11", "2"),
(NULL, "Stoianica", "Irinel", "0754377543", "1831413736551", "Casatorit", "irinescuban@outlook.com", "HR", "3700", "2012-05-10", "3"),
(NULL, "Avramescu", "Iordache", "0745329122", "1654413736551", "Casatorit", "avramiord@yahoo.com", "Vanzari", "2800", "2018-05-07", "4"),
(NULL, "Ploiesteanu", "Alexandra", "0745835195", "1318413736551", "Necasatorit", "alexanhow@gmail.com", "IT", "4100", "2017-09-12", "8"),
(NULL, "Ionescu", "Rodica", "0732111245", "1318414321510", "Casatorit", "rodisan15@yahoo.com", "IT", "6240", "2015-02-10", "10"),
(NULL, "Ispirescu", "Emil", "0789123775", "1308410321510", "Necasatorit", "emiljack@gmail.com", "IT", "7600", "2013-09-09", "9"),
(NULL, "Dumitru", "Cornel", "0755342174", "1008410321540", "Casatorit", "ecornel124@gmail.com", "IT", "5900", "2018-10-04", "5"),
(NULL, "Andronic", "Iacob", "0799812343", "2208410321210", "Divortat", "andronicsub@yahoo.com", "IT", "8800", "2013-06-12", "1"),
(NULL, "Sechelariu", "Madalina", "0712341224", "2408410321510", "Necasatorit", "madalin0@gmail.com", "IT", "7100", "2014-01-04", "3"),
(NULL, "Sarbulescu", "Diana", "0788231222", "4408410321510", "Casatorit", "dianasus@yahoo.com", "IT", "3900", "2019-02-01", "8"),
(NULL, "Pestritu", "Nicusor", "0766231556", "4808410321510", "Divortat", "nicusorabram@outlook.com", "Vanzari", "2900", "2017-03-04", "10");

SELECT * FROM angajati;

