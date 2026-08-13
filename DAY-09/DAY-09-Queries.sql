-- Database my_movies

SELECT * FROM movies;

SELECT COUNT(*) AS Total_movie_count FROM movies;

SELECT COUNT(*) AS Total_movie_count FROM movies
WHERE industry = "Hollywood";

SELECT * FROM financials;



-- Problem query

	SELECT * FROM (
		SELECT m.*, f.revenue, f.budget,
			   (f.revenue - f.budget) / f.budget * 100 AS profit_pct
		FROM movies m
		JOIN financials f ON m.movie_id = f.movie_id
		WHERE m.industry = 'Hollywood'
	) x
	WHERE x.profit_pct > 100
	  AND x.imdb_rating < (
			SELECT AVG(imdb_rating) 
			FROM movies 
			WHERE industry = 'Hollywood'
		  );


-- How do you rewrite this so it reads top to bottom, like plain steps?

-- Fix Query CTE

WITH movie_profit_pct AS (
    SELECT movie_id, 
           ROUND((revenue - budget) / budget * 100, 2) AS profit_pct
    FROM financials
    WHERE currency = 'USD' AND unit = 'Millions'
),

avg_rating AS (
    SELECT AVG(imdb_rating) AS avg_rating 
    FROM movies
    WHERE industry = 'Hollywood'
)


SELECT m.movie_id, m.title, mpp.profit_pct
FROM movies m
JOIN movie_profit_pct mpp ON mpp.movie_id = m.movie_id
CROSS JOIN avg_rating a
WHERE mpp.profit_pct > 100
  AND m.imdb_rating < a.avg_rating;
  
SELECT * FROM avg_rating;

13:27:48	SELECT m.movie_id, m.title, mpp.profit_pct FROM movies m JOIN movie_profit_pct mpp ON mpp.movie_id = m.movie_id CROSS JOIN avg_rating a WHERE mpp.profit_pct > 100   AND m.imdb_rating < a.avg_rating LIMIT 0, 50000	Error Code: 1146. Table 'my_movies.movie_profit_pct' doesn't exist	0.000 sec



13:27:19	SELECT * FROM avg_rating LIMIT 0, 50000	Error Code: 1146. Table 'my_movies.avg_rating' doesn't exist	0.000 sec

-- Bonus Question 
-- After the query ends with a semicolon,
-- can you reuse that named block in your next query?

