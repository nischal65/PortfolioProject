select *
from CovidDeaths
order by 3,4 

--select *
--from CovidVaccination
----order by 3,4

--Select Data that we are going to be using

select Location, date, total_cases, new_cases,total_deaths, population
from CovidDeaths 
order by 1,2

--Looking at Total cases vs Total deaths
--Shoes likelihood of dying if you contact covid in your country

select Location, date,cast(total_cases as int) as total_cases,
cast(total_deaths as int) as total_deaths,
(total_deaths/total_cases)*100 as DeathPercentage
from ProjectPortfolio.dbo.CovidDeaths a
WHERE location like '%Australia%'
order by 1,2

--Looking at Total cases vs Population 
--Shows what prcentage of Population got Covid

select Location, date, population, total_cases,
(total_cases/population)*100 as DeathPercentage
from ProjectPortfolio.dbo.CovidDeaths a
WHERE location like '%Australia%'
order by 1,2


--Looking at countries with Highest Infection Rate compared to Population 

select Location,population, MAX(total_cases) AS HighestInfectionCount,
MAX(total_cases/population)*100 as PopulationInfectedPercentage
from ProjectPortfolio.dbo.CovidDeaths a
--WHERE location like '%Australia%'
Group by Location, population
order by PopulationInfectedPercentage desc


--Showing Countries with highest death count per population 

select Location, MAX(cast(total_deaths as int)) AS TotaldeathCount
from ProjectPortfolio.dbo.CovidDeaths a
--WHERE location like '%Australia%'
where continent is not null
Group by Location
order by TotaldeathCount desc

--Lets break things down by continent

--showing the continents with the highest death count per population

select continent, MAX(cast(total_deaths as int)) AS TotaldeathCount
from ProjectPortfolio.dbo.CovidDeaths a
--WHERE location like '%Australia%'
where continent is not null
Group by continent
order by TotaldeathCount desc

--Global Numbers

select  sum(new_cases) as total_cases ,
sum(cast(new_deaths as int)) as total_deaths,
sum(cast(new_deaths as int))/Sum(new_cases)*100 as DeathPercentage
from ProjectPortfolio.dbo.CovidDeaths 
--WHERE location like '%Australia%'
where continent is not null
--group by  date
order by 1,2

--Looking at Total Population vs Vaccinations

Select dea.continent, dea.location,dea.date,dea.population,
vac.new_vaccinations, sum(convert(int,vac.new_vaccinations))
over (Partition by dea.location,dea.date) as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100
From CovidDeaths dea
Join
 CovidVaccination vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null 
order by 2,3

--USE CTE

with PopvsVac (Continent, Location, Date, Population, new_vaccination, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location,dea.date,dea.population,
vac.new_vaccinations, sum(convert(int,vac.new_vaccinations))
over (Partition by dea.location,dea.date) as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100
From CovidDeaths dea
Join
 CovidVaccination vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null 
--order by 2,3
)
select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac



----temp table 

drop table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccination numeric,
RollingPeopleVaccinated numeric
)
Insert into #PercentPopulationVaccinated

Select dea.continent, dea.location,dea.date,dea.population,
vac.new_vaccinations, sum(convert(int,vac.new_vaccinations))
over (Partition by dea.location,dea.date) as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100
From CovidDeaths dea
Join
 CovidVaccination vac
on dea.location=vac.location
and dea.date=vac.date
--where dea.continent is not null 
--order by 2,3

select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated

--Creating view to store data for later visualisations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location,dea.date,dea.population,
vac.new_vaccinations, sum(convert(int,vac.new_vaccinations))
over (Partition by dea.location,dea.date) as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100
From CovidDeaths dea
Join
 CovidVaccination vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null 
--order by 2,3

Select *
From PercentPopulationVaccinated