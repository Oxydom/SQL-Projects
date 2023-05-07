-- CREATING THE DENORMALIZED TABLE
CREATE TABLE denormalized_table (
    year INTEGER,
    disaster_group TEXT,
    disaster_subgroup TEXT,
    disaster_type TEXT,
    disaster_subtype TEXT,
    iso TEXT,
    region TEXT,
    continent TEXT,
    origin TEXT,
    associated_disaster TEXT,
    ofda_response TEXT,
    disaster_magnitude_value TEXT,
    latitude VARCHAR (255),
    longitude VARCHAR (255),
    start_year INTEGER,
    end_year INTEGER,
    total_deaths INTEGER,
    no_injured INTEGER,
    no_affected INTEGER,
    no_homeless INTEGER,
    total_affected INTEGER,
    total_damages_usd NUMERIC,
    total_damages_adjusted_usd NUMERIC,
    country TEXT,
    location TEXT
);


--Importing data
COPY denormalized_table FROM 'C:\Users\HP\Desktop\DENORMALIZED_TABLE.CSV' delimiter

COPY denormalized_table FROM 'C:\Users\HP\Desktop\Disaster.csv' DELIMITER ',' CSV HEADER;

SELECT * FROM denormalized_table

---INSIGHT 1 - the most frequent disaster type accross all countries

SELECT disaster_type, COUNT(*) as frequency
FROM denormalized_table
GROUP BY disaster_type
ORDER BY frequency DESC
LIMIT 5;

-- we can also show the frequency of the disaster type in each country?

SELECT country, disaster_type, COUNT(*) AS count
FROM denormalized_table dt
GROUP BY country, disaster_type
HAVING COUNT(*) >= ALL (
    SELECT COUNT(*)
    FROM denormalized_table
    WHERE country = dt.country
    GROUP BY disaster_type
)
ORDER BY country;

-- We can also view the 3 most commnon disaster type in each country

SELECT country, disaster_type, COUNT(*) AS count
FROM denormalized_table dt
GROUP BY country, disaster_type
HAVING COUNT(*) IN (
    SELECT COUNT(*)
    FROM denormalized_table
    WHERE country = dt.country
    GROUP BY disaster_type
    ORDER BY COUNT(*) DESC
    LIMIT 3
)
ORDER BY country, count DESC, disaster_type;

--RECOMMNDATION - countries should formulate policies to address and mitigate specific disastertypes peculiar to their locations.
--More Resources should be channeled towards preventing flood as it is the most common disaster type.

--INSIGHT 2... WHICH OF THE DISASTER TYPES CAUSES MORE DEATHS ACCROSS ALL REGION?

SELECT disaster_type, SUM(total_deaths) AS total_deaths
FROM denormalized_table
GROUP BY disaster_type
ORDER BY total_deaths DESC;

--Recommendation.. Since earthquakes causes more deaths, efforts should be geared toward providing early warnings
--and mobilizing rescue efforts to reducethe impacts

--INSIGHT 3... WHAT IS THE OVERALL HUMAN IMPACT OF THE DISASTER'S OVER THE YEARS ACROSS ALL REGION?

SELECT 
    year,
    SUM(total_deaths + no_injured + no_affected + no_homeless) AS total_human_impact 
FROM denormalized_table 
GROUP BY year
HAVING SUM(total_deaths + no_injured + no_affected + no_homeless) IS NOT NULL
ORDER BY total_human_impact DESC;

--- We can also breakdown the total human impacts into specific categories

SELECT SUM(total_deaths) AS total_deaths,
       SUM(no_injured) AS total_injured,
       SUM(no_affected) AS total_affected,
       SUM(no_homeless) AS total_homeless,
       SUM(total_damages_usd) AS total_damages
FROM denormalized_table;

--reviewing the data over the years, there appears to be huge human imapct from disasters
--RECOMMENDATION serious attention needs to be placed on disaster management and rsponse to reduce its impacts on humans.

--INSIGHT 4.To analyze the impact of disasters on different regions and countries. 
--Indonesia appears to be the most hit interms of human casualties and impact. Countries in south eastern Asian appear to be more
--prone to diasaters.

SELECT region, country, SUM(total_deaths) AS total_deaths,
       SUM(no_injured) AS total_injured,
       SUM(no_affected) AS total_affected,
       SUM(no_homeless) AS total_homeless,
       SUM(total_damages_usd) AS total_damages
FROM denormalized_table
GROUP BY region, country
ORDER BY total_deaths DESC;

--RECOMMENDATION
--countries within the South-Eastern Asia Region need to make adequate preparation and take precautions to reduce the impact of disasters on the
--persons living within that region

--INSIGHT 5
--The total damages in monetary value by disaster type. 
--This can provide insight into which types of disasters have the highest economic impact in usd. 

SELECT disaster_type, SUM(total_damages_usd) AS Value_of_damages_in_usd
FROM denormalized_table
GROUP BY disaster_type
ORDER BY Value_of_damages_in_usd DESC;

--RECOMMENDATION
--all efforts must be geared towards prventing disasters as the economic implication is enourmous





