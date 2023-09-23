CREATE DATABASE IF NOT EXISTS organizatia_principala;
USE organizatia_principala;

# CREAREA TABELELOR ( 7 tabele) - EXEMPLE

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
id MEDIUMINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
data_comanda DATE,
tip_plata ENUM("Cash", "Card"),
id_client TINYINT,
FOREIGN KEY (id_client) REFERENCES clienti(id)
);

DESCRIBE comenzi;

CREATE TABLE IF NOT EXISTS facturi (
id_produs MEDIUMINT,
id_comanda MEDIUMINT,
PRIMARY KEY (id_produs, id_comanda),
FOREIGN KEY (id_produs) REFERENCES produse(id),
FOREIGN KEY (id_comanda) REFERENCES comenzi(id),
cantitate MEDIUMINT
);

DESCRIBE facturi;

# INSERT-URI IN TABELELE CREATE - EXEMPLE

INSERT INTO magazine VALUES
(NULL, "eMag", "0742726843", "Nu", "Șoseaua Virtuții 148", "7100000000"),
(NULL, "Flamingo Computers", "0212108500", "Da", "Soseaua Bucuresti Ploiesti 44", "0"),
(NULL, "Flanco", "0318059212", "Nu", "Splaiul Independentei 210", "616622500"),
(NULL, "Altex", "0215289196", "Nu", "Calea Giulesti 1-3", "6500724000"),
(NULL, "PC Garage", "0372007075", "Nu", "Strada Ciorogarlei 214", "319100450"),
(NULL, "Germanos", "0214330760", "Da", "Bulevardul Iuliu Maniu 160", "0"),
(NULL, "UltraPro Computers", "0216643485", "Da", "Strada Aviator Mircea Zorileanu 74", "0"),
(NULL, "iStyle", "0743160282", "Nu", "Bulevardul General Paul Teodorescu 4", "17748092"),
(NULL, "Vexio", "0374477111", "Nu", "Strada Oxigenului 1H", "120450872"),
(NULL, "Orange", "0374300300", "Nu", "Calea Grivitei 216", "6022034200");

SELECT * FROM magazine;

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
(NULL, "Pestritu", "Nicusor", "0766231556", "4808410321510", "Divortat", "nicusorabram@outlook.com", "Vanzari", "2900", "2017-03-04", "10"),
(NULL, "Averescu", "Ilie", "0781223441", "1230567891294", "Casatorit", "iliefrom5@yahoo.com", "Vanzari", "2500", "2019-03-07", "9"),
(NULL, "Sadelica", "Filimon", "0722174363", "1330567891294", "Necasatorit", "sandeloffshore@gmail.com", "Vanzari", "2450", "2018-04-10", "8"),
(NULL, "Rotaru", "Vlad", "0755321344", "1990567891294", "Casatorit", "rotarucom22@yahoo.com", "Vanzari", "2630", "2019-06-02", "5"),
(NULL, "Lupescu", "Marian", "0766475322", "1890567891284", "Necasatorit", "lupeanopt@gmail.com", "Vanzari", "2380", "2020-05-10", "4"),
(NULL, "Joita", "Maria", "0767166488", "1820567891289", "Necasatorit", "mariaforyou6@yahoo.com", "Vanzari", "2270", "2021-03-07", "3"),
(NULL, "Micsulean", "Catalina", "0719445236", "9920567891289", "Divortat", "cata77mics@gmail.com", "Vanzari", "3300", "2016-04-05", "1"),
(NULL, "Jercan", "Gabriela", "0799632553", "0920567891239", "Casatorit", "jercangabi3@gmail.com", "Management", "6700", "2018-10-10", "3"),
(NULL, "Agache", "Laurentiu", "0734173442", "0920567771239", "Necasatorit", "agacheforlife@yahoo.com", "Management", "7200", "2017-03-07", "4"),
(NULL, "Haralambie", "Ioana", "0788447231", "0120567771231", "Casatorit", "ioanaharald@gmail.com", "Management", "12300", "2013-02-08", "5"),
(NULL, "Oncescu", "Aurora", "07934433113", "6120567721231", "Necasatorit", "auroraoncescu@outlook.com", "Management", "10320", "2012-04-08", "8"),
(NULL, "Dimitriu", "Anton", "0745223887", "2120561743230", "Casatorit", "antongalanton@gmail.com", "Management", "8590", "2016-03-05", "9"),
(NULL, "Scarnavu", "Alexandru", "0776445723", "7120561703230", "Divortat", "alexscarn66@outlook.com", "Management", "14500", "2010-04-11", "10"),
(NULL, "Voicescu", "Cristina", "0790450221", "7220591703230", "Necasatorit", "cristina2too@gmail.com", "Marketing", "3700", "2017-05-10", "1"),
(NULL, "Catrinoiu", "Eusebiu", "0746553119", "2220691703230", "Casatorit", "eusebiu2cat@yahoo.com", "Marketing", "4500", "2019-02-08", "3"),
(NULL, "Sechelariu", "Corina", "0799233955", "3220691703230", "Divortat", "sechelariucorina1@gmail.com", "Marketing", "3970", "2021-10-11", "4"),
(NULL, "Andronache", "Andrei", "0777664339", "0220691703238", "Casatorit", "andronacheandrei88@yahoo.com", "Marketing", "4940", "2019-04-01", "8"),
(NULL, "Parvu", "Ionut", "0788544231","0200691903238", "Necasatorit", "parvuion33@gmail.com", "Marketing", "7000", "2018-04-07", "9"),
(NULL, "Bengescu", "Camelia", "0753218990","0120691703230", "Divortat", "bengescucamelia5@gmail.com", "Marketing", "9500", "2015-03-10", "10"),
(NULL, "Caloianu", "Amalia", "0722889112", "9876543219810", "Casatorit", "camicaloianu@gmail.com", "HR", "4200", "2020-03-02", "1"),
(NULL, "Sabanovici", "Irina", "0778890003", "0876543219810", "Necasatorit", "saban4life@gmail.com", "HR", "3980", "2017-05-08", "5"),
(NULL, "Neacsu", "Francesca", "0728891003", "0876543219890", "Necasatorit", "francescap10@gmail.com", "HR", "4700", "2016-03-10", "8"),
(NULL, "Pantea", "Darius", "0775887555", "0876543119890", "Casatorit", "panteadarius@outlook.com", "HR", "5300", "2015-07-07", "9"),
(NULL, "Petrescu", "Mihaela", "0789989665", "1872543119890", "Necasatorit", "mihaelapet3@gmail.com", "HR", "4480", "2022-12-12", "10");

