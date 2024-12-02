 
    -- Create partitioned tables based on start_date
    CREATE TABLE Bookings_2020 (
        booking_id INTEGER PRIMARY KEY,
        start_date DATE,
        end_date DATE,
        guest_id INTEGER,
        property_id INTEGER
    );

    CREATE TABLE Bookings_2021 (
        booking_id INTEGER PRIMARY KEY,
        start_date DATE,
        end_date DATE,
        guest_id INTEGER,
        property_id INTEGER
    );

    -- Insert data into partitioned tables
    INSERT INTO Bookings_2020
    SELECT * FROM Bookings WHERE start_date BETWEEN '2020-01-01' AND '2020-12-31';

    INSERT INTO Bookings_2021
    SELECT * FROM Bookings WHERE start_date BETWEEN '2021-01-01' AND '2021-12-31';

    -- Create indexes on partitioned tables
    CREATE INDEX idx_bookings_2020_guest_id ON Bookings_2020(guest_id);
    CREATE INDEX idx_bookings_2020_property_id ON Bookings_2020(property_id);

    CREATE INDEX idx_bookings_2021_guest_id ON Bookings_2021(guest_id);
    CREATE INDEX idx_bookings_2021_property_id ON Bookings_2021(property_id);

    -- Optimized query on partitioned tables
    SELECT 
        Bookings_2020.booking_id AS booking_id,
        Users.user_id AS user_id,
        Users.user_name AS user_name,
        Properties.property_id AS property_id,
        Properties.name AS property_name,
        Payments.payment_id AS payment_id,
        Payments.amount AS payment_amount
    FROM 
        Bookings_2020
    INNER JOIN 
        Users ON Bookings_2020.guest_id = Users.user_id
    INNER JOIN 
        Properties ON Bookings_2020.property_id = Properties.property_id
    INNER JOIN 
        Payments ON Bookings_2020.booking_id = Payments.booking_id
    WHERE
        Users.user_name LIKE '%john%' AND
        Payments.amount > 100;
