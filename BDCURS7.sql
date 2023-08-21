CREATE DATABASE IF NOT EXISTS bd_curs7;
CREATE TABLE departamente(
id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
denumire VARCHAR(50) NOT NULL
);
SELECT * FROM departamente;
CREATE TABLE posturi(
id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
denumire VARCHAR (50)NOT NULL
);

DESCRIBE posturi;

CREATE TABLE angajati (
    id SMALLINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nume VARCHAR(50) NOT NULL,
    prenume VARCHAR(50) NOT NULL,
    data_angajare DATE NOT NULL,
    data_demisie DATE,
    salariu DECIMAL(10, 2) NOT NULL,
    id_departament TINYINT,
    id_posturi TINYINT,
    FOREIGN KEY (id_departament) REFERENCES departamente(id),
    FOREIGN KEY (id_posturi) REFERENCES posturi(id)
);
INSERT INTO departamente (denumire) VALUES
    ('Dezvoltare Software'),
    ('Testare și QA'),
    ('Infrastructură IT'),
    ('Securitate Cibernetică'),
    ('Analiză de Date');
INSERT INTO posturi (denumire) VALUES
    ('Programator'),
    ('Inginer de Testare'),
    ('Administrator Sistem'),
    ('Analyst de Securitate'),
    ('Analyst de Date');  
INSERT INTO angajati (id, nume, prenume, data_angajare, salariu, id_departament, id_posturi) VALUES
    (1, 'Popescu', 'Ion', 20200315, 5500.00, 1, 1),
    (2, 'Ionescu', 'Maria', 20190710, 4900.00, 1, 1),
    (3, 'Stan', 'Ana', 20220520, 3600.00, 2, 2),
    (4, 'Dumitru', 'Alex', 20230201, 3200.00, 2, 3),
    (5, 'Constantin', 'Andrei', 20210908, 3000.00, 3, 3),
    (6, 'Munteanu', 'Elena', 20221114, 4200.00, 4, 4),
    (7, 'Gheorghescu', 'Cristina', 20200630, 2800.00, 5, 5),
    (8, 'Radu', 'Mihai', 20190425, 2400.00, 5, 5),
    (9, 'Popa', 'Andreea', 20230112, 6000.00, 1, 1),
    (10, 'Georgescu', 'Victor', 2022-08-05, 4800.00, 1, 2); 
    
    SELECT * FROM angajati;
    SELECT denumire FROM departamente WHERE id = (SELECT id_departament FROM angajati WHERE nume = 'Popescu' AND prenume = 'Ion' );
    
    SELECT data_angajare FROM angajati WHERE nume = "Stan" AND prenume = "Ana";
    SELECT * FROM angajati WHERE data_angajare < "2022-05-20";
	SELECT * FROM angajati WHERE salariu > (SELECT AVG(salariu) FROM angajati);
    SELECT * FROM angajati WHERE salariu < (SELECT MAX(salariu) FROM angajati);
    SELECT * FROM Angajati WHERE salariu < ( SELECT MAX(salariu) FROM Angajati ) LIMIT 1;
    SELECT * FROM angajati ORDER BY salariu DESC LIMIT 1, 1;
    SELECT COUNT(id), id_departament FROM angajati GROUP BY id_departament HAVING COUNT(id) > 1;
    SELECT id FROM departamente WHERE denumire = "Analiza de date";
    SELECT salariu FROM angajati WHERE id_departament = (SELECT id FROM departamente WHERE denumire = "Analiza de date");
    SELECT DISTINCT(salariu) FROM angajati, departamente WHERE angajati.id_departament = departamente.id
    AND departamente.denumire = "Analiza de date";
    # returneaza numele si prenumele tuturor angajatilor care castiga mai mult decat salariul mediu al tuturor angajatilor
    SELECT nume, prenume FROM angajati WHERE salariu > (SELECT AVG(salariu) FROM angajati);
    
SELECT COUNT(*) Numar_Angajati, denumire FROM Angajati JOIN Departamente 
ON Angajati.id_departament = Departamente.id
GROUP BY denumire
HAVING Numar_Angajati IN ( SELECT COUNT(*) FROM Angajati JOIN Departamente ON Angajati.id_departament = Departamente.id GROUP BY Angajati.id_departament HAVING COUNT(*) < 3);


 

