-- Write a query to find all properties where the average rating is greater than 4.0 using a subquery.

SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night
FROM 
    Properties p
WHERE 
    (SELECT AVG(r.review_score)
     FROM Reviews r
     WHERE r.property_id = p.property_id
    ) > 4.0;


-- Write a correlated subquery to find users who have made more than 3 bookings.

SELECT user_id, user_name, user_email
FROM Users
WHERE user_id IN (
    SELECT guest_id
    FROM Bookings
    GROUP BY guest_id
    HAVING COUNT(*) > 3
);