SELECT * FROM angajati;

INSERT INTO furnizori VALUES
(NULL, "Apple", "Palo Alto, California", "0000456771"),
(NULL, "Samsung", "Seul, South Korea", "0000336772"),
(NULL, "Lexmark", "Lexington, KY", "0000456722"),
(NULL, "Canon", "Ota, Tokyo", "0000456622"),
(NULL, "Lenovo", "Hong Kong 22", "0000886722"),
(NULL, "Hewlett-Packard", "Palo Alto, California", "0002256771"),
(NULL, "Microsoft", "Redmond, Washington", "0005556773"),
(NULL, "Corsair", "Milpitas, California", "0004446773"),
(NULL, "Kingston", "Fountain Valley, California", "0006646744"),
(NULL, "Western Digital", "San Jose, California", "0008846714"),
(NULL, "Logitech", "Lausanne 45", "0000451623"),
(NULL, "Toshiba", "Tokyo 22", "0001456642");

SELECT * FROM furnizori;

# MODIFICAREA STRUCTURII TABELELOR PRIN "ALTER TABLE" - EXEMPLE

ALTER TABLE furnizori ADD tara VARCHAR(50);

ALTER TABLE furnizori DROP telefon;

ALTER TABLE furnizori ADD telefon CHAR(10);

ALTER TABLE clienti ADD sex ENUM("Masculin", "Feminin");

ALTER TABLE clienti DROP sex;

# UPDATE - ACTUALIZAREA DATELOR - EXEMPLE

SET sql_safe_updates = 0;

UPDATE furnizori SET tara = "USA" WHERE denumire = "Apple";
UPDATE furnizori SET tara = "USA" WHERE denumire = "Lexmark";
UPDATE furnizori SET tara = "USA" WHERE denumire = "Microsoft";
UPDATE furnizori SET tara = "USA" WHERE denumire = "Hewlett-Packard";
UPDATE furnizori SET tara = "USA" WHERE denumire = "Corsair";
UPDATE furnizori SET tara = "USA" WHERE denumire = "Kingston";
UPDATE furnizori SET tara = "USA" WHERE denumire = "Western Digital";
UPDATE furnizori SET tara = "Elvetia" WHERE denumire = "Logitech";
UPDATE furnizori SET tara = "Japonia" WHERE denumire = "Toshiba";
UPDATE furnizori SET tara = "Japonia" WHERE denumire = "Canon";
UPDATE furnizori SET tara = "Koreea de Sud" WHERE denumire = "Samsung";
UPDATE furnizori SET tara = "China" WHERE denumire = "Lenovo";

SET sql_safe_updates = 1;

