

-- 1. Retrieve all bookings and the respective users who made those bookings using an INNER JOIN:

SELECT 
    Bookings.booking_id, 
    Bookings.guest_id, 
    Users.user_name, 
    Users.user_email, 
    Bookings.property_id, 
    Bookings.start_date, 
    Bookings.end_date, 
    Bookings.total_price
FROM 
    Bookings
INNER JOIN 
    Users 
ON 
    Bookings.guest_id = Users.user_id;



-- 2. Retrieve all properties and their reviews, including properties that have no reviews, using a LEFT JOIN:

SELECT 
    Properties.property_id, 
    Properties.name AS property_name, 
    Reviews.review_id, 
    Reviews.review_comment, 
    Reviews.review_score
FROM 
    Properties
LEFT JOIN 
    Reviews 
ON 
    Properties.property_id = Reviews.property_id;


-- 3. Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user, using a FULL OUTER JOIN:

SELECT 
    Users.user_id, 
    Users.user_name, 
    Bookings.booking_id, 
    Bookings.property_id, 
    Bookings.start_date, 
    Bookings.end_date
FROM 
    Users
FULL OUTER JOIN 
    Bookings 
ON 
    Users.user_id = Bookings.guest_id;
