-- Initial query with corrected attribute names based on schema
SELECT 
    Bookings.booking_id AS booking_id,
    Bookings.start_date AS start_date,
    Bookings.end_date AS end_date,
    Users.user_id AS user_id,
    Users.user_name AS user_name,
    Properties.property_id AS property_id,
    Properties.name AS property_name,
    Payments.payment_id AS payment_id,
    Payments.amount AS payment_amount
FROM 
    Bookings
INNER JOIN 
    Users ON Bookings.guest_id = Users.user_id
INNER JOIN 
    Properties ON Bookings.property_id = Properties.property_id
INNER JOIN 
    Payments ON Bookings.booking_id = Payments.booking_id
WHERE
    Users.user_name LIKE '%john%' AND
    Payments.amount > 100;

-- Analyze the query's performance using EXPLAIN
EXPLAIN 
SELECT 
    Bookings.booking_id AS booking_id,
    Users.user_id AS user_id,
    Users.user_name AS user_name,
    Properties.property_id AS property_id,
    Properties.name AS property_name,
    Payments.payment_id AS payment_id,
    Payments.amount AS payment_amount
FROM 
    Bookings
INNER JOIN 
    Users ON Bookings.guest_id = Users.user_id
INNER JOIN 
    Properties ON Bookings.property_id = Properties.property_id
INNER JOIN 
    Payments ON Bookings.booking_id = Payments.booking_id
WHERE
    Users.user_name LIKE '%john%' AND
    Payments.amount > 100;

-- Add indexes to improve query performance
CREATE INDEX idx_bookings_guest_id ON Bookings(guest_id);
CREATE INDEX idx_bookings_property_id ON Bookings(property_id);
CREATE INDEX idx_payments_booking_id ON Payments(booking_id);
CREATE INDEX idx_users_user_name ON Users(user_name);

-- Optimized query after indexing
SELECT 
    Bookings.booking_id AS booking_id,
    Users.user_id AS user_id,
    Users.user_name AS user_name,
    Properties.property_id AS property_id,
    Properties.name AS property_name,
    Payments.payment_id AS payment_id,
    Payments.amount AS payment_amount
FROM 
    Bookings
INNER JOIN 
    Users ON Bookings.guest_id = Users.user_id
INNER JOIN 
    Properties ON Bookings.property_id = Properties.property_id
INNER JOIN 
    Payments ON Bookings.booking_id = Payments.booking_id
WHERE
    Users.user_name LIKE '%john%' AND
    Payments.amount > 100;

   