INSERT INTO produse VALUES
(NULL, "Apple", "Macbook Pro 13 inch", "9000", "1", "1", "Da"),
(NULL, "Apple", "Macbook Pro 15 inch", "11000", "1", "3", "Da"),
(NULL, "Apple", "Macbook Pro 15 inch", "11500", "1", "1", "Da"),
(NULL, "Apple", "iMac Pro", "7000", "1", "3", "Da"),
(NULL, "Apple", "iMac Pro", "7500", "1", "1", "Da"),
(NULL, "Apple", "iMac Pro", "6900", "1", "4", "Da"),
(NULL, "Apple", "iMac Pro", "7900", "1", "8", "Da"),
(NULL, "Apple", "iPhone 14", "4000", "1", "1", "Da"),
(NULL, "Apple", "iPhone 14", "4100", "1", "3", "Da"),
(NULL, "Apple", "iPhone 14", "3900", "1", "4", "Da"),
(NULL, "Apple", "iPhone 14", "4600", "1", "8", "Da"),
(NULL, "Apple", "iPhone 14", "3900", "1", "10", "Da"),
(NULL, "Canon", "DX10", "2500", "4", "1", "Da"),
(NULL, "Canon", "DX10", "2400", "4", "4", "Da"),
(NULL, "Canon", "DX10", "2300", "4", "9", "Da"),
(NULL, "Canon", "DX10", "2550", "4", "3", "Da"),
(NULL, "Canon", "DX9", "1900", "4", "1", "Nu"),
(NULL, "Canon", "DX9", "2100", "4", "3", "Da"),
(NULL, "Canon", "DX9", "2500", "4", "9", "Nu"),
(NULL, "Canon", "4P00", "3500", "4", "1", "Da"),
(NULL, "Canon", "4P00", "3400", "4", "3", "Da"),
(NULL, "Canon", "4P00", "4000", "4", "5", "Da"),
(NULL, "Canon", "4P00", "2900", "4", "4", "Da"),
(NULL, "Canon", "Xtreme", "9500", "4", "1", "Da"),
(NULL, "Canon", "Xtreme", "9200", "4", "4", "Nu"),
(NULL, "Canon", "Xtreme", "9400", "4", "5", "Da"),
(NULL, "Western Digital", "P2 SSD", "250", "10", "1", "Da"),
(NULL, "Western Digital", "P2 SSD", "195", "10", "3", "Nu"),
(NULL, "Western Digital", "P2 SSD", "200", "10", "4", "Da"),
(NULL, "Western Digital", "P2 SSD", "230", "10", "5", "Da"),
(NULL, "Western Digital", "P2 SSD", "260", "10", "9", "Da"),
(NULL, "Samsung", "S20 Galaxy", "3000", "2", "1", "Da"),
(NULL, "Samsung", "S20 Galaxy", "3100", "2", "3", "Da"),
(NULL, "Samsung", "S20 Galaxy", "2900", "2", "4", "Da"),
(NULL, "Samsung", "S20 Galaxy", "3000", "2", "5", "Nu"),
(NULL, "Samsung", "S20 Galaxy", "3100", "2", "9", "Da"),
(NULL, "Samsung", "S20 Galaxy", "2950", "2", "10", "Da"),
(NULL, "Lexmark", "PrinterPro", "700", "3", "1", "Da"),
(NULL, "Lexmark", "PrinterPro", "710", "3", "3", "Da"),
(NULL, "Lexmark", "PrinterPro", "690", "3", "4", "Da"),
(NULL, "Lexmark", "PrinterPro", "700", "3", "5", "Nu"),
(NULL, "Lexmark", "PrinterPro", "720", "3", "9", "Da"),
(NULL, "Lexmark", "PrinterPro", "750", "3", "8", "Da"),
(NULL, "Lenovo", "Laptop D5", "4600", "5", "1", "Nu"),
(NULL, "Lenovo", "Laptop D5", "4300", "5", "3", "Da"),
(NULL, "Lenovo", "Laptop D5", "4600", "5", "5", "Da"),
(NULL, "Lenovo", "Laptop D5", "4100", "5", "4", "Da"),
(NULL, "Lenovo", "Laptop D5", "4600", "5", "9", "Da"),
(NULL, "Hewlett-Packard", "Laptop 14X Office", "3800", "6", "1", "Da"),
(NULL, "Hewlett-Packard", "Laptop 14X Office", "4000", "6", "2", "Nu"),
(NULL, "Hewlett-Packard", "Laptop 14X Office", "3700", "6", "3", "Da"),
(NULL, "Hewlett-Packard", "Laptop 14X Office", "3600", "6", "4", "Da"),
(NULL, "Hewlett-Packard", "Laptop 14X Office", "3900", "6", "9", "Da"),
(NULL, "Hewlett-Packard", "Laptop 14X Office", "3800", "6", "5", "Nu"),
(NULL, "Microsoft", "Surface Pro", "5700", "7", "1", "Da"),
(NULL, "Microsoft", "Surface Pro", "5300", "7", "4", "Nu"),
(NULL, "Microsoft", "Surface Pro", "5600", "7", "3", "Da"),
(NULL, "Microsoft", "Surface Pro", "5700", "7", "5", "Da"),
(NULL, "Microsoft", "Surface Pro", "5800", "7", "9", "Da"),
(NULL, "Microsoft", "Windows 11 Pro", "150", "7", "1", "Da"),
(NULL, "Microsoft", "Windows 11 Pro", "150", "7", "3", "Da"),
(NULL, "Microsoft", "Windows 11 Pro", "150", "7", "4", "Da"),
(NULL, "Microsoft", "Windows 11 Pro", "150", "7", "5", "Da"),
(NULL, "Microsoft", "Windows 11 Pro", "150", "7", "9", "Da"),
(NULL, "Corsair", "Gaming Keyboard S", "700", "8", "1", "Da"),
(NULL, "Corsair", "Gaming Keyboard S", "690", "8", "3", "Da"),
(NULL, "Corsair", "Gaming Keyboard S", "700", "8", "4", "Da"),
(NULL, "Corsair", "Gaming Keyboard S", "700", "8", "5", "Da"),
(NULL, "Corsair", "Gaming Keyboard S", "710", "8", "9", "Da"),
(NULL, "Kingston", "32 DDR5 RAM ModuleX2", "800", "9", "1", "Da"),
(NULL, "Kingston", "32 DDR5 RAM ModuleX2", "785", "9", "3", "Nu"),
(NULL, "Kingston", "32 DDR5 RAM ModuleX2", "810", "9", "4", "Da"),
(NULL, "Kingston", "32 DDR5 RAM ModuleX2", "810", "9", "5", "Da"),
(NULL, "Kingston", "32 DDR5 RAM ModuleX2", "820", "9", "9", "Da"),
(NULL, "Kingston", "32 DDR5 RAM ModuleX2", NULL, "9", "7", "Nu"),
(NULL, "Kingston", "32 DDR5 RAM ModuleX2", NULL, "9", "2", "Nu"),
(NULL, "Logitech", "Master 3S Mouse", "450", "11", "1", "Da"),
(NULL, "Logitech", "Master 3S Mouse", "420", "11", "3", "Da"),
(NULL, "Logitech", "Master 3S Mouse", "460", "11", "4", "Da"),
(NULL, "Logitech", "Master 3S Mouse", "450", "11", "5", "Da"),
(NULL, "Logitech", "Master 3S Mouse", "440", "11", "9", "Da"),
(NULL, "Logitech", "Master 3S Mouse", "450", "11", "10", "Da"),
(NULL, "Toshiba", "Laptop SL100 Office", "2700", "12", "1", "Da"),
(NULL, "Toshiba", "Laptop SL100 Office", NULL, "12", "2", "Nu"),
(NULL, "Toshiba", "Laptop SL100 Office", "2600", "12", "3", "Da"),
(NULL, "Toshiba", "Laptop SL100 Office", "2800", "12", "4", "Da"),
(NULL, "Toshiba", "Laptop SL100 Office", "2750", "12", "5", "Da"),
(NULL, "Toshiba", "Laptop SL100 Office", NULL, "12", "6", "Nu"),
(NULL, "Toshiba", "Laptop SL100 Office", NULL, "12", "7", "Nu"),
(NULL, "Toshiba", "Laptop SL100 Office", "2500", "12", "9", "Da");

