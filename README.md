# Healthcare_Dataset_Analysis
End-to-end data analytics project using SQL and Power BI to analyse hospital admissions, medical conditions, billing costs, and hospital operations.

## Project Overview

This project analyses a healthcare dataset to understand hospital admission patterns, the prevalence and cost of different medical conditions, length of stay, and hospital/doctor workload distribution. SQL was used to clean the data and build a series of views, which were then connected directly to Power BI to create an interactive, multi-page dashboard.

## Tools Used
SQL (SQL Server) – Data cleaning and view creation
Power BI – Interactive dashboard development and data visualisation

## Data Cleaning (SQL)

The data cleaning process included:

- Standardising name casing for consistency
- Identifying duplicate records using a window function (ROW_NUMBER partitioned by Name, Age, Gender, Blood Type, and Medical Condition)
- Removing duplicate records using a CTE
- Checking for NULL values across all columns
- Checking for empty string values across all columns
- Checking for inconsistent or unexpected values in Gender, Blood Type, and Medical Condition
- Verifying Date of Admission and Discharge Date were properly formatted

```sql
-- standardise name casing
UPDATE [dbo].[healthcare_dataset]
SET Name = lower(Name)
```

```sql
-- identify duplicates
Select Name,Age,Gender,[Blood Type], [Medical Condition],
ROW_NUMBER() over(partition by Name, Age, Gender, [Blood Type], [Medical Condition] Order by Age) as ROW_num
from [dbo].[healthcare_dataset];
```

```sql
-- remove duplicates
With healthcare_CTE As
(
select *
from
(
Select Name,Age,Gender,[Blood Type], [Medical Condition],
ROW_NUMBER() over(partition by Name, Age, Gender, [Blood Type], [Medical Condition] Order by Age) as ROW_num
from [dbo].[healthcare_dataset]
)
Duplicates
where ROW_num > 1
)
Delete
From healthcare_CTE
```

## SQL Analysis

SQL queries were written to answer key questions, including:

- Number of patients admitted per year
- Frequency of each medical condition
- Admissions by gender and age
- Most common medication, insurance provider, hospital, and doctor
- Average billing amount by medical condition, insurance provider, and admission type
- Average length of stay overall and by medical condition
- Relationship between age and medical condition

```sql
-- average length of stay by medical condition
select
[Medical Condition],
avg(datediff(day, [Date of Admission], [Discharge Date])) as [Average Length of Stay (Days)],
count(*) as [Total Patients]
from [dbo].[healthcare_dataset]
group by [Medical Condition]
order by [Average Length of Stay (Days)] desc;
```

## SQL Views

To bring analysis-ready data directly into Power BI without duplicating logic in DAX, 19 SQL views were created, covering:

**Admissions & Demographics**
vw_patients_by_year, vw_admission_by_gender, vw_admission_by_age, vw_age_group_distribution, vw_condition_by_gender, vw_age_vs_condition

**Medical Condition Analysis**
vw_condition_occurrence, vw_common_medication, vw_test_results_distribution, vw_testresults_vs_condition

**Cost Analysis**
vw_avg_billing_by_condition, vw_billing_by_insurance, vw_billing_by_admission_type

**Length of Stay**
vw_avg_length_of_stay, vw_length_of_stay_by_condition

**Clinical Risk Factors**
vw_bloodtype_admission

**Hospital Operations**
vw_hospital_usage_limited, vw_doctor_usage_Limited, vw_insurance_usage, vw_insurance_vs_admission_type

```sql
-- example view
create view vw_length_of_stay_by_condition as
select
[Medical Condition],
avg(datediff(day, [Date of Admission], [Discharge Date])) as Average_Length_of_Stay,
count(*) as Total_Patients
from [dbo].[healthcare_dataset]
group by [Medical Condition];
```

## Power BI Dashboard

The dashboard is split across four analytical pages plus an Objectives and Insights page:

**Admissions & Demographics** – area chart, donut charts, pie chart, line chart, and clustered column chart covering admissions by year, gender, and age

**Medical Condition Analysis** – donut and clustered column charts covering condition frequency, common medication, and test results

**CLC (Cost, Length of Stay & Condition)** – pivot tables, a combo chart, and a KPI card covering billing amount, length of stay, and their relationship to medical condition

**Hospital Operations** – clustered bar charts and a funnel chart covering hospital and doctor workload, and insurance provider usage

## Key Insights

**Admissions & Demographics**
Admission patterns vary across age groups and gender, with certain age brackets showing higher hospital utilisation than others.

**Medical Condition Analysis**
Some medical conditions occur significantly more often than others, indicating the most common health concerns within this patient population. The relationship between test results and medical conditions shows whether certain conditions are more likely to return abnormal or inconclusive results.

**Cost, Length of Stay & Condition**
Billing amounts vary notably by medical condition and admission type, showing that certain conditions and admission types are more costly to treat than others. Length of stay also differs by condition — conditions requiring longer hospital stays tend to contribute more to overall costs, reinforcing the link between treatment duration and billing amount.

**Hospital Operations**
Certain doctors and hospitals handle a disproportionately higher patient load than others, which may indicate workload imbalances worth investigating. Insurance provider usage varies significantly, and when broken down by admission type, some insurers appear more associated with emergency admissions than elective ones.

## Conclusion

This analysis shows that hospital costs and utilisation are driven by a combination of medical condition, admission type, and length of stay, with certain conditions requiring longer hospital stays and consequently generating higher billing amounts. Admission patterns differ across age groups and gender, highlighting specific demographics that may require targeted healthcare resources. Hospital operations reveal uneven patient distribution across doctors and hospitals, suggesting potential workload imbalances worth further investigation. Overall, the data suggests that cost management efforts should focus on high length-of-stay conditions and admission types, while operational efficiency could be improved by addressing workload distribution across hospitals and doctors.

Repository Contents
Healthcare_data_cleaning.sql – SQL data cleaning scripts
Healthcare_portfolio.sql – SQL analysis queries
Creating_views.sql – SQL view creation for Power BI integration
Healthcare_portfolio.pbix – Interactive Power BI dashboard
README.md – Project documentation

👤 Author

Nombulelo Belu

BCom Economic Science with Econometrics Graduate

Aspiring Data Analyst
