# HR Data Analysis Project Overview

## Project Overview

This project analyzed a [dataset](https://github.com/nkosanamolefe/sql/blob/main/HR/human_resources.csv) of HR employee information spanning from 2000 to 2020, containing over 22,000 records. The primary goal was to gain insights into various aspects of the company's workforce, including demographics, employment trends, and turnover.

* Data Source: [Irene Nafula](https://github.com/Irene-arch/)
* [View data cleaning SQL script](https://github.com/nkosanamolefe/sql/blob/main/HR/HR%20Data%20Cleaning.sql)
* [View data EDA script](https://github.com/nkosanamolefe/sql/blob/main/HR/hr_EDA.ipynb)

## Data Cleaning & Analysis (MySQL Workbench and DataLab)

The raw data was imported into MySQL Workbench for cleaning and into DataLab for analysis.

This involved several key steps:

* Data type conversion: Birthdate, hire date, and term date columns were standardized to the DATE format. Various date formats were handled using str_to_date and date_format.
* Handling missing values: Term dates that were blank were updated to the current date for analysis of active employees.
* Age calculation: An `age`column was calculated using the TIMESTAMPDIFF function based on the birthdate.
* Data Quality: Identified and handled data inconsistencies, such as negative ages (likely data entry errors) and future term dates (which were assumed to be incorrect or for planned future terminations). These were excluded from relevant analyses to avoid skewing results. Specifically, records with ages less than 18 and term dates in the future were filtered out.

## Summary of Findings

The analysis revealed several key insights:

* The company has a higher proportion of male employees.
* The largest employee age group is 35-44, followed by 25-34, with the smallest group being 55-64.
* A significant majority of employees work at the headquarters.
* The average employment length for terminated employees is approximately 8 years.
* Gender distribution is fairly balanced across departments, although a slight male majority exists overall.
* The Auditing department exhibits the highest turnover rate, while Support, Business Development, and Marketing have the lowest.
* Ohio is the state with the largest number of employees.
* The company's employee count has shown a net increase over time.
* Average tenure across departments is around 8 years, with Sales having the highest and Product Management the lowest.