SELECT * FROM produse;

INSERT INTO clienti VALUES
(NULL, "Cretu", "Cristian", "0711884432", "Bulevard Titulescu nr.22 Bloc 10 ap.33, Bucuresti", "cretu.cristian@gmail.com"),
(NULL, "Stan", "Maximilian", "0727188588", "Strada Veronica Micle nr.22 Bloc M5 ap.56, Bucuresti", "maximilian.s@outlook.com"),
(NULL, "Dinca", "Andrei", "0744531887", "Bulevard Baba Novac nr.40 Bloc 4B ap.75,Bucuresti", "dentistcoxat@gmail.com"),
(NULL, "Vacarescu", "Maria", "0756654321", "Piata Amzei nr.40 Casa 2, Bucuresti", "vacarescum.2@yahoo.com"),
(NULL,"Stirbei", "Anita", "0777566112", "Strada Gabroveni nr.4 bloc 7A ap.20, Constanta", "anita4line@gmail.com"),
(NULL, "Chelaru", "Anton", "0745382123", "Strada Aleea Lalelelor nr.10 ap.21,Targu-Jiu", "anton2beton@yahoo.com"),
(NULL, "Tanti", "Auguri", "0777888555", "Strada Proba de Test 88, ap.11, Bucuresti", "tantiauguri222@gmail.com"),
(NULL, "Corcodus", "Mirabela", "0711994433", "Strada Armand nr.3, bloc M1 ap.30, Ilfov", "mirabela221@yahoo.com"),
(NULL, "Nica", "Diana", "0714998812", "Strada Balotesti nr.14 bloc 4 ap. 12, Rovinari", "diana2never@outlook.com"),
(NULL, "Vidrovan", "Teodora", "0755333111", "Strada Poiana Mare nr.32 casa 1, Brasov", "vidrovanteo@yahoo.com"),
(NULL, "Stan", "Alexandra", "0766443228", "Strada Corinelor nr.10 casa 5, Bucuresti", "alexa441@gmail.com"),
(NULL, "Serghei", "Ana-Maria", "0788443210", "Strada Corcodusului nr.9 casa 20, Bucuresti", "serghei1ana@gmail.com"),
(NULL, "Vladislav", "Ioana", "0718443210", "Strada Alunisului nr.1 casa 11, Bucuresti", "ioanavladi@gmail.com"),
(NULL, "Costea", "Bianca", "0718443220", "Strada Secerisului nr.15 casa 2, Ploiesti", "bianca88@gmail.com"),
(NULL, "Sandulescu", "Elvira", "0712223210", "Bulevardul Eroilor nr.10 bloc M2 ap.13, Bucuresti", "sandulescuelvi@gmail.com"),
(NULL, "Bortea", "Ion", "0718483210", "Strada Muncii nr.55 bloc Z4 ap.5, Bucuresti", "borteaion4@gmail.com"),
(NULL, "Vanghelie", "Sandu", "0718443420", "Aleea Petrolului nr.40 casa 7, Giurgiu", "sanduvanghi@yahoo.com"),
(NULL, "Enache", "Amalia", "0218443210", "Strada Pavelelor nr.200 casa 2, Satu Mare", "amaliaenache8@gmail.com"),
(NULL, "Radu", "Cornelia", "0318443242", "Strada Micsunelelor nr.2 bloc 2V, Bucuresti", "corneliaopincar@yahoo.com"),
(NULL, "Radauteanu", "Vasile", "0715555210", "Strada Panaite Istrati nr.4 casa 18 Sinaia", "radauteanu.v@gmail.com");

