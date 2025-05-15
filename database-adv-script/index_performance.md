Here's a step-by-step breakdown to **identify high-usage columns**, **create indexes**, and **measure performance improvements** using `EXPLAIN` or `ANALYZE`.

---

## Step 1: Identify High-Usage Columns

From typical query usage in the `User`, `Booking`, and `Property` tables:

### Frequently Used Columns:

* **`users.user_id`** – used in JOIN and WHERE clauses.
* **`bookings.user_id`** – JOIN with users.
* **`bookings.property_id`** – JOIN with properties.
* **`properties.property_id`** – JOIN and filter.
* **`bookings.created_at`** – used in filtering and ordering.
* **`properties.city`** – for location-based filtering.

---

## Step 2: Write `CREATE INDEX` Statements

```sql
-- File: database_index.sql

-- Indexes for the users table
CREATE INDEX idx_users_user_id ON users(user_id);

-- Indexes for the bookings table
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_created_at ON bookings(created_at);

-- Indexes for the properties table
CREATE INDEX idx_properties_property_id ON properties(property_id);
CREATE INDEX idx_properties_city ON properties(city);
```

---

## Step 3: Measure Performance with `EXPLAIN` or `ANALYZE`

Before and after creating indexes, run a query like:

```sql
EXPLAIN ANALYZE
SELECT u.name, COUNT(b.booking_id)
FROM users u
JOIN bookings b ON u.user_id = b.user_id
GROUP BY u.name
ORDER BY COUNT(b.booking_id) DESC;
```


