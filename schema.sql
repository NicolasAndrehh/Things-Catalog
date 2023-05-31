CREATE DATABASE catalog;

CREATE TABLE
    music_album (
        id SERIAL PRIMARY KEY,
        title VARCHAR(100) NOT NULL,
        genre_id INTEGER NOT NULL,
        author_id INTEGER NOT NULL,
        label_id INTEGER NOT NULL,
        publish_date DATE NOT NULL,
        archived BOOLEAN NOT NULL,
        FOREIGN KEY (genre_id) REFERENCES genre (id) ON DELETE CASCADE,
    );

CREATE TABLE
    genre (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
    );