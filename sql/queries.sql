-- WEATHER VS TERRORISM




-- ATTACKS VS POPULATION
-- countries with population and attack data
SELECT country
FROM TerrorEvent
WHERE country IN (
  SELECT country AS origin
  FROM Population)
GROUP BY country;
-- countrys attack dacka
SELECT year(eventDate) AS year, COUNT(year(eventDate)) AS cnt
FROM TerrorEvent
WHERE LID IN (
  SELECT LID
  FROM TerrorLocation
  WHERE country = '%s')
GROUP BY year(eventDate)
ORDER BY year;
-- countrys population data
SELECT year, population
FROM Population
WHERE country = '%s';



-- GENRE VS TERRORISM
SELECT t.genre, FLOOR(SUM(la.attacks)/COUNT(*)) AS attacks
FROM ((
  SELECT country, MAX(cnt) AS MaxVal
  FROM top30CountryGenres
  GROUP BY country) AS g
  JOIN top30CountryGenres AS t
  ON g.country = t.country AND g.MaxVal = t.cnt
  JOIN (
    SELECT COUNT(l.country) AS attacks, l.country
    FROM TerrorEvent AS t, TerrorLocation AS l
    WHERE l.country IN (
      SELECT country
      FROM top30MetalCountries
      GROUP BY country)
    AND t.LID = l.LID
    GROUP BY l.country
    ORDER BY country) AS la
  ON g.country = la.country)
GROUP BY t.genre
ORDER BY attacks DESC;



-- POPULATION VS BANDS
-- countries with population and metal data
SELECT origin
FROM MetalBand
WHERE origin IN (
  SELECT country AS origin
  FROM Population)
GROUP BY origin;
-- countrys population data
SELECT year, population
FROM Population
WHERE country = '%s';
-- countrys formed bands data
SELECT formed AS year, COUNT(formed) AS cnt
FROM MetalBand
WHERE formed != 0 AND origin = '%s'
GROUP BY formed
ORDER BY formed;
-- countrys split bands data
SELECT split AS year, COUNT(split) AS cnt
FROM MetalBand
WHERE origin = '%s'
GROUP BY split
ORDER BY split;



-- ATTACKS VS BANDS
-- attack data
SELECT year(eventDate) AS year, COUNT(year(eventDate)) AS cnt
FROM TerrorEvent
GROUP BY year(eventDate)
ORDER BY year;
-- formed bands data
SELECT formed AS year, COUNT(formed) AS cnt
FROM MetalBand
WHERE formed != 0
GROUP BY formed
ORDER BY formed;
-- split bands data
SELECT split AS year, COUNT(split) AS cnt
FROM MetalBand
WHERE split != 0
GROUP BY split
ORDER BY split;



-- GLOBAL TERRORISM MAP
-- yearly distinct locations
SELECT DISTINCT latitude, longitude
FROM TerrorLocation
WHERE (latitude != 0 OR longitude !=0) AND LID IN (
  SELECT LID
  FROM TerrorEvent
  WHERE YEAR(eventDate) = %s);
-- data for distinct location
SELECT COUNT(te.EID) as cnt, t.country, t.city, SUM(te.nkill), SUM(te.nwound)
FROM TerrorEvent te, (
  SELECT LID, country, city
  FROM TerrorLocation
  WHERE latitude LIKE '%s' AND longitude LIKE '%s') t
WHERE te.LID = t.LID;
