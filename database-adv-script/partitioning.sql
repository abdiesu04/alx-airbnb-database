-- Create partitioned table based on start_date
CREATE TABLE Bookings (
    booking_id INTEGER PRIMARY KEY,
    start_date DATE,
    end_date DATE,
    guest_id INTEGER,
    property_id INTEGER
) PARTITION BY RANGE (start_date);

CREATE TABLE Bookings_2020 PARTITION OF Bookings FOR VALUES FROM ('2020-01-01') TO ('2021-01-01');
CREATE TABLE Bookings_2021 PARTITION OF Bookings FOR VALUES FROM ('2021-01-01') TO ('2022-01-01');

-- Create indexes on partitioned tables
CREATE INDEX idx_bookings_2020_guest_id ON Bookings_2020(guest_id);
CREATE INDEX idx_bookings_2020_property_id ON Bookings_2020(property_id);

CREATE INDEX idx_bookings_2021_guest_id ON Bookings_2021(guest_id);
CREATE INDEX idx_bookings_2021_property_id ON Bookings_2021(property_id);

-- Optimized query on partitioned tables
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