SELECT * FROM clienti;

INSERT INTO comenzi VALUES
(NULL, "2023-01-12", "Card", "2"),
(NULL, "2022-05-05", "Card", "5"),
(NULL, "2022-07-11", "Card", "6"),
(NULL, "2023-01-10", "Card", "2"),
(NULL, "2023-03-03", "Cash", "7"),
(NULL, "2023-02-10", "Card", "4"),
(NULL, "2023-02-09", "Card", "8"),
(NULL, "2022-12-10", "Cash", "1"),
(NULL, "2022-11-11", "Card", "10"),
(NULL, "2022-09-08", "Card", "12"),
(NULL, "2022-10-08", "Card", "12"),
(NULL, "2023-02-01", "Cash", "9"),
(NULL, "2023-05-10", "Card", "13"),
(NULL, "2023-05-10", "Cash", "14"),
(NULL, "2022-01-10", "Card", "19"),
(NULL, "2021-09-09", "Card", "1"),
(NULL, "2022-04-11", "Card", "8"),
(NULL, "2022-07-12", "Cash", "15");

INSERT INTO comenzi VALUES
(NULL, "2023-07-09", "Card", "14"),
(NULL, "2023-04-05", "Card", "16"),
(NULL, "2022-10-11", "Cash", "10");

SELECT * FROM comenzi;

INSERT INTO facturi VALUES
("1", "9", "1"),
("2", "2", "2"),
("18", "4", "1"),
("34", "3", "1"),
("23", "5", "1"),
("78", "21", "3"),
("50", "1", "5"),
("46", "6", "2"),
("60", "7", "8"),
("49", "8", "6"),
("69", "9", "10"),
("70", "10", "2"),
("42", "11", "1"),
("71", "7", "8"),
("59", "15", "2"),
("30", "7", "8"),
("36", "14", "1"),
("22", "16", "1"),
("37", "18", "1"),
("8", "19", "2"),
("14", "12", "3"),
("29", "13", "2"),
("26", "17", "1"),
("67", "18", "10"),
("74", "20", "25"),
("54", "1", "1"),
("55", "3", "1"),
("78", "4", "3");

SELECT * FROM facturi;

# DELETE - EXEMPLE

SET sql_safe_updates = 0;

DELETE FROM angajati WHERE nume = "Micsulean";

DELETE FROM angajati WHERE nume = "Stoianica";

DELETE FROM angajati WHERE penume = "Iordache";

SET sql_safe_updates = 1;

# INTEROGARI VARIATE CU SELECT 

SELECT * FROM angajati ORDER BY stare_civila;

SELECT * FROM angajati ORDER BY salariu;

SELECT * FROM angajati WHERE salariu < "7000";

SELECT * FROM angajati WHERE data_angajarii > "2014-03-02";

SELECT nume FROM angajati WHERE salariu >= "5000";

SELECT COUNT(id) FROM produse;

SELECT COUNT(nume) FROM angajati;

SELECT COUNT(locatie) FROM magazine;

SELECT COUNT(tara) FROM furnizori WHERE tara = "USA";

SELECT COUNT(prenume) FROM angajati WHERE prenume = "Alexandru";

SELECT COUNT(id) FROM angajati WHERE salariu <= "8000";

SELECT COUNT(id) FROM angajati WHERE stare_civila = "Necasatorit";

SELECT * FROM angajati ORDER BY salariu DESC LIMIT 1, 1;

# SUBINTEROGARI - SUBSELECT

SELECT nume, denumire FROM (SELECT nume, id_magazin FROM angajati WHERE DATE(data_angajarii) > 2018-01-01) 
AS angajat2018 JOIN magazine ON angajat2018.id_magazin = magazine.id;

