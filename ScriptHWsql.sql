
CREATE TABLE IF NOT EXISTS Collection (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    year_of_issue DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Album (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL unique,
    date_producrion DATE NOT NULL
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