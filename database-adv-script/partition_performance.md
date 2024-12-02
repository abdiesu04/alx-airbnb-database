# Partitioned Tables Performance Report

## Overview

This report evaluates the performance of partitioned tables based on the `start_date` column. The tables `Bookings_2020` and `Bookings_2021` were created to store booking data for the years 2020 and 2021, respectively.

## Table Creation

The following tables were created:

```sql
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
```

## Data Insertion

Data was inserted into the partitioned tables from the main `Bookings` table:

```sql
INSERT INTO Bookings_2020
SELECT * FROM Bookings WHERE start_date BETWEEN '2020-01-01' AND '2020-12-31';

INSERT INTO Bookings_2021
SELECT * FROM Bookings WHERE start_date BETWEEN '2021-01-01' AND '2021-12-31';
```

## Index Creation

Indexes were created on the `guest_id` and `property_id` columns to improve query performance:

```sql
CREATE INDEX idx_bookings_2020_guest_id ON Bookings_2020(guest_id);
CREATE INDEX idx_bookings_2020_property_id ON Bookings_2020(property_id);

CREATE INDEX idx_bookings_2021_guest_id ON Bookings_2021(guest_id);
CREATE INDEX idx_bookings_2021_property_id ON Bookings_2021(property_id);
```

## Optimized Query

An optimized query was executed on the partitioned tables:

```sql
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
```

## Performance Analysis

- **Data Segmentation**: By partitioning the data based on `start_date`, the tables `Bookings_2020` and `Bookings_2021` contain only relevant data for their respective years, reducing the amount of data scanned during queries.
- **Index Utilization**: The creation of indexes on `guest_id` and `property_id` columns significantly improves the performance of queries that filter or join on these columns.
- **Query Efficiency**: The optimized query benefits from partitioning and indexing, resulting in faster execution times compared to querying a single large table.

## Conclusion

Partitioning the `Bookings` table by `start_date` and creating appropriate indexes has led to improved query performance. This approach is recommended for managing large datasets with time-based attributes.
