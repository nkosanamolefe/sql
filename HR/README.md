# Data Cleaning Queries for HR

## Introduction

This document outlines the SQL queries used for cleaning and preparing data within the "hrproject" database. This cleaning process was essential for ensuring data consistency and accuracy prior to further analysis in my data analysis project portfolio.

## Tools

My-SQL

## Data Cleaning Queries

### 1. Database and Table Setup

```sql
CREATE DATABASE hrproject;

USE hrprojects;
```

### Description

* Creates a new database named "hrproject" and switches the context to use this database.

### 2. Import the data and conduct the initial Data Exploration

```sql
SQL
SELECT * FROM hr;
DESCRIBE hr;
```

### Description

* After creating the `DATABASE` right click *Tables* inside the 'hrprojects' and import the CSV data
* `SELECT * FROM hr;` displays the entire content of the 'hr' table, providing an initial overview of the data.
* `DESCRIBE hr;` displays the table's structure, including column names, data types, and nullability.

### 3. Renaming the 'id' Column

```sql
ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;
```

### Description

* Renames the 'ï»¿id' column to 'emp_id' for better clarity within the HR context.

### 4. Standardizing Date Formats

```sql
SET sql_safe_updates = 0; 

UPDATE hr
SET birthdate = CASE
WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

-- Similar update query for 'hire_date' column
```

### Description

* Temporarily disables SQL safe updates for flexibility.
* Updates 'birthdate' and 'hire_date' columns, converting inconsistent date formats to a standard YYYY-MM-DD format.
* Uses `CASE` for conditional updates based on existing patterns.
* Modifies the column data types to `DATE` for accurate date representation.

### 5. Handling Missing and Outlier 'termdate' Values

```sql
UPDATE hr
SET termdate = CASE 
WHEN termdate = '' THEN CURDATE() ELSE date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')) END
WHERE termdate IS NOT NULL;

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

UPDATE hr 
SET termdate = '1000-01-01'
WHERE termdate = '2023-12-03'; 
```

### Description

* Updates missing 'termdate' (termination date) values to the current date.
* Converts string-represented 'termdate' values to the `DATE` format.
* Replaces an outlier '2023-12-03' value, likely intended for far future representation, with '1000-01-01' (a common placeholder date).
