-- SELECT *
-- FROM PortfolioProject.dbo.CovidDeaths

-- Select data that will be used
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject.dbo.CovidDeaths
ORDER BY 1, 2

-- Looking at total cases vs. total deaths
-- Displays likelihood of dying if you're COVID positive in the U.S.
SELECT location, date, total_cases, total_deaths, (total_deaths/ CAST(total_cases AS FLOAT))*100 AS death_percentage
FROM PortfolioProject.dbo.CovidDeaths
WHERE location LIKE '%States%'
ORDER BY 1, 2

-- Looking at total cases vs. population
-- Displays percentage of population was COVID positive
SELECT location, date, total_cases, population, (total_cases/ CAST(population AS FLOAT))*100 AS case_pop_percentage
FROM PortfolioProject.dbo.CovidDeaths
WHERE location LIKE '%States%'
ORDER BY 1, 2

-- Looking at countries with highest infection rate vs population
SELECT location, population, MAX(total_cases) AS highest_infect_count, MAX(total_cases/ CAST(population AS FLOAT))*100 AS case_pop_percentage
FROM PortfolioProject.dbo.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY 4 DESC

-- Looking at countries with the highest death count per population
SELECT location, MAX(total_deaths) AS total_death_count
FROM PortfolioProject.dbo.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY 2 DESC


-- Breaking Down By Continent

-- Lookikng at continents with highest death count
SELECT location, MAX(total_deaths) AS total_death_count
FROM PortfolioProject.dbo.CovidDeaths
WHERE continent IS NULL
GROUP BY location
ORDER BY 2 DESC


-- Breaking Down By Global Numbers
SELECT SUM(new_cases) AS total_new_cases, 
       SUM(new_deaths) AS total_new_death, 
       (SUM(new_deaths)/CAST(SUM(new_cases) AS FLOAT))*100 AS death_percentage
FROM PortfolioProject.dbo.CovidDeaths
WHERE continent is NOT NULL
ORDER BY 1, 2

-- Looking at total population vs vaccinations
SELECT deaths.continent, deaths.location, deaths.date, deaths.population, vacc.new_vaccinations,
    SUM(CAST(vacc.new_vaccinations AS INT)) 
    OVER (PARTITION BY deaths.location ORDER BY deaths.location, deaths.date) AS total_vacc_loc
FROM PortfolioProject.dbo.CovidDeaths deaths
JOIN PortfolioProject.dbo.CovidVaccinations vacc
ON deaths.location = vacc.location
AND deaths.date = vacc.date
WHERE deaths.continent IS NOT NULL
ORDER BY 2,3

-- Using CTE
WITH pop_vs_vacc AS (
    SELECT deaths.continent, deaths.location, deaths.date, deaths.population, vacc.new_vaccinations,
        SUM(CAST(vacc.new_vaccinations AS INT)) 
        OVER (PARTITION BY deaths.location ORDER BY deaths.location, deaths.date) AS total_vacc_loc
    FROM PortfolioProject.dbo.CovidDeaths deaths
    JOIN PortfolioProject.dbo.CovidVaccinations vacc
    ON deaths.location = vacc.location
    AND deaths.date = vacc.date
    WHERE deaths.continent IS NOT NULL
    -- ORDER BY 2,3
)

SELECT *, (total_vacc_loc/ CAST(population AS FLOAT))*100 vacc_percentage
FROM pop_vs_vacc

-- Using Temp Table

-- DROP TABLE IF EXISTS #PercentPopulationVaccination -- delete for modifications

CREATE TABLE #PercentPopulationVaccination
(
    continent NVARCHAR(255),
    location NVARCHAR(255),
    date DATETIME,
    population NUMERIC,
    new_vaccinations NUMERIC,
    total_vacc_loc NUMERIC
)

INSERT INTO #PercentPopulationVaccination
SELECT deaths.continent, deaths.location, deaths.date, deaths.population, vacc.new_vaccinations,
    SUM(CAST(vacc.new_vaccinations AS INT)) 
    OVER (PARTITION BY deaths.location ORDER BY deaths.location, deaths.date) AS total_vacc_loc
FROM PortfolioProject.dbo.CovidDeaths deaths
JOIN PortfolioProject.dbo.CovidVaccinations vacc
ON deaths.location = vacc.location
AND deaths.date = vacc.date
WHERE deaths.continent IS NOT NULL

SELECT *, (total_vacc_loc/ CAST(population AS FLOAT))*100 vacc_percentage
FROM #PercentPopulationVaccination


-- Creating view to store data for later visualiztion
CREATE VIEW PercentPopulationVaccination AS
(
SELECT deaths.continent, deaths.location, deaths.date, deaths.population, vacc.new_vaccinations,
    SUM(CAST(vacc.new_vaccinations AS INT)) 
    OVER (PARTITION BY deaths.location ORDER BY deaths.location, deaths.date) AS total_vacc_loc
FROM PortfolioProject.dbo.CovidDeaths deaths
JOIN PortfolioProject.dbo.CovidVaccinations vacc
ON deaths.location = vacc.location
AND deaths.date = vacc.date
WHERE deaths.continent IS NOT NULL)

SELECT *
FROM PercentPopulationVaccination