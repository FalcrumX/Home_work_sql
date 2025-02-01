
  
-- Название и продолжительность самого длительного трека.  
SELECT name, duration
FROM track
WHERE duration = (SELECT MAX(duration) FROM track);

-- Название треков, продолжительность которых не менее 3,5 минут.
SELECT name, duration
FROM track
WHERE duration >= 210
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
WHERE name ILIKE '% мой %'
   OR name ILIKE 'мой %'
   OR name ILIKE '% мой'
   OR name ILIKE 'мой'
   OR name ILIKE '% my %'
   OR name ILIKE 'my %'
   OR name ILIKE '% my'
   OR name ILIKE 'my'
ORDER BY name;

--Название треков, которые содержат слово «мой» или «my» вариант №2
SELECT name
FROM track
WHERE string_to_array(lower(name), ' ') && ARRAY['мой', 'my']
ORDER BY name;

  
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


-- Названия альбомов, в которых присутствуют исполнители более чем одного жанра.
SELECT DISTINCT a.name
FROM album a
JOIN albumperformer ap ON a.id = ap.album_id
JOIN performer p ON ap.performer_id = p.id
JOIN performergenre pg ON p.id = pg.performer_id
GROUP BY a.id, a.name, ap.performer_id
HAVING COUNT(DISTINCT pg.genre_id) > 1
ORDER BY a.name;

-- Наименования треков, которые не входят в сборники.
SELECT t.name AS track_name
FROM track t
LEFT JOIN trackcollection tc ON t.id = tc.track_id
WHERE tc.collection_id IS NULL
ORDER BY t.name;

-- Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько.
SELECT DISTINCT p.name AS performer_name
FROM performer p
JOIN albumperformer ap ON p.id = ap.performer_id
JOIN album a ON ap.album_id = a.id
JOIN track t ON a.id = t.album_id
WHERE t.duration = (
    SELECT MIN(duration)
    FROM track
)
ORDER BY p.name;


-- Названия альбомов, содержащих наименьшее количество треков.
SELECT a.name AS album_name, COUNT(t.id) AS track_count
FROM album a
LEFT JOIN track t ON a.id = t.album_id
GROUP BY a.id, a.name
HAVING COUNT(t.id) = (
    SELECT COUNT(t2.id)
    FROM album a2
    LEFT JOIN track t2 ON a2.id = t2.album_id
    GROUP BY a2.id
    ORDER BY COUNT(t2.id) ASC
    LIMIT 1
)
ORDER BY a.name;