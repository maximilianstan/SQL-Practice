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
id MEDIUMINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
data_comanda DATE,
tip_plata ENUM("Cash", "Card"),
id_client TINYINT,
FOREIGN KEY (id_client) REFERENCES clienti(id)
);

DESCRIBE comenzi;

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
SELECT * FROM angajati ORDER BY stare_civila;
SELECT * FROM angajati ORDER BY salariu;
SELECT * FROM angajati WHERE salariu < "7000";
SELECT * FROM angajati WHERE data_angajarii > "2014-03-02";
SELECT nume FROM angajati WHERE salariu >= "5000";

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

ALTER TABLE furnizori ADD tara VARCHAR(50);

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
SELECT COUNT(id) FROM produse;
SELECT COUNT(nume) FROM angajati;
SELECT COUNT(locatie) FROM magazine;
SELECT COUNT(tara) FROM furnizori WHERE tara = "USA";
SELECT COUNT(prenume) FROM angajati WHERE prenume = "Alexandru";
SELECT COUNT(id) FROM angajati WHERE salariu <= "8000";
SELECT COUNT(id) FROM angajati WHERE stare_civila = "Necasatorit";

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

