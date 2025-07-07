-- data cleaning

SELECT *
FROM world_layoffs;

 -- in this data cleaning project, i will perform the following tasks
 --   Remove Duplicates
 --   Standaraddize the Data
 --   Null and Blank Values
 --   Remove unnecesssary columns

/*I copy the raw table into another table to perform my data cleaning incase anything happened then i will have my raw data back
CREATE TABLE layoff AS
SELECT *
FROM world_layoffs; */

-- checking for duplicates
SELECT *,
ROW_NUMBER() OVER
(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions ) AS Row_number
FROM layoff;

WITH duplicates AS (
SELECT *,
ROW_NUMBER() OVER
(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions ) AS Row_number
FROM layoff
)
SELECT * 
FROM duplicates
WHERE Row_number > 1;

/* i noticed i cant delete straight with DELETE statement (i cant update CTE)
so i created another table(with PGadmin) that conatin the same exact columns with the
resultant of CTE above, so i will just insert the content to the table*/
--INSERT INTO layoffS
--SELECT *,
--ROW_NUMBER() OVER
--(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions ) AS row_number
--FROM layoffs;

-- the method above didnt work for me, its populating the data so i had to make the ressultant another sql table in the database
-- the table name is layoffs
-- Deleting Duplicates
DELETE
FROM layoffs
WHERE row_number > 1;

-- Checking the new table to see if there is still duplicates
SELECT *
FROM layoffs 
WHERE row_number > 1;

-- Standardizing data
-- i started from cleaning the blank spaces around the company column
SELECT  company, TRIM(company)
FROM layoffs;

UPDATE layoffs
SET company = TRIM(company);

--Checking the industry column if there is error in the column value
SELECT  DISTINCT industry
FROM layoffs
ORDER BY 1;

SELECT industry
FROM layoffs
WHERE industry LIKE 'Crypto%';

UPDATE layoffs
SET industry = 'Crypto' 
WHERE industry LIKE 'Crypto%';

SELECT  DISTINCT industry
FROM layoffs
ORDER BY 1;

--- checking the country column and found that there is erroe in United state input.
SELECT DISTINCT country
FROM layoffs;

UPDATE layoffs
SET country = 'United State'
WHERE country LIKE 'United%';

SELECT DISTINCT country
FROM layoffs;

-- trouble shooting every column to make sure i clean what need to be cleaned
SELECT *
FROM layoffs
WHERE company = 'Airbnb';

SELECT company, industry
FROM layoffs
WHERE industry IS NULL;
-- checking out columns to figure out any issues with them
SELECT * 
FROM layoffs
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- -- Checking where industry is null, but both company and location are not null
SELECT * 
FROM layoffs
WHERE industry IS NULL;

UPDATE layoffs
SET industry = NULL
WHERE industry = '';

-- so ichecked through each company to see if i can populate the industry name 
-- i.e if they have the same company, then they are of the same industry

SELECT *
FROM layoffs
WHERE company = 'Airbnb';


SELECT l1.industry, l2.industry
FROM layoffs AS l1
JOIN layoffs AS l2
	ON l1.company = l2.company
WHERE l1.industry IS NULL
AND l2.industry IS NOT NULL;

--updating the industry column with data from the same table that its industry column is not null 
-- The below code doesnt work for me (postgresql) but it work in mysql
/*UPDATE layoffs AS l1
JOIN layoffs AS l2
ON l1.company = l2.company
SET l1.industry = l2.industry
WHERE (l1.industry IS NULL OR l1.industry = '')
AND l2.industry IS NOT NULL;*/

UPDATE layoffs as l1
SET industry = l2.industry
FROM layoffs AS l2
WHERE l1.company = l2.company
AND l1.industry IS NULL
AND l2.industry IS NOT NULL;
--- checking if it has populated the indusrty column
SELECT *
FROM layoffs
WHERE company = 'Airbnb';

--- checking if it has populated the indusrty column
SELECT *
FROM layoffs
WHERE company = 'Airbnb';

-- I discovered that if there are no total_laid off or percenatge laid, then that row might be useless during EDA
SELECT * 
FROM layoffs
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Deleting unecesary rows
DELETE 
FROM layoffs
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

--checking again
SELECT * 
FROM layoffs
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

--Dropping unecessary columns
ALTER TABLE layoffs
DROP COLUMN row_number;

SELECT *
FROM layoffs;

