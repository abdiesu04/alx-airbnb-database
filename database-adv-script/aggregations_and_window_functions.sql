-- Write a query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.

SELECT guest_id, COUNT(*) AS total_bookings
FROM Bookings
GROUP BY guest_id;



-- Use a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.
SELECT 
    p.property_id,
    p.name,
    COUNT(b.booking_id) AS total_bookings,
    @rank := @rank + 1 AS booking_rank
FROM 
    Properties p
LEFT JOIN 
    Bookings b ON p.property_id = b.property_id
JOIN 
    (SELECT @rank := 0) AS r
GROUP BY 
    p.property_id, p.name
ORDER BY 
    total_bookings DESC;
