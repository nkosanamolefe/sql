# Cape Town Airbnb Insights

### Project Overview

This project aims to analyze Airbnb data from Cape Town, South Africa, to gain valuable insights into the market and identify business opportunities. 

The key analysis questions are:
1. How much are the top AirBnB earners making in Cape Town?
2. Potential customer list for AirBnB cleaning business?

The [data](http://insideairbnb.com/get-the-data/) is divided into 3 tables:
* **calender** has +786k records and 7 fields
* **listings** has 20k records and 75 fields
* **reviews** has +500k records and 6 fields

### Data Cleaning

* #### Airbnb Listings

    The following SQL query removes dollar signs and commas from a 'price' string and converts the result into a floating-point number for clean numerical calculations.

    ```sql
    CAST(REPLACE(REPLACE(price, '$', ''), ',', '') AS FLOAT) AS price_clean,
    CAST(REPLACE(REPLACE(price, '$', ''), ',', '') AS FLOAT) * (30 - availability_30) AS projected_revenue_30
    ```

    Which will allow us to calculate the project revenue for 30, 60, 90, and 365 days.

    Projected Revenue = Nightly Price x Nights Booked

* #### Airbnb Reviews
  
  This query identifies the top 20 Airbnb hosts with the most reviews mentioning "dirty", and the count of such reviews.

  ```sql
    SELECT TOP 20 host_id, host_url, host_name, Count(*) AS num_dirty FROM reviews
    INNER JOIN listings ON reviews.listing_id = listings.id
    WHERE comments LIKE '%dirty%'
    GROUP BY host_id,host_url, host_name order by num_dirty desc;
    ```

### Findings

#### 1. How much are the top AirBnB earners making in Cape Town?

* **Pricing of Top Earners:** The top 30 earners on Airbnb in Cape Town command an average nightly rate of R120,972.97

* **Revenue Potential:** Based on current trends, the top 30 Airbnb earners are projected to generate an average revenue of R3,027,817.43

* **Concentration by Location:** The analysis indicates a concentration of top-earning listings in specific areas. Ward 54 leads with 23 listings within the top 30 earners

#### 2. Potential customer list for AirBnB cleaning business?

* **Potential customer list:**The top 20 selected listings have an average of 9 reviews containing the word "dirty". This indicates a potential market demand for high-quality cleaning services among Airbnb hosts in Cape Town, who may be willing to outsource cleaning to maintain positive reviews and guest satisfaction.
