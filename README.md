# COVID-19 Data Analysis Project

## Introduction

This project aims to analyze COVID-19 data, including cases, deaths, vaccinations, and population statistics from various countries and continents. The analysis is based on data obtained from the reputable source [Our World in Data](https://ourworldindata.org/covid-deaths), which provides reliable and up-to-date information on the COVID-19 pandemic.

## Data Source

The project utilizes data from the following source:

[Our World in Data](https://ourworldindata.org/covid-deaths): This website provides comprehensive COVID-19 data for different countries, including information on cases, deaths, testing, vaccinations, and more.

## SQL Queries

The project uses SQL queries to perform the following analyses:

--Likelihood of Dying: Calculates the likelihood of dying if a person contracts COVID-19 in a specific country.

--Percentage of Population Infected: Shows the percentage of the population that has contracted COVID-19 in a particular country.

--Highest Infection Rate: Identifies countries with the highest infection rates compared to their population.

--Highest Death Count: Lists countries with the highest death counts per population.

--Population vs. Vaccinations: Compares the total population to the number of vaccinations administered and calculates the percentage of people vaccinated.

## Creating Views

To facilitate data retrieval and visualization, the project creates a view named "PercentPeopleVaccinated1." This view stores information about population vs. vaccinations for later use in visualizations.

## Usage

To run the SQL queries and create the view, follow these steps:

--Ensure you have access to the "CovidDeaths" and "CovidVaccination" tables in your SQL database.

--Execute the provided SQL queries in your SQL client to perform the data analysis.

--Once the queries have been executed successfully, the view "PercentPeopleVaccinated1" will be available for later use.

## Contributing

Contributions to this project are welcome. If you find any issues or have ideas for further analysis, feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License.

## Acknowledgments

We would like to acknowledge [Our World in Data](https://ourworldindata.org/covid-deaths) for providing valuable and reliable data for understanding the impact of the COVID-19 pandemic.
