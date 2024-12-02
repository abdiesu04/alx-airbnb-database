


-- Index for user_email (to speed up lookups based on email)
CREATE INDEX idx_user_email ON Users(user_email);

-- Index for user_role_id (to speed up lookups based on role)
CREATE INDEX idx_user_role_id ON Users(user_role_id);

-- Index for host_id (to speed up lookups based on host)
CREATE INDEX idx_host_id ON Properties(host_id);

-- Index for property_id in Property_Address (to speed up lookups based on property)
CREATE INDEX idx_property_id_address ON Property_Address(property_id);

-- Index for guest_id (to speed up lookups based on guest)
CREATE INDEX idx_guest_id ON Bookings(guest_id);

-- Index for property_id in Bookings (to speed up lookups based on property)
CREATE INDEX idx_property_id_booking ON Bookings(property_id);

-- Index for booking_id in Payments (to speed up lookups based on booking)
CREATE INDEX idx_booking_id ON Payments(booking_id);

-- Index for property_id in Reviews (to speed up lookups based on property)
CREATE INDEX idx_property_id_review ON Reviews(property_id);

-- Index for guest_id in Reviews (to speed up lookups based on guest)
CREATE INDEX idx_guest_id_review ON Reviews(guest_id);