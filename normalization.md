
---
#### **1. Users Table (Normalized to 3NF)**

```md
| Column Name          | Data Type         | Description                                        |
|----------------------|-------------------|----------------------------------------------------|
| user_id              | INT (PK)          | Unique identifier for the user.                   |
| user_name            | VARCHAR(255)      | Username.                                          |
| user_email           | VARCHAR(255)      | Email address of the user.                        |
| user_first_name      | VARCHAR(255)      | First name of the user.                           |
| user_last_name       | VARCHAR(255)      | Last name of the user.                            |
| user_phone_number    | VARCHAR(20)       | Phone number of the user.                         |
| user_password_hash   | VARCHAR(255)      | Password hash for security.                       |
| user_role_id         | INT (FK)          | Foreign Key to `Roles` table.                     |
| created_at           | TIMESTAMP         | Account creation timestamp.                       |
| updated_at           | TIMESTAMP         | Account last updated timestamp.                   |

**Normalization Steps for Users Table:**
- Moved `user_role` to a new **Roles** table to avoid redundancy.
- Split the address fields into separate tables for better organization and handling.

---

#### **2. Roles Table (Normalized to 3NF)**

```md
| Column Name   | Data Type   | Description                                      |
|---------------|-------------|--------------------------------------------------|
| role_id       | INT (PK)    | Unique identifier for the role.                 |
| role_name     | ENUM        | Role name (guest, host, admin).                  |
```

**Normalization Steps for Roles Table:**
- Created a **Roles** table to store roles, linked by a foreign key in the **Users** table.

---

#### **3. Properties Table (Normalized to 3NF)**

```md
| Column Name          | Data Type         | Description                                        |
|----------------------|-------------------|----------------------------------------------------|
| property_id          | INT (PK)          | Unique identifier for the property.               |
| host_id              | INT (FK)          | Foreign key referencing the `Users` table.        |
| name                 | VARCHAR(255)      | Property name.                                     |
| description          | TEXT              | Description of the property.                      |
| location             | VARCHAR(255)      | General location (e.g., city or region).          |
| price_per_night      | DECIMAL(10,2)     | Price per night for the property.                 |
| max_guests           | INT               | Maximum number of guests allowed.                 |
| bedrooms             | INT               | Number of bedrooms.                               |
| bathrooms            | INT               | Number of bathrooms.                              |
| check_in_time        | TIME              | Check-in time.                                    |
| check_out_time       | TIME              | Check-out time.                                   |
| created_at           | TIMESTAMP         | Property creation timestamp.                      |
| updated_at           | TIMESTAMP         | Property last updated timestamp.                  |

**Normalization Steps for Properties Table:**
- Moved `address` to a separate **Property_Address** table for better organization.
- Removed unnecessary redundancies and dependencies.

---

#### **4. Property Address Table (Normalized to 3NF)**

```md
| Column Name          | Data Type         | Description                                        |
|----------------------|-------------------|----------------------------------------------------|
| address_id           | INT (PK)          | Unique identifier for the address.                |
| property_id          | INT (FK)          | Foreign key referencing the `Properties` table.   |
| address_line1        | VARCHAR(255)      | First line of the address.                        |
| address_line2        | VARCHAR(255)      | Second line of the address (optional).            |
| city                 | VARCHAR(100)      | City of the property.                             |
| state                | VARCHAR(100)      | State of the property.                            |
| country              | VARCHAR(100)      | Country of the property.                          |
| postal_code          | VARCHAR(20)       | Postal code of the property.                      |
```

**Normalization Steps for Property Address Table:**
- Created a separate **Property_Address** table to handle multiple properties with different addresses.

---

#### **5. Bookings Table (Normalized to 3NF)**

```md
| Column Name          | Data Type         | Description                                        |
|----------------------|-------------------|----------------------------------------------------|
| booking_id           | INT (PK)          | Unique identifier for the booking.                |
| guest_id             | INT (FK)          | Foreign key referencing the `Users` table (guest).|
| property_id          | INT (FK)          | Foreign key referencing the `Properties` table.   |
| start_date           | DATE              | Start date of the booking.                        |
| end_date             | DATE              | End date of the booking.                          |
| total_price          | DECIMAL(10,2)     | Total price of the booking.                       |
| payment_status       | ENUM('paid', 'pending', 'cancelled') | Status of the payment.               |
| booking_date         | TIMESTAMP         | Date and time of booking.                         |
| is_cancelled         | BOOLEAN           | Status of the booking (canceled or not).          |

**Normalization Steps for Bookings Table:**
- No normalization needed here as the table only depends on the primary key.

---

#### **6. Payments Table (Normalized to 3NF)**

```md
| Column Name          | Data Type         | Description                                        |
|----------------------|-------------------|----------------------------------------------------|
| payment_id           | INT (PK)          | Unique identifier for the payment.                |
| booking_id           | INT (FK)          | Foreign key referencing the `Bookings` table.     |
| amount               | DECIMAL(10,2)     | Amount paid.                                       |
| payment_method       | ENUM('credit_card', 'paypal', 'bank_transfer') | Payment method.                       |
| payment_date         | TIMESTAMP         | Payment date.                                     |
| payment_status       | ENUM('completed', 'failed', 'pending') | Payment status.                         |
```

**Normalization Steps for Payments Table:**
- No normalization needed here as the table only depends on the primary key.

---

#### **7. Reviews Table (Normalized to 3NF)**

```md
| Column Name          | Data Type         | Description                                        |
|----------------------|-------------------|----------------------------------------------------|
| review_id            | INT (PK)          | Unique identifier for the review.                 |
| property_id          | INT (FK)          | Foreign key referencing the `Properties` table.   |
| guest_id             | INT (FK)          | Foreign key referencing the `Users` table.        |
| review_date          | TIMESTAMP         | Review date.                                      |
| review_comment       | TEXT              | Review comment.                                   |
| review_score         | DECIMAL(3,2)      | Rating score from 1 to 5.                         |
| is_verified          | BOOLEAN           | Whether the review is verified or not.            |
```

**Normalization Steps for Reviews Table:**
- No normalization needed as the table only depends on the primary key.

---

