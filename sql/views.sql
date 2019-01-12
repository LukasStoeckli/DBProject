-- countryGenre
CREATE VIEW CountryGenre AS (
  SELECT country, genre, COUNT(*) AS cnt
  FROM (
    SELECT origin AS country, bandName
    FROM MetalBand
    WHERE origin != '') AS c, (
    SELECT style AS genre, bandName
    FROM MetalStyle) AS g
  WHERE c.bandName = g.bandName
  GROUP BY country, genre
  ORDER BY country, cnt DESC);


-- countryAttack
CREATE VIEW CountryAttack AS (
  SELECT country, attackType, COUNT(*) AS cnt
  FROM (
    SELECT country, LID
    FROM TerrorLocation) AS l, (
    SELECT EID, LID
    FROM TerrorEvent) AS e, (
    SELECT attackType, EID
    FROM TerrorAttack) AS a
  WHERE l.LID = e.LID AND e.EID = a.EID
  GROUP BY country, attackType
  ORDER BY country, cnt DESC);


-- countryTarget
CREATE VIEW CountryTarget AS (
  SELECT country, targSubtype, COUNT(*) AS cnt
  FROM (
    SELECT country, LID
    FROM TerrorLocation) AS l, (
    SELECT EID, LID
    FROM TerrorEvent) AS e, (
    SELECT targSubtype, EID
    FROM TerrorTarget) AS a
  WHERE l.LID = e.LID AND e.EID = a.EID
  GROUP BY country, targSubtype
  ORDER BY country, cnt DESC);


-- countryWeapon
CREATE VIEW CountryWeapon AS (SELECT country, weapSubtype, COUNT(*) AS cnt
FROM
  (SELECT country, LID FROM TerrorLocation) AS l,
  (SELECT EID, LID FROM TerrorEvent) AS e,
  (SELECT weapSubtype, EID FROM TerrorWeapon) AS a
WHERE l.LID = e.LID AND e.EID = a.EID
GROUP BY country, weapSubtype
ORDER BY country, cnt DESC)


-- top ten targetSubtypes
CREATE VIEW top10TargetSubtypes AS (
  SELECT targSubtype, COUNT(targsSubtype) AS cnt
  FROM TerrorTarget
  GROUP BY targetSubtype
  ORDER BY cnt DESC LIMIT 10);


-- top 30 countries with most metalbands (more than 15 bands per country)
CREATE VIEW top30MetalCountries AS (
  SELECT origin AS country, COUNT(origin) AS cnt
  FROM MetalBand
  WHERE origin IN (
    SELECT country as origin
    FROM TerrorLocation
    GROUP BY country)
  GROUP BY origin
  ORDER BY cnt DESC LIMIT 30);


-- top10CountryGenres
CREATE VIEW top30CountryGenres AS (
  SELECT country, genre, COUNT(*) AS cnt
  FROM (
    SELECT origin AS country, bandName
    FROM MetalBand
    WHERE origin IN (
      SELECT country AS origin
      FROM top30MetalCountries)) AS c, (
    SELECT style AS genre, bandName FROM MetalStyle) AS g
  WHERE c.bandName = g.bandName
  GROUP BY country, genre
  ORDER BY country, cnt DESC);




-- also we forgot to add quotes in a csv, so
UPDATE TerrorWeapon SET weapSubtype = 'Projectile (rockets, mortars, RPGs, etc.)' WHERE weapSubtype = 'Projectile (rockets'
