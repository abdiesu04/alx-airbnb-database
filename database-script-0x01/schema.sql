-- 1. Users Table
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

---

-- 2. Roles Table
CREATE TABLE Roles (
    role_id INT PRIMARY KEY,
    role_name ENUM('guest', 'host', 'admin') NOT NULL
);

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
