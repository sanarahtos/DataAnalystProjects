# COVID-19 Data Analysis Project

## 📌 Project Overview
This project analyzes COVID-19 data, focusing on cases, deaths, and vaccinations. It demonstrates data extraction, transformation, and aggregation using **SQL** and prepares insights for visualization in **Tableau**.

## 📊 Datasets Used
- `CovidDeaths` - Contains COVID-19 case and death statistics
- `CovidVaccinations` - Includes vaccination data
- Data source: [Our World in Data](https://ourworldindata.org/coronavirus)

## 🛠️ Skills Demonstrated
### 1️ Data Querying & Filtering
- `SELECT`, `WHERE`, `ORDER BY` for extracting and sorting relevant data
- Filtering specific locations (`WHERE location LIKE '%States%'`)

### 2️ Data Aggregation & Statistical Analysis
- **Summarizing data** with `SUM()`, `MAX()`, and `COUNT()`
- **Calculating key metrics**:
  - Death rate: `(total_deaths / total_cases) * 100`
  - Infection rate: `(total_cases / population) * 100`
  - Vaccination rate: `(total_vacc_loc / population) * 100`

### 3️ Joins & Data Relationships
- **Merging datasets** using `INNER JOIN` to combine COVID cases and vaccination data

### 4️ Advanced SQL Techniques
- **Common Table Expressions (CTEs)** for improved query readability
- **Window Functions** (`SUM() OVER (PARTITION BY location ORDER BY date)`) for running totals
- **Temporary Tables** to store intermediate results for further analysis
- **Views** (`CREATE VIEW`) for reusable queries in **Tableau**

## 📈 Insights & Key Findings
- **Likelihood of Death:** Analyzed total cases vs. total deaths to determine the fatality rate
- **Infection Rate:** Examined the percentage of the population infected in different countries
- **Vaccination Trends:** Tracked cumulative vaccinations over time
- **Global Comparisons:** Identified countries and continents with the highest infection and death rates

## 📌 Future Enhancements
- Automating data updates via **ETL pipeline**
- Enhancing performance with **indexing**
- Expanding analysis to **regional trends**

---

💡 **Developed by:** Sarah Santos 
🔗 **Connect with me:** [LinkedIn](https://www.linkedin.com/in/sanarahtos/)

---

