select *
from [dbo].[healthcare_dataset]

-- The number of patients admitted to the hospital over a certain period
select 
    year([Date of Admission]) as Year,
    count(Name) as Number_of_Patients
from [dbo].[healthcare_dataset]
group by year([Date of Admission])
order by Year;

--How often each disease or medical condition occurs.
select [Medical Condition],
Count([Medical Condition]) as Number_of_occurance
from [dbo].[healthcare_dataset]
group by [Medical Condition]
order by Number_of_occurance;


-- admision Numbers based on gender
select Gender ,
count(Gender) as Addmitted_gender
from [dbo].[healthcare_dataset]
group by Gender
order by Addmitted_gender;

--checking age that is mostly likely to be admitted
select Age,
count(Age) as Admission_by_Age
from [dbo].[healthcare_dataset]
group by Age
order by  Admission_by_Age DESC;


--Most common medication
select [Medication],
count([Medication]) as Common_medication
from [dbo].[healthcare_dataset]
group by [Medication]
order by  Common_medication;


--Most used insurance
select [Insurance Provider] ,
count([Insurance Provider]) as Number_of_users
from [dbo].[healthcare_dataset]
group by [Insurance Provider]
order by Number_of_users DESC

--most used hospitals
select [Hospital] ,
count([Hospital]) as Number_of_users
from [dbo].[healthcare_dataset]
group by [Hospital]
order by Number_of_users DESC

--most used hospitals
select [Doctor] ,
count([Hospital]) as Number_of_users
from [dbo].[healthcare_dataset]
group by [Doctor]
order by Number_of_users DESC


--===================================================================================

-- Most expensive care
select [Medical Condition],
avg(cast([Billing Amount] as decimal(10,2))) as Avg_billing
from [dbo].[healthcare_dataset]
group by [Medical Condition]
order by Avg_billing desc;

--Blood types with more admission
select [Blood Type], [Admission Type], count(*) as Number_of_patients
from [dbo].[healthcare_dataset]
group by [Blood Type], [Admission Type]
order by [Blood Type], Number_of_patients desc;

--medical condition based on gender
Select [Gender] , [Medical Condition] , Count(*) As Number_of_patients
from [dbo].[healthcare_dataset]
group by [Gender] , [Medical Condition]
order by Gender, Number_of_patients

-- Insurance that generates most money
Select [Insurance Provider],
avg(cast([Billing Amount] as decimal(10,2))) as Total_Billing_Amount
from [dbo].[healthcare_dataset]
group by [Insurance Provider]
order by Total_Billing_Amount DESC


--•	Average billing amount by Admission Type
select [Admission Type],
avg(cast([Billing Amount] as decimal(10,2))) as Avg_billing
from [dbo].[healthcare_dataset]
group by [Admission Type]
order by Avg_billing desc;


--•	Discharge Date minus Date of Admission = length of stay
SELECT 
 AVG(DATEDIFF(day, [Date of Admission], [Discharge Date])) AS [Average Length of Stay (Days)]
FROM [dbo].[healthcare_dataset];

--•	Average length of stay by Medical Condition
select 
[Medical Condition],
avg(datediff(day, [Date of Admission], [Discharge Date])) as [Average Length of Stay (Days)],
count(*) as [Total Patients]
from [dbo].[healthcare_dataset]
group by [Medical Condition]
order by [Average Length of Stay (Days)] desc;


-- AGE VS medical condition

Select [Age] , [Medical Condition] , Count(*) As Number_of_patients
from [dbo].[healthcare_dataset]
group by [Age] , [Medical Condition]
order by Age, Number_of_patients;

Select [Age] , [Medical Condition] , Count(*) As Number_of_patients
from [dbo].[healthcare_dataset]
group by [Age] , [Medical Condition]
order by Number_of_patients,Age desc

