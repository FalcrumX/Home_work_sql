
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
  ('Modern Talking'),
  ('My & My'),
  ('Bad Bunny'),
  ('Bazzi');

INSERT INTO album (name, date_production)
VALUES 
  ('Made in Sweeden', '1994-01-15'),
  ('Last Man Standing', '1988-05-21'),
  ('News Of The World', '1977-02-04'),
  ('Willenium', '1999-08-11'),
  ('Eins, Zwei, Polizei', '1994-04-29'),
  ('Was ist Das?', '1995-04-05'),
  ('Ready for Romance', '1986-11-27'),
  ('I`m on My Way', '1996-02-16'),
  ('YHLQMDLG', '2020-03-15'),
  ('COSMIC', '2018-04-11'); 
  -- для проверки запросов SELECT с применением оператора LIKE
  --('own my', '2000-01-31'),
  --('my', '2000-01-31'),
  --('oh my god', '2000-01-31'),
  --('myself', '2111-11-11'),
  --('by myself', '2111-11-11'),
  --('bemy self', '2111-11-11'),
  --('myself by', '2111-11-11'),
  --('by myself by', '2111-11-11'),
  --('beemy', '2111-11-11'),
  --('premyne', '2111-11-11');

INSERT INTO track (name, album_id , duration)
VALUES 
  ('Russian Lullaby', (SELECT id FROM album WHERE name = 'Made in Sweeden'), 194),
  ('Angels Crying', (SELECT id FROM album WHERE name = 'Last Man Standing'), 230),
  ('Here i Go Again', (SELECT id FROM album WHERE name = 'Last Man Standing'), 234),
  ('We Will Rock You', (SELECT id FROM album WHERE name = 'News Of The World'), 120),
  ('I`m comin', (SELECT id FROM album WHERE name = 'Willenium'), 234),
  ('Eins, Zwei, Polizei', (SELECT id FROM album WHERE name = 'Eins, Zwei, Polizei'), 312),
  ('Eins, Zwei, Polizei', (SELECT id FROM album WHERE name = 'Was ist Das?'), 312),
  ('Brother Louie', (SELECT id FROM album WHERE name = 'Ready for Romance'), 221),
  ('I`m On My Way', (SELECT id FROM album WHERE name = 'I`m on My Way'), 244),
  ('Vete', (SELECT id FROM album WHERE name = 'YHLQMDLG'), 192),
  ('Myself', (SELECT id FROM album WHERE name = 'COSMIC'), 168);
  -- для проверки запросов SELECT с применением оператора LIKE
  --('my own', (SELECT id FROM album WHERE name = 'my own'), 201),
  --('own my', (SELECT id FROM album WHERE name = 'own my'), 180),
  --('my', (SELECT id FROM album WHERE name = 'my'), 320),
  --('oh my god', (SELECT id FROM album WHERE name = 'oh my god'), 254),
  --('myself', (SELECT id FROM album WHERE name = 'myself'), 384),
  --('by myself', (SELECT id FROM album WHERE name = 'by myself'), 410),
  --('bemy self', (SELECT id FROM album WHERE name = 'bemy self'), 170),
  --('myself by', (SELECT id FROM album WHERE name = 'myself by'), 192),
  --('by myself by', (SELECT id FROM album WHERE name = 'by myself by'), 315),
  --('beemy', (SELECT id FROM album WHERE name = 'beemy'), 211),
  --('premyne', (SELECT id FROM album WHERE name = 'premyne'), 183);

INSERT INTO collection (name, year_of_issue)
VALUES 
  ('Eurodance 90', '2001-01-23'),
  ('Rock collection', '1996-04-04'),
  ('Hit 90', '1999-06-02'),
  ('Rock Legend', '1998-11-08'),
  ('Great Hits 90', '2018-12-31'),
  ('Great Hits Rock collection', '2019-01-15');

INSERT INTO PerformerGenre (performer_id, genre_id)
VALUES 
  (1, 1), -- E-type - pop
  (2, 2), -- Queen - rock
  (3, 3), -- Will Smith  - rap
  (4, 1), -- Mo-Do -  pop
  (5, 1), -- Modern Talking -  pop
  (5, 2), -- Modern Talking -  rock
  (6, 1), -- My & My - pop
  (7, 3), -- Bad Bunny - rap
  (8, 1); -- Bazzi - pop
  
INSERT INTO AlbumPerformer (album_id, performer_id)
VALUES 
  (1, 1), -- Made in Sweeden - E-type
  (2, 1), -- Last Man Standing - E-type
  (3, 2), -- News Of The World - Queen 
  (4, 3), -- Willenium - Will Smith
  (5, 4), -- Eins, Zwei, Polizei - Mo-Do
  (6, 4), -- Was ist Das? - Mo-Do
  (7, 5), -- Ready for Romance - Modern Talking 
  (8, 6), -- I`m On My Way - My & My
  (9, 7), -- YHLQMDLG - Bad Bunny
  (10, 8); -- COSMIC - Bazzi
  
INSERT INTO TrackCollection (track_id, collection_id)
VALUES 
  (1, 1), -- Russian Lullaby в Eurodance 90
  (1, 3), -- Russian Lullaby в Hit 90
  (1, 5), -- Russian Lullaby в Great Hits 90
  (4, 2), -- We Will Rock You в Rock Collection 
  (4, 4), -- We Will Rock You в Rock Legend
  (4, 6), -- We Will Rock You в Great Hits Rock
  (6, 1), -- Was ist Das? в Eurodance 90
  (6, 3), -- Was ist Das? в Hit 90
  (6, 5), -- Was ist Das? в Great Hits 90
  (7, 2), -- Brother Louie в Rock Collection
  (7, 4), -- Brother Louie в Rock Legend
  (7, 6); -- Brother Louie в Great Hits Rock
  
  
  

   
  
