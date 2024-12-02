-- Initial query to retrieve all bookings along with user details, property details, and payment details
SELECT 
    Bookings.id AS booking_id,
    Users.id AS user_id,
    Users.name AS user_name,
    Properties.id AS property_id,
    Properties.name AS property_name,
    Payments.id AS payment_id,
    Payments.amount AS payment_amount
FROM 
    Bookings
JOIN 
    Users ON Bookings.user_id = Users.id
JOIN 
    Properties ON Bookings.property_id = Properties.id
JOIN 
    Payments ON Bookings.payment_id = Payments.id
WHERE
    Users.name LIKE '%John%' AND
    Payments.amount > 100;

-- Analyze the query's performance
EXPLAIN QUERY PLAN
SELECT 
    Bookings.id AS booking_id,
    Users.id AS user_id,
    Users.name AS user_name,
    Properties.id AS property_id,
    Properties.name AS property_name,
    Payments.id AS payment_id,
    Payments.amount AS payment_amount
FROM 
    Bookings
JOIN 
    Users ON Bookings.user_id = Users.id
JOIN 
    Properties ON Bookings.property_id = Properties.id
JOIN 
    Payments ON Bookings.payment_id = Payments.id
WHERE
    Users.name LIKE '%John%' AND
    Payments.amount > 100;

-- Refactor the query to reduce execution time
-- Ensure indexes are created on the foreign key columns
CREATE INDEX idx_bookings_user_id ON Bookings(user_id);
CREATE INDEX idx_bookings_property_id ON Bookings(property_id);
CREATE INDEX idx_bookings_payment_id ON Bookings(payment_id);

-- Re-run the query after indexing
SELECT 
    Bookings.id AS booking_id,
    Users.id AS user_id,
    Users.name AS user_name,
    Properties.id AS property_id,
    Properties.name AS property_name,
    Payments.id AS payment_id,
    Payments.amount AS payment_amount
FROM 
    Bookings
JOIN 
    Users ON Bookings.user_id = Users.id
JOIN 
    Properties ON Bookings.property_id = Properties.id
JOIN 
    Payments ON Bookings.payment_id = Payments.id
WHERE
    Users.name LIKE '%John%' AND
    Payments.amount > 100;