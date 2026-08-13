SELECT * FROM movies;

SELECT COUNT(*) FROM movies;

SELECT * FROM movies WHERE imdb_rating = NULL;

SELECT COUNT(*) FROM movies WHERE imdb_rating = NULL;

-- =

SELECT COUNT(*) FROM movies WHERE imdb_rating = NULL;

SELECT COUNT(*) FROM movies WHERE imdb_rating != 10.0;

-- is not equal 10, but display 9,8,7,6,5,4,3,2,


SELECT COUNT(*) FROM movies WHERE imdb_rating IS NULL;

SELECT * FROM movies WHERE imdb_rating IS NULL;