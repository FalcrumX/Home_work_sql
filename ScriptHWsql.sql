
CREATE TABLE IF NOT EXISTS Collection (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    year_of_issue DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Album (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL unique,
    date_production DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Track (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    album_id INTEGER NOT NULL REFERENCES Album(id),
    duration INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS Performer (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL unique
);

CREATE TABLE IF NOT EXISTS Genre (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL unique
);


CREATE TABLE IF NOT EXISTS TrackCollection (
    track_id INTEGER REFERENCES Track(id),
    collection_id INTEGER REFERENCES Collection(id),
    PRIMARY KEY (track_id, collection_id)
);


CREATE TABLE IF NOT EXISTS AlbumPerformer (
    album_id INTEGER REFERENCES Album(id),
    performer_id INTEGER REFERENCES Performer(id),
    PRIMARY KEY (album_id, performer_id)
);

CREATE TABLE IF NOT EXISTS PerformerGenre (
    genre_id INTEGER REFERENCES Genre(id),
    performer_id INTEGER REFERENCES Performer(id),
    PRIMARY KEY (genre_id, performer_id)
);


-- вносим данные в таблицу genre 
INSERT INTO genre(name)
VALUES 
  ('pop'), 
  ('rock'), 
  ('rap');


INSERT INTO Performer (name)
VALUES 
  ('E-Type'),
  ('Queen'),
  ('Will Smith'),
  ('Mo-do'),
  ('Modern Talking');

INSERT INTO album (name, date_production)
VALUES 
  ('Made in Sweeden', '1994-01-15'),
  ('News Of The World', '1977-02-04'),
  ('Last Man Standing', '1988-05-21'),
  ('Willenium', '1999-08-11'),
  ('Eins, Zwei, Polizei', '1994-04-29'),
  ('Was ist Das?', '1995-04-05'),
  ('Ready for Romance', '1986-11-27');
  
INSERT INTO track (name, album_id , duration)
VALUES 
  ('Russian Lullaby', (SELECT id FROM album WHERE name = 'Made in Sweeden'), 194),
  ('We Will Rock You', (SELECT id FROM album WHERE name = 'News Of The World'), 120),
  ('Angels Crying', (SELECT id FROM album WHERE name = 'Last Man Standing'), 230),
  ('I`m comin', (SELECT id FROM album WHERE name = 'Willenium'), 234),
  ('Eins, Zwei, Polizei', (SELECT id FROM album WHERE name = 'Was ist Das?'), 312),
  ('Here i Go Again', (SELECT id FROM album WHERE name = 'Last Man Standing'), 234),
  ('Brother Louie', (SELECT id FROM album WHERE name = 'Ready for Romance'), 221);

INSERT INTO collection (name, year_of_issue)
VALUES 
  ('Eurodance 90', '2001-01-23'),
  ('Rock collection', '1996-04-04'),
  ('Hit 90', '1999-06-02'),
  ('Rock Legend', '1998-11-08');

INSERT INTO PerformerGenre (performer_id, genre_id)
VALUES 
  (1, 1), -- E-type - pop
  (2, 2), -- Queen - rock
  (3, 3), -- Will Smith  - rap
  (4, 1), -- Mo-Do -  pop
  (5, 1), -- Modern Talking -  pop
  (5, 2); -- Modern Talking -  rock
  
INSERT INTO AlbumPerformer (album_id, performer_id)
VALUES 
  (1, 1), -- Made in Sweeden - E-type
  (2, 2), -- News Of The World - Queen
  (3, 1), -- Last Man Standing - Will Smith
  (4, 3), -- Willenium - Will Smith
  (5, 4), -- Eins, Zwei, Polizei - Mo-Do
  (6, 4), -- Was ist Das? - Mo-Do
  (7, 5); -- Ready for Romance - Modern Talking 
  
INSERT INTO TrackCollection (track_id, collection_id)
VALUES 
  (2, 1), -- Russian Lullaby в Eurodance
  (3, 2), -- We Will Rock You в Rock Collection
  (4, 1), -- Angels Crying в Eurodance
  (4, 3), -- Angels Crying в Hit 90
  (6, 1), -- Eins, Zwei, Polizei в Eurodance
  (6, 3), -- Eins, Zwei, Polizei в Hit 90
  (8, 2), -- Brother Louie в Rock Collection
  (8, 4); -- Brother Louie в Rock Legend
  
INSERT INTO collection (name, year_of_issue)
VALUES 
  ('Great Hits 90', '2018-12-31'),
  ('Great Hits Rock collection', '2019-01-15');

INSERT INTO Performer (name)
VALUES 
  ('My & My');

INSERT INTO album (name, date_production)
VALUES 
  ('I`m on My Way', '1996-02-16');
  
INSERT INTO track (name, album_id , duration)
VALUES 
  ('I`m On My Way', (SELECT id FROM album WHERE name = 'I`m on My Way'), 244);
  

INSERT INTO PerformerGenre (performer_id, genre_id)
VALUES 
  (6, 1); -- My & My - pop
 
  
INSERT INTO AlbumPerformer (album_id, performer_id)
VALUES 
  (8, 6); -- I`m On My Way - My & My
  
  
INSERT INTO TrackCollection (track_id, collection_id)
VALUES 
  (2, 5), -- Russian Lullaby в Great Hits 90
  (4, 5), -- Angels Crying в Great Hits 90
  (6, 5), -- Eins, Zwei, Polizei в Great Hits 90
  (9, 5), -- I`m On My Way в Great Hits 90
  (3, 6), -- We Will Rock You в Great Hits Rock Collection
  (8, 6); -- Brother Louie в Eurodance
  
--№2 Задание  
  
-- Название и продолжительность самого длительного трека.  
SELECT name, duration
FROM track
WHERE duration = (SELECT MAX(duration) FROM track);

-- Название треков, продолжительность которых не менее 3,5 минут.
SELECT name, duration
FROM track
WHERE duration >= 240
ORDER BY duration DESC;

-- Названия сборников, вышедших в период с 2018 по 2020 год включительно.
SELECT name
FROM collection
WHERE EXTRACT(YEAR FROM year_of_issue) BETWEEN 2018 AND 2020
ORDER BY year_of_issue;

-- Исполнители, чьё имя состоит из одного слова.
SELECT name
FROM performer
WHERE name NOT LIKE '% %'
ORDER BY name;


-- Исполнители, чьё имя состоит из одного слова и без тире
SELECT name
FROM performer
WHERE name NOT LIKE '% %'
  AND name NOT LIKE '%-%'
ORDER BY name;

-- Название треков, которые содержат слово «мой» или «my»
SELECT name
FROM track
WHERE LOWER(name) LIKE '%мой%'
   OR LOWER(name) LIKE '%my%'
ORDER BY name;


-- №3 Задание Подготовка. Наполнение недостающей информации
INSERT INTO Performer (name)
VALUES 
  ('Bad Bunny');

INSERT INTO album (name, date_production)
VALUES 
  ('YHLQMDLG', '2020-03-15');
  
INSERT INTO track (name, album_id, duration)
VALUES 
  ('Vete', (SELECT id FROM album WHERE name = 'YHLQMDLG'), 192); --
  
--DELETE FROM track
--WHERE name = 'Vete' AND album_id = 1 AND duration = 192;

INSERT INTO PerformerGenre (performer_id, genre_id)
VALUES 
  (7, 3); -- Bad Bunny - rap
 
  
INSERT INTO AlbumPerformer (album_id, performer_id)
VALUES 
   (9, 7); -- YHLQMDLG - Bad Bunny
  
-- №3 Задание
  
-- Количество исполнителей в каждом жанре.
  SELECT g.name AS genre_name, COUNT(DISTINCT pg.performer_id) AS performer_count
FROM genre g
LEFT JOIN performergenre pg ON g.id = pg.genre_id
GROUP BY g.id, g.name
ORDER BY performer_count DESC, genre_name;

--Количество треков, вошедших в альбомы 2019–2020 годов.
SELECT COUNT(t.id) AS track_count
FROM track t
JOIN album a ON t.album_id = a.id
WHERE EXTRACT(YEAR FROM a.date_production) BETWEEN 2019 AND 2020;

--Средняя продолжительность треков по каждому альбому.
SELECT a.name AS album_name, 
       AVG(t.duration) AS average_duration
FROM album a
JOIN track t ON a.id = t.album_id
GROUP BY a.id, a.name
ORDER BY average_duration DESC;

-- Все исполнители, которые не выпустили альбомы в 2020 году.
SELECT DISTINCT p.name
FROM Performer p
WHERE p.id NOT IN (
    SELECT DISTINCT ap.performer_id
    FROM AlbumPerformer ap
    JOIN Album a ON ap.album_id = a.id
    WHERE EXTRACT(YEAR FROM a.date_production) = 2020
)

-- Названия сборников, в которых присутствует конкретный исполнитель E-type

SELECT DISTINCT c.name AS collection_name, 
       EXTRACT(YEAR FROM c.year_of_issue) AS release_year
FROM collection c
JOIN trackcollection tc ON c.id = tc.collection_id
JOIN track t ON tc.track_id = t.id
JOIN albumperformer ap ON t.album_id = ap.album_id
JOIN performer p ON ap.performer_id = p.id
WHERE LOWER(p.name) = LOWER('E-Type')
ORDER BY release_year, c.name;

ORDER BY p.name;









  


