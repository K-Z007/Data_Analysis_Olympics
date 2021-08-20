SET search_path = 'dbcamp_tableau';

SELECT event, 
	   CASE 
	    WHEN event LIKE '%Women%' THEN 'female'
		ELSE 'male' END AS gender,
	   COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games
WHERE country_id IN (
	SELECT country_id 
	FROM country_stats 
	WHERE nobel_prize_winners > 0)
GROUP BY event, gender
UNION ALL
SELECT event, 
	   CASE 
	    WHEN event LIKE '%Women%' THEN 'female'
		ELSE 'male' END AS gender,
	   COUNT(DISTINCT athlete_id) AS athletes
FROM winter_games
WHERE country_id IN (
	SELECT country_id 
	FROM country_stats 
	WHERE nobel_prize_winners > 0)
GROUP BY event, gender
ORDER BY athletes DESC
LIMIT 10
