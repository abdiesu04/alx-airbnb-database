# README

## SQL Queries

### 1. Retrieve all bookings and the respective users who made those bookings

```sql
SELECT bookings.*, users.*
FROM bookings
INNER JOIN users ON bookings.user_id = users.id;
```

### 2. Retrieve all properties and their reviews, including properties that have no reviews

```sql
SELECT properties.*, reviews.*
FROM properties
LEFT JOIN reviews ON properties.id = reviews.property_id;
```

### 3. Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user

```sql
SELECT users.*, bookings.*
FROM users
FULL OUTER JOIN bookings ON users.id = bookings.user_id;
```