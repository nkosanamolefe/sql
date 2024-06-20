USE airbnb;

SELECT * FROM airbnb..listings
SELECT * FROM airbnb..listings_top_30

-- cleaning price
SELECT TOP 31 
    id, 
    listing_url, 
	neighbourhood_cleansed,
    room_type, beds ,
    30 - availability_30 AS booked_out_30, 
    60 - availability_30 AS booked_out_60, 
    90 - availability_30 AS booked_out_90, 
    365 - availability_30 AS booked_out_365,
    price,
    CAST(REPLACE(REPLACE(price, '$', ''), ',', '') AS FLOAT) AS price_clean,
    CAST(REPLACE(REPLACE(price, '$', ''), ',', '') AS FLOAT) * (30 - availability_30) AS projected_revenue_30,
    CAST(REPLACE(REPLACE(price, '$', ''), ',', '') AS FLOAT) * (60 - availability_60) AS projected_revenue_60,
    CAST(REPLACE(REPLACE(price, '$', ''), ',', '') AS FLOAT) * (90 - availability_90) AS projected_revenue_90,
    CAST(REPLACE(REPLACE(price, '$', ''), ',', '') AS FLOAT) * (365 - availability_365) AS projected_revenue_365
FROM airbnb..listings
ORDER BY projected_revenue_30 DESC;

-- delete rows by id, the row is an outlier 
DELETE FROM airbnb..listings_top_30
WHERE id = 25223720;

-- Location Factors
-- Which neighborhoods or suburbs have the highest-earning Airbnb properties? ward 54 is is situated in the coastal area
SELECT 
    neighbourhood_cleansed, 
    COUNT (*) AS neigbourhood_total
FROM airbnb..listings_top_30
GROUP BY neighbourhood_cleansed
ORDER BY neigbourhood_total DESC;

-- Property Characteristics
-- Is there a relationship between the number of beds/bathrooms and revenue?
SELECT correlation_calculation AS correlation_coefficient
FROM (
    SELECT 
        COUNT(*) AS N,
        SUM(beds * price_clean) AS xy_sum,
        SUM(beds) AS x_sum, 
        SUM(price_clean) as y_sum,
        SUM(beds * beds) AS xx_sum,
        SUM(price_clean * price_clean) AS yy_sum
    FROM airbnb..listings_top_30
    WHERE beds IS NOT NULL and price_clean IS NOT NULL 
) AS temp_table
CROSS APPLY (
    SELECT (xy_sum - x_sum * y_sum / N) /
        (SQRT(xx_sum - x_sum * x_sum / N) * 
         SQRT(yy_sum - y_sum * y_sum / N))
) CA (correlation_calculation);