SELECT prenume, denumire FROM (SELECT prenume, id_magazin FROM angajati WHERE(stare_civila) = "Necasatorit")
AS angajat_necasatorit JOIN magazine ON angajat_necasatorit.id_magazin = magazine.id;

SELECT prenume, denumire, stare_civila FROM (SELECT prenume, id_magazin, stare_civila FROM angajati WHERE(stare_civila) = "Necasatorit")
AS angajat_necasatorit JOIN magazine ON angajat_necasatorit.id_magazin = magazine.id;

SELECT nume, prenume, denumire, salariu FROM (SELECT nume, prenume, id_magazin, salariu FROM angajati WHERE salariu > 4000)
AS angajat_salariat JOIN magazine ON angajat_salariat.id_magazin = magazine.id;

SELECT brand, pret_lei FROM (SELECT brand, id_furnizor, pret_lei FROM produse WHERE pret_lei > 1000)
AS produse_scumpe JOIN furnizori ON produse_scumpe.id_furnizor = furnizori.id;

# JOINS (INNER JOIN /CROSS/OUTER/RIGHT)

SELECT nume, prenume, data_comanda FROM clienti INNER JOIN comenzi ON clienti.id = comenzi.id_client;

SELECT nume, prenume, tip_plata FROM clienti JOIN comenzi ON clienti.id = comenzi.id_client WHERE tip_plata = "cash";

SELECT nume, tip_plata FROM clienti RIGHT JOIN comenzi ON clienti.id = comenzi.id_client WHERE tip_plata = "card";

SELECT furnizori.denumire, tara, produse.denumire, stoc_furnizor FROM furnizori LEFT OUTER JOIN produse
ON furnizori.id = produse.id_furnizor WHERE brand = "Apple";

SELECT furnizori.denumire, produse.denumire, stoc_furnizor FROM furnizori CROSS JOIN produse
ON furnizori.id = produse.id_furnizor WHERE brand = "Lexmark";

# FUNCTII (GROUP/ HAVING)

SELECT COUNT(id), id_magazin FROM angajati GROUP BY id_magazin HAVING COUNT(id) >= 1;

SELECT CONCAT(nume, " ", prenume) angajati FROM angajati GROUP BY id_magazin HAVING COUNT(id) = 5;

SELECT CONCAT(brand, " ", denumire) produs FROM produse GROUP BY pret_lei HAVING pret_lei >1000;

# PREDEFINITE MATEMATICE (>,<, =, DATE)

SELECT CONCAT(prenume, " ", nume) angajat FROM angajati WHERE data_angajarii > 2023-01-01;

SELECT CONCAT(brand, " ", denumire) produs FROM produse WHERE pret_lei >= 2000;

SELECT * FROM angajati WHERE salariu > 2000;

SELECT * FROM angajati ORDER BY stare_civila;

SELECT * FROM furnizori ORDER BY locatie DESC limit 5;

# VIEW-URI TABELE VIRTUALE - EXEMPLE

CREATE OR REPLACE VIEW detalii_comenzi_facturi AS SELECT * FROM facturi JOIN comenzi ON id_comanda = comenzi.id;

SELECT * FROM detalii_comenzi_facturi;

CREATE OR REPLACE VIEW angajat_firma AS SELECT nume, prenume, denumire, salariu, stare_civila FROM angajati JOIN magazine ON angajati.id_magazin = magazine.id;

SELECT * FROM angajat_firma;

CREATE OR REPLACE VIEW produse_furnizori AS SELECT brand, produse.denumire FROM produse JOIN furnizori ON furnizori.id = produse.id_furnizor WHERE pret_lei >2500;

SELECT * FROM produse_furnizori;

# FUNCTII - EXEMPLE

DELIMITER //
CREATE FUNCTION detalii_produse(id MEDIUMINT) RETURNS VARCHAR(500)
BEGIN
    DECLARE denumire_completa VARCHAR(500);
    DECLARE brand VARCHAR(100);
    DECLARE denumire VARCHAR(200);
    SELECT produse.brand, produse.denumire INTO brand, denumire
    FROM produse WHERE produse.id = id;
    SET denumire_completa = CONCAT(brand, " ", denumire);
    
    RETURN denumire_completa;
END;
//
DELIMITER ;

SELECT detalii_produse(20);
SELECT detalii_produse(55);
SELECT detalii_produse(id) FROM produse WHERE id IN (1, 7, 15);

DELIMITER //
CREATE FUNCTION magazine_angajati(id TINYINT) RETURNS VARCHAR(300)
BEGIN
    DECLARE nume_complet VARCHAR(200);
    DECLARE nume VARCHAR(100);
    DECLARE prenume VARCHAR(100);
    SELECT angajati.nume, angajati.prenume INTO nume, prenume
    FROM angajati WHERE angajati.id = id;
    SET nume_complet = CONCAT(nume, " ", prenume);

    RETURN nume_complet;
END;
//
DELIMITER ;

SELECT magazine_angajati(id) FROM angajati WHERE id IN (16, 2, 35);
SELECT magazine_angajati(10);
SELECT magazine_angajati(17);

