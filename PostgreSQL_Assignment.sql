-- Active: 1747747998720@@127.0.0.1@5432@conservation_db@public
-- Creating Table and Insert Values 
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name  VARCHAR(100) NOT NULL,
    region TEXT  NOT NULL
);

INSERT INTO rangers ( name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name  VARCHAR(100) NOT NULL,
    scientific_name  VARCHAR(100) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status  VARCHAR(100) NOT NULL
);

INSERT INTO species ( common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
( 'Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');


CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id SMALLINT REFERENCES rangers(ranger_id) ON DELETE CASCADE,
    species_id SMALLINT REFERENCES species(species_id) ON DELETE CASCADE,
    sighting_time TIMESTAMP,
    location VARCHAR(100) NOT NULL,
    notes TEXT 
);
INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge',        '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area',     '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass',     '2024-05-18 18:30:00', NULL);


-- ASSIGNMENT's Solutions starts here

-- Problem 1
INSERT INTO rangers ( name, region) VALUES
('Derek Fox', 'Coastal Plains');


-- Problem 2
SELECT  count(DISTINCT species_id) AS unique_species_count FROM sightings ;

-- Problem 3
SELECT * from sightings WHERE location LIKE '%Pass%';
 
 -- Problem 4
SELECT rangers.name, count(sighting_time)
FROM sightings INNER JOIN rangers USING (ranger_id)
GROUP  BY rangers.name ORDER BY rangers.name;

--Problem 5

SELECT species.common_name as common_name
FROM species left JOIN sightings USING(species_id) 
WHERE sightings.sighting_time is NULL;

--Problem 6
SELECT  sp.common_name, s.sighting_time, r.name 
from sightings s
JOIN
    species sp ON s.species_id = sp.species_id
JOIN
    rangers r ON s.ranger_id = r.ranger_id
ORDER BY s.sighting_time DESC LIMIT 2

--Problem 7
UPDATE species
SET conservation_status = 'Historic'
WHERE EXTRACT(YEAR FROM discovery_date) < 1800;

--Problem 8
SELECT
    sighting_id,
    CASE
        WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 5 AND 11 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM sightings
ORDER BY sighting_id;

--Problem 9

DELETE FROM rangers
WHERE name = (SELECT rangers.name
FROM rangers
LEFT JOIN sightings USING (ranger_id)
GROUP BY rangers.name
HAVING COUNT(species_id) = 0)

