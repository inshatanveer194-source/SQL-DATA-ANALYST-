use world;
show tables;
-- QUESTIONS
SELECT * FROM CITY;
select * from country;
select * from countrylanguage;
-- Question 1 : Count how many cities are there in each country?
SELECT C.NAME , 
COUNT(CI.ID) AS NUMBEROFCITIES FROM COUNTRY AS C
JOIN CITY AS CI ON CI.COUNTRYCODE = C.CODE
GROUP BY C.NAME ;


-- Question 2 : Display all continents having more than 30 countries.
SELECT Continent, COUNT(Code) AS NumberOfCountries
FROM country
GROUP BY Continent
HAVING COUNT(Code) > 30;

-- Question 3 : List regions whose total population exceeds 200 million.
SELECT Region, SUM(Population) AS TotalPopulation
FROM country
GROUP BY Region
HAVING SUM(Population) > 200000000
ORDER BY TotalPopulation DESC;



-- Question 4 : Find the top 5 continents by average GNP per country.
SELECT Continent, AVG(GNP) AS AvgGNP
FROM country
GROUP BY Continent
ORDER BY AvgGNP DESC
LIMIT 5;

-- Question 5 : Find the total number of official languages spoken in each continent.
SELECT co.Continent, COUNT(cl.Language) AS TotalOfficialLanguages
FROM country co
JOIN countrylanguage cl ON cl.CountryCode = co.Code
WHERE cl.IsOfficial = 'T'
GROUP BY co.Continent
ORDER BY TotalOfficialLanguages DESC;

-- Question 6 : Find the maximum and minimum GNP for each continent.
SELECT Continent, MAX(GNP) AS MaxGNP, MIN(GNP) AS MinGNP
FROM country
GROUP BY Continent;





-- Question 7 : Find the country with the highest average city population.
SELECT co.Name AS Country, AVG(ci.Population) AS AvgCityPopulation
FROM country co
JOIN city ci ON ci.CountryCode = co.Code
GROUP BY co.Name
ORDER BY AvgCityPopulation DESC
LIMIT 1;






-- Question 8 : List continents where the average city population is greater than 200,000.
SELECT co.Continent, AVG(ci.Population) AS AvgCityPopulation
FROM country co
JOIN city ci ON ci.CountryCode = co.Code
GROUP BY co.Continent
HAVING AVG(ci.Population) > 200000
ORDER BY AvgCityPopulation DESC;






-- Question 9 : Find the total population and average life expectancy for each continent, ordered by average life 
-- expectancy descending.

SELECT Continent,
       SUM(Population) AS TotalPopulation,
       AVG(LifeExpectancy) AS AvgLifeExpectancy
FROM country
GROUP BY Continent
ORDER BY AvgLifeExpectancy DESC;





-- Question 10 : Find the top 3 continents with the highest average life expectancy, but only include those where 
-- the total population is over 200 million 
SELECT Continent,
       SUM(Population) AS TotalPopulation,
       AVG(LifeExpectancy) AS AvgLifeExpectancy
FROM country
GROUP BY Continent
HAVING SUM(Population) > 200000000
ORDER BY AvgLifeExpectancy DESC
LIMIT 3;