DELIMITER //
CREATE FUNCTION furnizori_detalii(id TINYINT) RETURNS VARCHAR(300)
BEGIN
    DECLARE brand_si_locatie VARCHAR(400);
    DECLARE branding VARCHAR(50);
    DECLARE locatie_primara VARCHAR(100);
    DECLARE tara_originara VARCHAR(50);
    SELECT furnizori.denumire, furnizori.locatie, furnizori.tara INTO branding, locatie_primara, tara_originara
    FROM furnizori WHERE furnizori.id = id;
    SET brand_si_locatie = CONCAT(branding,'/',locatie_primara, '/', tara_originara);
    
    RETURN brand_si_locatie;
END;
//
DELIMITER ;

SELECT furnizori_detalii(id) FROM furnizori WHERE id IN (2, 4);
SELECT furnizori_detalii(5);
SELECT furnizori_detalii(3);

DELIMITER //
CREATE FUNCTION salariu_final(id TINYINT) RETURNS MEDIUMINT
BEGIN
    DECLARE marire MEDIUMINT DEFAULT 0;
    DECLARE data_de_angajare DATE;
    DECLARE salariul_initial MEDIUMINT;
    SELECT angajati.data_angajarii, angajati.salariu INTO data_de_angajare, salariul_initial
    FROM angajati WHERE angajati.id = id;
   
    IF data_de_angajare <= "01.01.2018" THEN
		SET marire = 500;
	ELSE 
        SET marire = 0;
	END IF;
    IF salariul_initial <= 3000 THEN
		SET marire = 1000;
	ELSE
        SET marire = 0;
    END IF;
    SET marire = salariul_initial + marire;
    
    RETURN marire;
END;
//
DELIMITER ;

SELECT salariu_final(42);
SELECT salariu_final(20);
SELECT salariu_final(id) FROM angajati WHERE id IN (3, 18, 25);


# PROCEDURI - EXEMPLE

DELIMITER //
CREATE PROCEDURE detaliile_magazinelor(IN id TINYINT)
BEGIN
    SELECT CONCAT(denumire, '/', locatie, '/', cifra_afaceri)
    FROM magazine
    WHERE magazine.id = id;
END;
//
DELIMITER ;

CALL detaliile_magazinelor(1);
CALL detaliile_magazinelor(8);
CALL detaliile_magazinelor(4);

DELIMITER //
CREATE PROCEDURE discount_produse (IN id_produs MEDIUMINT)
BEGIN
    DECLARE brand_produs VARCHAR(100);
    DECLARE denumire_produs VARCHAR(200);
    DECLARE pret_produs MEDIUMINT;
    DECLARE denumire_magazin VARCHAR(50);
    
    SELECT produse.brand, produse.denumire, produse.pret_lei, magazine.denumire 
    INTO brand_produs, denumire_produs, pret_produs, denumire_magazin
    FROM magazine JOIN produse ON produse.id_magazin = magazine.id
    WHERE produse.id = id_produs;
    
    IF brand_produs = "Samsung" THEN
        SET pret_produs = pret_produs - (pret_produs * 0.2);
    END IF;
    
    IF brand_produs = " Lexmark" THEN
        SET pret_produs = pret_produs - (pret_produs * 0.3);
	END IF;
    
    IF denumire_magazin = "Altex" THEN
        SET pret_produs = pret_produs - (pret_produs * 0.05);
	END IF;
    
    UPDATE produse SET pret_lei = pret_produs WHERE produse.id = id_produs;
    
END;    
//
DELIMITER ;

CALL discount_produse(1);
CALL discount_produse (19);
CALL discount_produse (33);

DELIMITER //
CREATE PROCEDURE pret_nul_produse_indisponibile (IN id_produs MEDIUMINT)
BEGIN
	DECLARE brandul_produsului VARCHAR(100);
	DECLARE denumirea_produsului VARCHAR(200);
    DECLARE stocul_furnizorului ENUM("Da", "Nu");
    DECLARE pretul_produsului MEDIUMINT;
    DECLARE denumirea_furnizorului VARCHAR(50);
    
    SELECT produse.brand, produse.denumire, produse.stoc_furnizor, produse.pret_lei, furnizori.denumire 
    INTO brandul_produsului, denumirea_produsului, stocul_furnizorului, pretul_produsului, denumirea_furnizorului 
    FROM furnizori JOIN produse ON produse.id_furnizor = furnizori.id
    WHERE produse.id = id_produs;
    
    IF stocul_furnizorului = "Nu" THEN 
		SET pretul_produsului = 0;
	END IF;
    UPDATE produse SET pret_lei = pretul_produsului WHERE produse.id = id_produs;
END;
//
DELIMITER ;

CALL pret_nul_produse_indisponibile(2);
CALL pret_nul_produse_indisponibile(17);
CALL pret_nul_produse_indisponibile(19);


# CURSORI - EXEMPLE

CREATE TABLE IF NOT EXISTS furnizori_usa (
id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
denumire VARCHAR(50),
locatie VARCHAR(100),
tara VARCHAR(50),
telefon CHAR(10)
);


