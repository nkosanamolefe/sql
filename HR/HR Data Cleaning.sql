CREATE DATABASE hrproject;

USE hrproject;

SELECT * FROM hrproject..hr;

ALTER TABLE hr
RENAME COLUMN id TO emp_id VARCHAR(20) NULL;

DESCRIBE hr;

SET sql_safe_updates = 0;

UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

UPDATE hr
SET hire_date= CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

UPDATE hr
SET termdate = CASE 
	WHEN termdate = '' THEN CURDATE() ELSE date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')) END
WHERE termdate IS NOT NULL;

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

UPDATE hr 
SET termdate = '1000-01-01'
WHERE termdate = '2023-12-03';

ALTER TABLE hr ADD COLUMN age INT;

SELECT * FROM hr;

UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT birthdate, age FROM hr;

SELECT 
	min(age) AS yougest,
    max(age) AS oldest
FROM hr;

SELECT count(*) FROM hr WHERE age < 18;