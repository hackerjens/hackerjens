DROP TABLE recommendationsBasedOnTitleField;
ALTER TABLE movies ADD lexemesTitle tsvector;
UPDATE movies SET lexemesTitle = to_tsvector(Title);
SELECT url FROM movies WHERE lexemesTitle @@ to_tsquery('harry');
ALTER TABLE movies ADD rank float4;
UPDATE movies SET rank = ts_rank(lexemesTitle,plainto_tsquery((SELECT Title FROM movies WHERE url='harry-potter-and-the-goblet-of-fire')));
CREATE TABLE recommendationsBasedOnTitleField AS SELECT url, rank FROM movies WHERE rank > 0.05 ORDER BY rank DESC LIMIT 50;
\copy (SELECT * FROM recommendationsBasedOnTitleField) to '/home/pi/RSL/top50recommendationsTitle.csv' WITH csv;
