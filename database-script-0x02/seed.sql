-- 1. Roles Table
CREATE TABLE Roles (
    role_id INT PRIMARY KEY,
    role_name ENUM('guest', 'host', 'admin') NOT NULL
);

-- Insert sample roles data
INSERT INTO Roles (role_id, role_name) VALUES
(1, 'guest'),
(2, 'host'),
(3, 'admin');

---

-- 2. Users Table
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL,
    user_email VARCHAR(255) NOT NULL UNIQUE,
    user_first_name VARCHAR(255),
    user_last_name VARCHAR(255),
    user_phone_number VARCHAR(20),
    user_password_hash VARCHAR(255) NOT NULL,
    user_role_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_role_id) REFERENCES Roles(role_id)
);

-- Index for user_email (to speed up lookups based on email)
CREATE INDEX idx_user_email ON Users(user_email);

-- Insert sample users data
INSERT INTO Users (user_id, user_name, user_email, user_first_name, user_last_name, user_phone_number, user_password_hash, user_role_id) VALUES
(1, 'john_doe', 'john.doe@example.com', 'John', 'Doe', '123-456-7890', 'hashed_password_1', 2),  -- Host
(2, 'jane_smith', 'jane.smith@example.com', 'Jane', 'Smith', '234-567-8901', 'hashed_password_2', 1),  -- Guest
(3, 'admin_user', 'admin@example.com', 'Admin', 'User', '345-678-9012', 'hashed_password_3', 3);  -- Admin

---

-- 3. Properties Table
CREATE TABLE Properties (
    property_id INT PRIMARY KEY,
    host_id INT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    location VARCHAR(255),
    price_per_night DECIMAL(10, 2),
    max_guests INT,
    bedrooms INT,
    bathrooms INT,
    check_in_time TIME,
    check_out_time TIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES Users(user_id)
);

-- Index for location to speed up queries based on location
CREATE INDEX idx_property_location ON Properties(location);

-- Insert sample properties data
INSERT INTO Properties (property_id, host_id, name, description, location, price_per_night, max_guests, bedrooms, bathrooms, check_in_time, check_out_time) VALUES
(1, 1, 'Cozy Mountain Cabin', 'A beautiful cabin in the mountains with great views.', 'Mountain Village', 120.00, 4, 2, 1, '14:00:00', '11:00:00'),
(2, 1, 'Seaside Apartment', 'An apartment right on the beach with stunning ocean views.', 'Sunny Beach', 150.00, 2, 1, 1, '15:00:00', '10:00:00');

---

-- 4. Property Address Table
CREATE TABLE Property_Address (
    address_id INT PRIMARY KEY,
    property_id INT,
    address_line1 VARCHAR(255) NOT NULL,
    address_line2 VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    postal_code VARCHAR(20),
    FOREIGN KEY (property_id) REFERENCES Properties(property_id)
);

-- Insert sample property address data
INSERT INTO Property_Address (address_id, property_id, address_line1, address_line2, city, state, country, postal_code) VALUES
(1, 1, '123 Mountain Road', 'Unit 10', 'Mountain Village', 'Colorado', 'USA', '12345'),
(2, 2, '456 Ocean Drive', 'Apartment 203', 'Sunny Beach', 'California', 'USA', '67890');

---

-- 5. Bookings Table
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    guest_id INT,
    property_id INT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2),
    payment_status ENUM('paid', 'pending', 'cancelled') DEFAULT 'pending',
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_cancelled BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (guest_id) REFERENCES Users(user_id),
    FOREIGN KEY (property_id) REFERENCES Properties(property_id)
);

-- Index for guest_id and property_id to speed up joins
CREATE INDEX idx_guest_property ON Bookings(guest_id, property_id);

-- Insert sample bookings data
INSERT INTO Bookings (booking_id, guest_id, property_id, start_date, end_date, total_price, payment_status, is_cancelled) VALUES
(1, 2, 1, '2024-12-01', '2024-12-05', 480.00, 'pending', FALSE),
(2, 2, 2, '2024-12-10', '2024-12-15', 750.00, 'paid', FALSE);

---

-- 6. Payments Table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    booking_id INT,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method ENUM('credit_card', 'paypal', 'bank_transfer') NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_status ENUM('completed', 'failed', 'pending') NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

-- Insert sample payments data
INSERT INTO Payments (payment_id, booking_id, amount, payment_method, payment_status) VALUES
(1, 2, 750.00, 'credit_card', 'completed'),
(2, 1, 480.00, 'paypal', 'pending');

---

-- 7. Reviews Table
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY,
    property_id INT,
    guest_id INT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    review_comment TEXT,
    review_score DECIMAL(3, 2) CHECK (review_score BETWEEN 1 AND 5),
    is_verified BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (property_id) REFERENCES Properties(property_id),
    FOREIGN KEY (guest_id) REFERENCES Users(user_id)
);

-- Index for property_id and guest_id for faster reviews retrieval
CREATE INDEX idx_property_guest ON Reviews(property_id, guest_id);

-- Insert sample reviews data
INSERT INTO Reviews (review_id, property_id, guest_id, review_comment, review_score, is_verified) VALUES
(1, 1, 2, 'Amazing cabin with great views. Highly recommended!', 5.00, TRUE),
(2, 2, 2, 'Great apartment, right on the beach. Would definitely stay again.', 4.50, TRUE);