DELIMITER //
CREATE PROCEDURE populare_furnizori_usa()
BEGIN
    DECLARE denum VARCHAR(50);
    DECLARE loc VARCHAR(100);
    DECLARE stat VARCHAR(50);
    DECLARE tel CHAR(10);
    
    DECLARE exista_inregistrari_cursor TINYINT DEFAULT 1;
    
    DECLARE cursor_furnizori CURSOR FOR 
        SELECT denumire, locatie, tara, telefon 
        FROM furnizori
        WHERE tara = "USA";
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exista_inregistrari_cursor = 0;
    OPEN cursor_furnizori;
    TRUNCATE furnizori_usa;
    usa : LOOP
        FETCH cursor_furnizori INTO denum, loc, stat, tel;
        IF exista_inregistrari_cursor = 0 THEN
           LEAVE usa;
		ELSE 
           INSERT INTO furnizori_usa VALUES(NULL, denum, loc, stat, tel);
		END IF;
    END LOOP usa;
    CLOSE cursor_furnizori;
END;
//
DELIMITER ;

CALL populare_furnizori_usa();
SELECT * FROM furnizori_usa;

DELIMITER //
CREATE PROCEDURE 
BEGIN
END;
//
DELIMITER ;

# TRIGGERI - EXEMPLE

CREATE TABLE IF NOT EXISTS angajati_internship (
id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nume VARCHAR(100) NOT NULL,
prenume VARCHAR(100) NOT NULL,
salariu MEDIUMINT,
data_angajarii DATE,
id_magazin TINYINT,
FOREIGN KEY (id_magazin) REFERENCES magazine(id)
);

DELIMITER //
CREATE TRIGGER b_angajati BEFORE INSERT
ON angajati_internship FOR EACH ROW
BEGIN
    SET NEW.nume = UPPER(NEW.nume);
    SET NEW.prenume = UPPER(NEW.prenume);
    IF NEW.salariu < 1200 THEN
         SET NEW.salariu = 1200;
    END IF;
	IF NEW.data_angajarii < CURDATE() THEN
		SET NEW.data_angajarii = CURDATE();
	END IF;
END;
//
DELIMITER ;

INSERT INTO angajati_internship VALUES
(NULL, "Dobrovolski", "Florin", "700", "2022-03-05", "5"),
(NULL, "Stroescu", "Melania", "1500", "2023-04-07", "8"),
(NULL, "Feraru", "Darius", "2500", "2023-05-10", "1"),
(NULL, "Iliescu", "Bianca", "800", "2021-04-02", "3");

SELECT * FROM angajati_internship;

DELIMITER //
CREATE TRIGGER before_angajati_proba2 BEFORE INSERT
ON angajati_internship FOR EACH ROW
BEGIN
	IF NEW.salariu < 3000 THEN
		SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Salariul minim nu poate fi mai mic de 3000";
	END IF;
END;
//
DELIMITER ;

DROP TRIGGER b_angajati;

DROP TRIGGER before_angajati_proba2;

CREATE TABLE IF NOT EXISTS audit_internship(
id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
id_angajati_internship TINYINT NOT NULL,
USER VARCHAR(50) NOT NULL,
data_ora_modificare DATETIME NOT NULL,
detalii MEDIUMTEXT,
FOREIGN KEY (id_angajati_internship) REFERENCES angajati_internship(id)
);

DELIMITER //
CREATE TRIGGER a_angajati_internship AFTER UPDATE
ON angajati_internship FOR EACH ROW
BEGIN
	IF OLD.salariu != NEW.salariu THEN
		INSERT INTO audit_internship
        VALUES(NULL, OLD.id, user(), NOW(), CONCAT("Modificare salariu : ", OLD.salariu, "-->", NEW.salariu));
	END IF;
END;
//
DELIMITER ;

CREATE TABLE IF NOT EXISTS comenzi_log (
id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
id_comenzi MEDIUMINT,
eveniment VARCHAR(100),
detalii TEXT,
FOREIGN KEY(id_comenzi) REFERENCES comenzi(id)
);

DELIMITER //
CREATE TRIGGER au_comenzi AFTER UPDATE
ON comenzi FOR EACH ROW
BEGIN
	DECLARE plata_initiala ENUM("Cash", "Card");
    DECLARE plata_finala ENUM("Cash", "Card");
    IF OLD.tip_plata != NEW.tip_plata THEN
		SELECT tip_plata INTO plata_initiala FROM comenzi WHERE id = OLD.id;
        SELECT tip_plata INTO plata_finala FROM comenzi WHERE id = NEW.id;
		INSERT INTO comenzi_log VALUES(NULL, NEW.id, "tip plata - schimbata ", CONCAT( plata_initiala, "==>", plata_finala));
	END IF;
END;
//
DELIMITER ;

UPDATE comenzi SET tip_plata = "Cash" WHERE id = 3;

SELECT * FROM comenzi;

SELECT * FROM comenzi_log;

