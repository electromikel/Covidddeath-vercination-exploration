--data information for coviddeathsvercination
--SELECT *
--FROM covideathsvercination$

-- data information for coviddeaths
SELECT * 
FROM coviddeaths$
WHERE continent is not null
ORDER BY 3,4

--sorting deaths from africa
SELECT *
FROM coviddeaths$
WHERE continent = 'Africa'

--sorting deaths in africa, from Angola
SELECT *
FROM coviddeaths$
WHERE continent = 'Africa' and location = 'Angola'

---sum of total cases in africa
SELECT SUM(total_cases)
FROM coviddeaths$
WHERE continent = 'Africa'

----sum of new cases in each continent, saved as total_continent death
SELECT SUM(total_cases) AS 'total_continentdeath', continent 
FROM coviddeaths$
GROUP BY continent

--slect the data that we are using
 SELECT total_deaths, total_cases, new_cases, population, location, continent, date
 FROM coviddeaths$
 ORDER BY 1,2

 --LOOKING AT TOTAL CASES VS TOTAL DEATHS

 SELECT total_deaths, total_cases, location, continent, date, (total_deaths/total_cases)*1000 AS deathpercentage
 FROM coviddeaths$
 ORDER BY 1,2

 --looking at deaths by location....NIGERIA
 SELECT total_deaths, total_cases, location, continent, date, (total_deaths/total_cases)*1000 AS deathpercentage
 FROM coviddeaths$
 WHERE location = 'Niger'
 ORDER BY 1,2

---looking at the total cases vs population
 ---shows what percentage of population got covid

 SELECT total_deaths, total_cases, location, date, population, (total_cases/population)*100 AS percenpopinf
 FROM coviddeaths$
 WHERE location = 'Niger'
 ORDER BY 1,2

 --loking at countries with highest infection rate compared to population
 SELECT location, population, MAX(total_cases) AS HIGHESTINFCCOUNT, MAX(total_cases/population)*100 AS percentpopinf
 FROM coviddeaths$
 --WHERE location = 'Niger'
 WHERE continent is not null
 GROUP BY location, population
 ORDER BY percentpopinf desc

--looking at the country with the highest death count/population
SELECT location, MAX(CAST(total_deaths as int)) AS totaldeathcount 
 FROM coviddeaths$
 --WHERE location = 'Niger'
 WHERE continent is not null
 GROUP BY location 
 ORDER BY totaldeathcount  desc

--LOOKING AT CONTINENT

 ----looking at the continent with the highest death count/population(by continent) and not null
SELECT continent, MAX(CAST(total_deaths as int)) AS totaldeathcount 
 FROM coviddeaths$
 --WHERE location = 'Niger'
 WHERE continent is not null
 GROUP BY continent 
 ORDER BY totaldeathcount  desc


 SELECT continent, MAX(CAST(total_deaths as int)) AS totaldeathcount 
 FROM coviddeaths$
 --WHERE location = 'Niger'
 WHERE continent is not null
 GROUP BY continent 
 ORDER BY totaldeathcount  desc

  ----looking at the continent with the highest death count/population(by loaction) and with null
SELECT location, MAX(CAST(total_deaths as int)) AS totaldeathcount 
 FROM coviddeaths$
 --WHERE location = 'Niger'
 WHERE continent is null
 GROUP BY location 
 ORDER BY totaldeathcount  desc

 --- global figures
 --new cases per day

 SELECT date, SUM(new_cases) as totalnewcase_daily --location,total_deaths, continent, (total_deaths/total_cases)*1000 AS deathpercentage
 FROM coviddeaths$
 --WHERE location = 'Niger'
 WHERE continent is not null
 GROUP BY date
 ORDER BY 1,2

--sum of new cases and sum of new death globally
  SELECT date, SUM(new_cases) as totalnewcase_daily, SUM(cast(new_deaths as int))as totalnewdeaths_daily, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as percentagedeaths_daily --location,total_deaths, continent, (total_deaths/total_cases)*1000 AS deathpercentage
 FROM coviddeaths$
 --WHERE location = 'Niger'
 WHERE continent is not null
 GROUP BY date
 ORDER BY 1,2

 --total deaths
  SELECT SUM(new_cases) as totalnewcase_daily, SUM(cast(new_deaths as int))as totalnewdeaths_daily, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as percentagedeaths_daily --location,total_deaths, continent, (total_deaths/total_cases)*1000 AS deathpercentage
 FROM coviddeaths$
 --WHERE location = 'Niger'
 WHERE continent is not null
 --GROUP BY date
 ORDER BY 1,2

 --Querying covidvercination data
SELECT *
FROM covideathsvercination$

--joining coviddeath and covidvercination

SELECT *
FROM coviddeaths$ dea
join covideathsvercination$ ver
ON dea.location = ver.location
and dea.date = ver.date
 
 --total population VS total vercination
SELECT dea.continent, dea.location, dea.date, dea.population, ver.new_vaccinations
FROM coviddeaths$ dea
join covideathsvercination$ ver
ON dea.location = ver.location
and dea.date = ver.date
WHERE dea.continent is not null
ORDER BY 1,2,3

SELECT dea.continent, dea.location, dea.date, dea.population, ver.new_vaccinations
FROM coviddeaths$ dea
join covideathsvercination$ ver
ON dea.location = ver.location
and dea.date = ver.date
WHERE dea.continent is not null
ORDER BY 2,3

SELECT dea.continent, dea.location, dea.date, dea.population, ver.new_vaccinations
, SUM(CONVERT(int, ver.new_vaccinations)) OVER (partition by dea.location order by dea.location, dea.date) as rollingpeopleverccinated
FROM coviddeaths$ dea
join covideathsvercination$ ver
ON dea.location = ver.location
and dea.date = ver.date
WHERE dea.continent is not null
ORDER BY 2,3





  
 




 