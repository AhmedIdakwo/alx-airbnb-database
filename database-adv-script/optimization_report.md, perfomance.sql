Here’s how you can approach the task of **query performance optimization** in steps:

---

## Step 1: Initial Query — `performance.sql`

```sql
-- File: performance.sql

SELECT 
    b.booking_id,
    b.booking_date,
    b.check_in,
    b.check_out,
    u.user_id,
    u.name AS user_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.city,
    pay.payment_id,
    pay.amount,
    pay.status
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
JOIN payments pay ON b.booking_id = pay.booking_id;
```

---

## Step 2: Analyze Query Performance

Run this query using:

```sql
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.booking_date,
    b.check_in,
    b.check_out,
    u.user_id,
    u.name AS user_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.city,
    pay.payment_id,
    pay.amount,
    pay.status
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
JOIN payments pay ON b.booking_id = pay.booking_id;
```

### Common Inefficiencies:

* Sequential Scans instead of Index Scans
* Large joins without filtering
* Unused columns retrieved

---

## Step 3: Refactored Query (Optimized)

Assuming we only need recent bookings and fewer fields:

```sql
-- Refactored Query

SELECT 
    b.booking_id,
    b.check_in,
    b.check_out,
    u.name AS user_name,
    p.name AS property_name,
    pay.amount
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
JOIN payments pay ON b.booking_id = pay.booking_id
WHERE b.booking_date > CURRENT_DATE - INTERVAL '6 months';
```

