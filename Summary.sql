DROP TABLE recommendationsBasedOnSummaryField;
ALTER TABLE movies ADD lexemesSummary tsvector;
UPDATE movies SET lexemesSummary = to_tsvector(Summary);
SELECT url FROM movies WHERE lexemesStarring @@ to_tsquery('hitman');
ALTER TABLE movies ADD rank float4;
UPDATE movies SET rank = ts_rank(lexemesSummary,plainto_tsquery((SELECT Summary FROM movies WHERE url='the-hitmans-bodyguard')));
CREATE TABLE recommendationsBasedOnSummaryField AS SELECT url, rank FROM movies WHERE rank > 0.05 ORDER BY rank DESC LIMIT 50;
\copy (SELECT * FROM recommendationsBasedOnSummaryField) to '/home/pi/RSL/top50recommendationsSummary.csv' WITH csv;
