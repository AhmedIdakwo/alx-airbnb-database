Here are the two SQL queries based on your request. Each one leverages a different type of subquery to extract meaningful insights from your data.

---

### 1. **Find all properties where the average rating is greater than 4.0**

**(Using a subquery with `GROUP BY`)**

```sql
SELECT property_id, title
FROM properties
WHERE property_id IN (
    SELECT property_id
    FROM reviews
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
);
```

**Explanation**:

* The inner subquery computes the average rating for each `property_id`.
* The outer query selects properties whose IDs match those with an average rating greater than 4.0.

---

### 2. **Find users who have made more than 3 bookings**

**(Using a correlated subquery)**

```sql
SELECT user_id, name
FROM users u
WHERE (
    SELECT COUNT(*) 
    FROM bookings b 
    WHERE b.user_id = u.user_id
) > 3;
```

**Explanation**:

* The correlated subquery counts how many bookings each user has made.
* The main query filters to return only those users where that count is greater than 3.

