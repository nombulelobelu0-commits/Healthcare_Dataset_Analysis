select *
from [dbo].[healthcare_dataset]

-- firstly we need to clean this data
--1.standardise the name casing
UPDATE [dbo].[healthcare_dataset]
SET Name = lower(Name)



--2.Find duplicates

Select Name,Age,Gender,[Blood Type], [Medical Condition] ,
ROW_NUMBER() over(partition by Name, Age,Gender,[Blood Type], [Medical Condition] Order by Age ) as ROW_num
from [dbo].[healthcare_dataset];



 --after adding row num we can now delete Duplicates 

select *
from
(
Select Name,Age,Gender,[Blood Type], [Medical Condition] ,
ROW_NUMBER() over(partition by Name,Age,Gender,[Blood Type], [Medical Condition] Order by Age ) as ROW_num
from [dbo].[healthcare_dataset]
) 
Duplicates
where ROW_num > 1 ;


-- delete duplicates
 With healthcare_CTE As
 (
 select *
from
(
Select Name,Age,Gender,[Blood Type], [Medical Condition] ,
ROW_NUMBER() over(partition by Name, Age,Gender,[Blood Type], [Medical Condition] Order by Age ) as ROW_num
from [dbo].[healthcare_dataset]
) 
Duplicates
where ROW_num > 1 
)
Delete 
From healthcare_CTE

select *
from [dbo].[healthcare_dataset]
-- Standardize data

-- checking for null values
SELECT *
FROM [dbo].[healthcare_dataset]
WHERE Name IS NULL
   OR Age IS NULL
   OR Gender IS NULL
   OR [Blood Type] IS NULL
   OR [Medical Condition] IS NULL
   OR [Date of Admission] IS NULL
   OR Doctor IS NULL
   OR Hospital IS NULL
   OR [Insurance Provider] IS NULL
   OR [Billing Amount] IS NULL
   OR [Room Number] IS NULL
   OR [Admission Type] IS NULL
   OR [Discharge Date] IS NULL
   OR Medication IS NULL
   OR [Test Results] IS NULL;
   -- our results show us that we have no "Null" values

   -- checking for empty cells
   SELECT *
FROM [dbo].[healthcare_dataset]
WHERE Name = ''
   OR Gender = ''
   OR [Blood Type] = ''
   OR [Medical Condition] = ''
   OR Doctor = ''
   OR Hospital = ''
   OR [Insurance Provider] = ''
   OR [Admission Type] = ''
   OR Medication = ''
   OR [Test Results] = '';
   -- our results show us that we have no "Empty" values/cells

   --now checking gender
SELECT DISTINCT Gender
FROM [dbo].[healthcare_dataset];
-- checking blood type
SELECT DISTINCT [Blood Type]
FROM [dbo].[healthcare_dataset];
-- checking medical condition
SELECT DISTINCT [Medical Condition]
FROM [dbo].[healthcare_dataset];
-- checking date
SELECT [Date of Admission], [Discharge Date]
FROM [dbo].[healthcare_dataset];

-- Every column is starndardized.








