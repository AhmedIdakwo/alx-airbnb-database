Here are SQL queries using `INNER JOIN`, `LEFT JOIN`, and `FULL OUTER JOIN` based on your requirements. These queries assume a relational database with the following simplified schema:

* `users(user_id, name, email)`
* `bookings(booking_id, user_id, property_id, start_date, end_date)`
* `properties(property_id, title, location)`
* `reviews(review_id, property_id, user_id, rating, comment)`

---

### 1. **INNER JOIN** – Get all bookings and the respective users who made those bookings

```sql
SELECT 
    bookings.booking_id,
    bookings.start_date,
    bookings.end_date,
    users.user_id,
    users.name,
    users.email
FROM bookings
INNER JOIN users ON bookings.user_id = users.user_id;
```

This returns only bookings that are associated with a valid user.

---

### 2. **LEFT JOIN** – Get all properties and their reviews (including properties without reviews)

```sql
SELECT 
    properties.property_id,
    properties.title,
    reviews.review_id,
    reviews.rating,
    reviews.comment
FROM properties
LEFT JOIN reviews ON properties.property_id = reviews.property_id;
```

This includes all properties, even those with no reviews (those will show `NULL` in the `reviews` fields).

---

### 3. **FULL OUTER JOIN** – Get all users and all bookings, even if not matched

```sql
SELECT 
    users.user_id,
    users.name,
    bookings.booking_id,
    bookings.property_id,
    bookings.start_date
FROM users
FULL OUTER JOIN bookings ON users.user_id = bookings.user_id;
```

This returns:

* All users (even those without bookings),
* All bookings (even those not linked to a user).

