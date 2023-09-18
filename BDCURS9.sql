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