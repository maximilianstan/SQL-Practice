CREATE DATABASE IF NOT EXISTS bdcurs5;
USE bdcurs5;
CREATE TABLE IF NOT EXISTS filme (
	Id TINYINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	Titlu Varchar(50) UNIQUE NOT NULL,
  regizor VARCHAR(100) NOT NULL,
	Protagonist VARCHAR(50) NOT NULL,
	Data_Aparitie DATE NOT NULL,
	Gen ENUM('Drama' , 'Comedie' , 'Romantic' , 'SF', 'Thriller', 'Actiune') NOT NULL,
	Rating FLOAT NOT NULL,
	Durata TIME NOT NULL,
	Oscar ENUM ('Da' , 'Nu') NOT NULL
);

DESCRIBE filme;


INSERT INTO filme (Titlu, Regizor, Protagonist, Data_Aparitie, Gen, Rating, Durata, Oscar) VALUES
('Inception', 'Christopher Nolan', 'Leonardo DiCaprio', '2010-07-16', 'SF', 4.7, '02:28:00', 'Da'),
('The Godfather', 'Francis Ford Coppola', 'Marlon Brando', '1972-03-24', 'Drama', 4.9, '02:55:00', 'Da'),
('The Dark Knight', 'Christopher Nolan', 'Christian Bale', '2008-07-18', 'Actiune', 4.8, '02:32:00', 'Nu'),
('Forrest Gump', 'Robert Zemeckis', 'Tom Hanks', '1994-07-06', 'Comedie', 4.6, '02:22:00', 'Da'),
('Pulp Fiction', 'Quentin Tarantino', 'John Travolta', '1994-10-14', 'Drama', 4.9, '02:34:00', 'Da'),
('Interstellar', 'Christopher Nolan', 'Matthew McConaughey', '2014-11-05', 'SF', 4.7, '02:49:00', 'Nu'),
('The Shawshank Redemption', 'Frank Darabont', 'Tim Robbins', '1994-09-23', 'Drama', 4.9, '02:22:00', 'Da'),
('The Matrix', 'Lana Wachowski, Lilly Wachowski', 'Keanu Reeves', '1999-03-31', 'SF', 4.6, '02:16:00', 'Da'),
('Gladiator', 'Ridley Scott', 'Russell Crowe', '2000-05-01', 'Actiune', 4.5, '02:35:00', 'Da'),
('The Silence of the Lambs', 'Jonathan Demme', 'Jodie Foster', '1991-02-14', 'Thriller', 4.8, '01:58:00', 'Da');

SELECT * FROM filme;

SELECT * FROM filme WHERE rating > '4.5';
SELECT * FROM filme WHERE YEAR(data_aparitie) > 2000 AND rating > 4.5;
SELECT * FROM filme WHERE rating BETWEEN 4.3 AND 4.7;

SELECT * FROM filme ORDER BY rating DESC LIMIT 1;
SELECT * FROM filme ORDER BY data_aparitie ASC;
SELECT * FROM filme ORDER BY Durata DESC;
SELECT * FROM filme WHERE gen IN('Drama','SF') AND Oscar = 'Da' ;
SELECT count(id) AS nr_filme, oscar FROM filme GROUP BY oscar;
SELECT count(gen), gen FROM filme GROUP BY gen;
SELECT COUNT(data_aparitie), data_aparitie FROM filme GROUP BY data_aparitie;
SELECT MAX(Rating) Rating_Maxim, Gen FROM filme GROUP BY Gen;
SELECT COUNT(*) AS nr_filme, gen FROM filme GROUP BY gen HAVING nr_filme>=2;
SELECT AVG(rating), gen FROM filme GROUP BY gen;
SELECT AVG(rating), gen FROM filme GROUP BY gen HAVING AVG(rating) > 4.3;

SELECT COUNT(*) AS nr_filme, gen FROM filme WHERE YEAR (data_aparitie) >= 2000 GROUP BY gen HAVING nr_filme >=2;
SELECT AVG(Rating) Rating_Mediu, Gen FROM filme WHERE Oscar = 'Da' GROUP BY Gen HAVING Rating_mediu > 4.5;
SELECT GROUP_CONCAT(titlu ORDER BY titlu DESC SEPARATOR '-'), oscar FROM filme GROUP BY oscar;

#gruparea tuturor regizorilor pentru fiecare gen de film;
SELECT GROUP_CONCAT(regizor SEPARATOR '/') regizori, gen FROM filme GROUP BY gen;
SELECT titlu, rating, IF(rating > 4.7, 'film bun', 'film slab') AS recomandare FROM filme;
SELECT titlu, oscar, IF(Oscar = 'Da', 'film premiat', 'film fara premii') AS premiat FROM filme;
SELECT titlu, data_aparitie, IF(YEAR(data_aparitie) < 2000, 'Film Vechi', 'Film Recent') FROM filme;
SELECT regizor FROM filme;

DESCRIBE cursuri;
