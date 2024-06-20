SELECT TOP 20 host_id, host_url, host_name, Count(*) AS num_dirty FROM reviews
INNER JOIN listings ON reviews.listing_id = listings.id
WHERE comments LIKE '%dirty%'
GROUP BY host_id,host_url, host_name order by num_dirty desc;