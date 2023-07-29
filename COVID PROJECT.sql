--select *
--from ProjectPortfolio..CovidVaccination
--order by 3,4
select *
from ProjectPortfolio..CovidDeaths
order by 3,4

-- Select Data that we are going to be using

select Location,date , total_cases, new_cases,total_deaths,population
from ProjectPortfolio..CovidDeaths
order by 1, 2

--Looking at total cases vs total deaths
-- shows likelihood of dying if you contract covid in your country
SELECT
    Location,
    date,
    total_cases,
    total_deaths,
    (CAST(total_deaths AS float) / CAST(total_cases AS float)) * 100 as DeathPercentage
FROM
    ProjectPortfolio..CovidDeaths
WHERE
    location like '%India%'
ORDER BY
    Location, date;

	--Total cases vs population
	-- Shows what % got covid
SELECT
    Location,
    date,
    total_cases,
	population,
    (CAST(total_cases AS float) / population) * 100 as CasePercentage
FROM
    ProjectPortfolio..CovidDeaths
WHERE
    location like '%India%'
ORDER BY
    Location, date;

-- Looking at countries with highest infection rate compared to population
SELECT
    Location,
    Max(total_cases) as HighestInfectionCount,
	population,
    Max((Cast(total_cases AS float) / population)) * 100 as CasePercentage
FROM
    ProjectPortfolio..CovidDeaths
--WHERE location like '%India%'
GROUP BY
    population, location
ORDER BY
    CasePercentage desc

-- Looking at countries with highest Dying count per population

SELECT
    Location,
    Max(Cast(total_deaths AS bigint)) as TotalDeathCount
FROM
    ProjectPortfolio..CovidDeaths
Where 
    continent is NOT NULL
GROUP BY
    location
ORDER BY
    TotalDeathCount desc

-- let's break things down by Continent

SELECT
    location,
    Max(Cast(total_deaths AS bigint)) as TotalDeathCount
FROM
    ProjectPortfolio..CovidDeaths
Where 
    continent is NULL
GROUP BY
    location
ORDER BY
    TotalDeathCount desc

-- global numbers
select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast
(new_deaths as int))/ sum(new_cases)*100 as DeathPercentage
from ProjectPortfolio..CovidDeaths
where continent is not null
order by 1, 2

-- Looking at total Population vs vaccinations
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,sum(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location,
dea.date) as PeopleVaccinated
--,(PeopleVaccinated/Population)*100
FROM ProjectPortfolio..CovidDeaths dea
JOIN ProjectPortfolio..CovidVaccination vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3

--Using CTE

with PopvsVac (Continent, location, date, population , new_vaccintaions,PeopleVaccinated)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,sum(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location,
dea.date) as PeopleVaccinated
FROM ProjectPortfolio..CovidDeaths dea
JOIN ProjectPortfolio..CovidVaccination vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
)
select * ,(PeopleVaccinated / population)*100 as PercentageOfPeopleVaccinated
from PopvsVac

-- Temp table
Drop table if exists #PercentPopulationVaccinated
create table #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
New_vaccination numeric,
PeopleVaccinated numeric
)
insert into #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,sum(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location,
dea.date) as PeopleVaccinated
FROM ProjectPortfolio..CovidDeaths dea
JOIN ProjectPortfolio..CovidVaccination vac
ON dea.location = vac.location
AND dea.date = vac.date
--WHERE dea.continent IS NOT NULL

select * ,(PeopleVaccinated / population)*100 as PercentageOfPeopleVaccinated
from #PercentPopulationVaccinated

--Creating view to store date for later visulaizations 

Create view PercentPeopleVaccinated1 as 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,sum(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location,
dea.date) as PeopleVaccinated
FROM ProjectPortfolio..CovidDeaths dea
JOIN ProjectPortfolio..CovidVaccination vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL

SELECT * FROM PercentPeopleVaccinated1