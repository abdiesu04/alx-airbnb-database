# Optimization Report

## Initial Query

```sql
SELECT 
    bookings.id AS booking_id,
    users.id AS user_id,
    users.name AS user_name,
    properties.id AS property_id,
    properties.name AS property_name,
    payments.id AS payment_id,
    payments.amount AS payment_amount
FROM 
    bookings
JOIN 
    users ON bookings.user_id = users.id
JOIN 
    properties ON bookings.property_id = properties.id
JOIN 
    payments ON bookings.payment_id = payments.id;
```

## Query Performance Analysis

```sql
EXPLAIN QUERY PLAN
SELECT 
    bookings.id AS booking_id,
    users.id AS user_id,
    users.name AS user_name,
    properties.id AS property_id,
    properties.name AS property_name,
    payments.id AS payment_id,
    payments.amount AS payment_amount
FROM 
    bookings
JOIN 
    users ON bookings.user_id = users.id
JOIN 
    properties ON bookings.property_id = properties.id
JOIN 
    payments ON bookings.payment_id = payments.id;
```

## Optimization Steps

1. **Create Indexes on Foreign Key Columns**

    ```sql
    CREATE INDEX idx_bookings_user_id ON bookings(user_id);
    CREATE INDEX idx_bookings_property_id ON bookings(property_id);
    CREATE INDEX idx_bookings_payment_id ON bookings(payment_id);
    ```

2. **Re-run the Query After Indexing**

    ```sql
    SELECT 
        bookings.id AS booking_id,
        users.id AS user_id,
        users.name AS user_name,
        properties.id AS property_id,
        properties.name AS property_name,
        payments.id AS payment_id,
        payments.amount AS payment_amount
    FROM 
        bookings
    JOIN 
        users ON bookings.user_id = users.id
    JOIN 
        properties ON bookings.property_id = properties.id
    JOIN 
        payments ON bookings.payment_id = payments.id;
    ```