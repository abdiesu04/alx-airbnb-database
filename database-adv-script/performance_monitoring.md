# Performance Monitoring

## Initial Query with Corrected Attribute Names Based on Schema

```sql
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
```

## Analyze the Query's Performance Using EXPLAIN

```sql
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
```

## Add Indexes to Improve Query Performance

```sql
CREATE INDEX idx_bookings_guest_id ON Bookings(guest_id);
CREATE INDEX idx_bookings_property_id ON Bookings(property_id);
CREATE INDEX idx_payments_booking_id ON Payments(booking_id);
CREATE INDEX idx_users_user_name ON Users(user_name);
```

## Optimized Query After Indexing

```sql
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
```

## Monitoring Performance

Use SQL commands like `SHOW PROFILE` or `EXPLAIN ANALYZE` to monitor the performance of a few of your frequently used queries.

## Identifying Bottlenecks and Suggesting Changes

Identify any bottlenecks and suggest changes (e.g., new indexes, schema adjustments).

## Implementing Changes and Reporting Improvements

Implement the changes and report the improvements.