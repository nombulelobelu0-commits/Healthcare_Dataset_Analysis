-- Creating views so i can transfer to Power BI

-- patients admitted per year
create view vw_patients_by_year as
select 
    year([Date of Admission]) as Year,
    count(Name) as Number_of_Patients
from [dbo].[healthcare_dataset]
group by year([Date of Admission]);

-- medical condition occurrence
create view vw_condition_occurrence as
select [Medical Condition],
count([Medical Condition]) as Number_of_occurance
from [dbo].[healthcare_dataset]
group by [Medical Condition];

-- admissions by gender
create view vw_admission_by_gender as
select Gender,
count(Gender) as Admitted_gender
from [dbo].[healthcare_dataset]
group by Gender;

-- admissions by age
create view vw_admission_by_age as
select Age,
count(Age) as Admission_by_Age
from [dbo].[healthcare_dataset]
group by Age;

-- most common medication
create view vw_common_medication as
select [Medication],
count([Medication]) as Common_medication
from [dbo].[healthcare_dataset]
group by [Medication];


-- most used insurance
create view vw_insurance_usage as
select [Insurance Provider],
count([Insurance Provider]) as Number_of_users
from [dbo].[healthcare_dataset]
group by [Insurance Provider];

-- most used hospitals
create view vw_hospital_usage_limited as
select Top 10 [Hospital],
count([Hospital]) as Number_of_users
from [dbo].[healthcare_dataset]
group by [Hospital];

-- most used doctors
create view vw_doctor_usage_Limited as
select Top 10 [Doctor],
count([Doctor]) as Number_of_users
from [dbo].[healthcare_dataset]
group by [Doctor];

-- test results distribution
create view vw_test_results_distribution as
select [Test Results],
count(*) as Number_of_results
from [dbo].[healthcare_dataset]
group by [Test Results];

-- most expensive care
create view vw_avg_billing_by_condition as
select [Medical Condition],
avg(cast([Billing Amount] as decimal(10,2))) as Avg_billing
from [dbo].[healthcare_dataset]
group by [Medical Condition];

-- blood type vs admission type
create view vw_bloodtype_admission as
select [Blood Type], [Admission Type],
count(*) as Number_of_patients
from [dbo].[healthcare_dataset]
group by [Blood Type], [Admission Type];

-- medical condition by gender
create view vw_condition_by_gender as
select [Gender], [Medical Condition],
count(*) as Number_of_patients
from [dbo].[healthcare_dataset]
group by [Gender], [Medical Condition];

-- insurance provider billing
create view vw_billing_by_insurance as
select [Insurance Provider],
avg(cast([Billing Amount] as decimal(10,2))) as Total_Billing_Amount
from [dbo].[healthcare_dataset]
group by [Insurance Provider];


-- average billing by admission type
create view vw_billing_by_admission_type as
select [Admission Type],
avg(cast([Billing Amount] as decimal(10,2))) as Avg_billing
from [dbo].[healthcare_dataset]
group by [Admission Type];

-- overall average length of stay
create view vw_avg_length_of_stay as
select 
avg(datediff(day, [Date of Admission], [Discharge Date])) as Average_Length_of_Stay
from [dbo].[healthcare_dataset];

-- average length of stay by condition
create view vw_length_of_stay_by_condition as
select 
[Medical Condition],
avg(datediff(day, [Date of Admission], [Discharge Date])) as Average_Length_of_Stay,
count(*) as Total_Patients
from [dbo].[healthcare_dataset]
group by [Medical Condition];

-- age vs medical condition
create view vw_age_vs_condition as
select [Age], [Medical Condition],
count(*) as Number_of_patients
from [dbo].[healthcare_dataset]
group by [Age], [Medical Condition];

-- test results vs medical condition
create view vw_testresults_vs_condition as
select [Medical Condition], [Test Results],
count(*) as Number_of_patients
from [dbo].[healthcare_dataset]
group by [Medical Condition], [Test Results];

-- insurance provider vs admission type
create view vw_insurance_vs_admission_type as
select [Insurance Provider], [Admission Type],
count(*) as Number_of_patients
from [dbo].[healthcare_dataset]
group by [Insurance Provider], [Admission Type];

-- age group distribution
create view vw_age_group_distribution as
select 
case 
    when Age < 18 then 'Child'
    when Age between 18 and 35 then 'Young Adult'
    when Age between 36 and 60 then 'Adult'
    else 'Senior'
end as Age_Group,
count(*) as Number_of_patients
from [dbo].[healthcare_dataset]
group by 
case 
    when Age < 18 then 'Child'
    when Age between 18 and 35 then 'Young Adult'
    when Age between 36 and 60 then 'Adult'
    else 'Senior'
end;