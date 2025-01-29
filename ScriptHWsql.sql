
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
    collection_id INTEGER REFERENCES Collection(id)
);


CREATE TABLE IF NOT EXISTS AlbumPerformer (
    album_id INTEGER REFERENCES Album(id),
    performer_id INTEGER REFERENCES Performer(id)
);

CREATE TABLE IF NOT EXISTS PerformerGenre (
    genre_id INTEGER REFERENCES Genre(id),
    performer_id INTEGER REFERENCES Performer(id)
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
  (1, 1), -- Russian Lullaby в Eurodance
  (2, 2), -- We Will Rock You в Rock Collection
  (3, 1), -- Angels Crying в Eurodance
  (3, 3), -- Angels Crying в Hit 90
  (5, 1), -- Eins, Zwei, Polizei в Eurodance
  (5, 3), -- Eins, Zwei, Polizei в Hit 90
  (7, 2), -- Brother Louie в Rock Collection
  (7, 4); -- Brother Louie в Rock Legend
