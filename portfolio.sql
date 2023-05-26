--PORTFOLIO PROJECT 1


--SELECT *
--FROM [dbo].[covidvaccines$]

SELECT *
FROM [dbo].[CovidDeaths$]

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM [dbo].[CovidDeaths$]
ORDER BY 1, 2

--LOOKING AT TOTAL CASES VS TOTAL DEATHS
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 AS Deathpercentage
FROM [dbo].[CovidDeaths$]
ORDER BY 1, 2


--looking at total cases vs the population
SELECT location, date, total_cases, population, (total_cases/population) * 100 AS TotalcasePopulationPercentage
FROM [dbo].[CovidDeaths$]
--WHERE location LIKE 'G%'
ORDER BY 1, 2

--looking at countries with the highest infection rate compared to population.
SELECT location, MAX(total_cases) AS HighestInfectionCount, population,MAX((total_cases/population)) * 100 AS InfectedRatePercentage
FROM [dbo].[CovidDeaths$]
--WHERE location LIKE 'G%'
GROUP BY location, population
ORDER BY InfectedRatePercentage DESC




--SHOWING COUNTRY WITH HIGHEST DEATH COUNT PER POPULATION
SELECT location, MAX(total_deaths) AS totalDeathCount, population
FROM [dbo].[CovidDeaths$]
--WHERE location LIKE 'G%'
GROUP BY location, population
ORDER BY totalDeathCount DESC


--LOCATIONS AND THEIR HIGHEST POPULATION
SELECT location, MAX(population)
FROM [dbo].[CovidDeaths$]
WHERE continent IS NOT NULL
GROUP BY location
--ORDER BY  DESC



SELECT continent, MAX(cast(new_cases AS int)) AS NewCasescount, MAX(population)
FROM [dbo].[CovidDeaths$]
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY NewCasescount 

--global numbers
SELECT Year(date), total_cases, total_deaths
FROM  [dbo].[CovidDeaths$]
WHERE continent IS NOT NULL AND total_cases IS NOT NULL
ORDER BY 1, 2

SELECT Year(date) AS NewYear,SUM(cast(new_deaths as int)), SUM(cast(new_deaths as int))
FROM  [dbo].[CovidDeaths$]
WHERE continent IS NOT NULL 
GROUP BY date
ORDER BY 1, 2

SELECT dea.continent, dea.location, dea.population, vac.new_vaccinations
FROM [dbo].[CovidDeaths$] dea
JOIN [dbo].[covidvaccines$] vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 1,2 


SELECT *FROM [dbo].[covidvaccines$]

SELECT dea.continent, dea.location, dea.population, vac.new_vaccinations 
FROM [dbo].[CovidDeaths$] dea
JOIN [dbo].[covidvaccines$] vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 1,2 


 WITH Popvar (cintinent, location, population, new_vaccinations)
 AS
 (
 SELECT dea.continent, dea.location, dea.population, vac.new_vaccinations
FROM [dbo].[CovidDeaths$] dea
JOIN [dbo].[covidvaccines$] vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 1,2 
)
SELECT *
FROM Popvar


CREATE TABLE PresentInfo
(continent varchar(50),
location varchar(50), 
population numeric,
new_vaccinations numeric
)
INSERT INTO PresentInfo
SELECT dea.continent, dea.location, dea.population, vac.new_vaccinations 
FROM [dbo].[CovidDeaths$] dea
JOIN [dbo].[covidvaccines$] vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 1,2 

SELECT *
FROM PresentInfo

--creating view to store data for data visualization.
CREATE VIEW Info AS
SELECT dea.continent, dea.location, dea.population, vac.new_vaccinations 
FROM [dbo].[CovidDeaths$] dea
JOIN [dbo].[covidvaccines$] vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 1,2 


CREATE VIEW  ContinentInfo AS
SELECT continent, MAX(cast(new_cases AS int)) AS NewCasescount, MAX(population) AS HighestPopulation
FROM [dbo].[CovidDeaths$]
WHERE continent IS NOT NULL
GROUP BY continent
--ORDER BY NewCasescount 