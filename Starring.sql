DROP TABLE recommendationsBasedOnStarringField;
ALTER TABLE movies ADD lexemesStarring tsvector;
UPDATE movies SET lexemesStarring = to_tsvector(Starring);
SELECT url FROM movies WHERE lexemesSummary @@ to_tsquery('harry');
ALTER TABLE movies ADD rank float4;
UPDATE movies SET rank = ts_rank(lexemesStarring,plainto_tsquery((SELECT Starring FROM movies WHERE url='harry-potter-and-the-goblet-of-fire')));
CREATE TABLE recommendationsBasedOnStarringField AS SELECT url, rank FROM movies WHERE rank > 0.05 ORDER BY rank DESC LIMIT 50;
\copy (SELECT * FROM recommendationsBasedOnStarringField) to '/home/pi/RSL/top50recommendationsStarring.csv' WITH csv;
