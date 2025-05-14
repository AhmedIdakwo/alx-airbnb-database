Here are two SQL queries that meet your requirements:

---

### **1. Total number of bookings made by each user**

**(Using `COUNT` and `GROUP BY`)**

```sql
SELECT 
    u.user_id, 
    u.name, 
    COUNT(b.booking_id) AS total_bookings
FROM users u
JOIN bookings b ON u.user_id = b.user_id
GROUP BY u.user_id, u.name
ORDER BY total_bookings DESC;
```

**Explanation**:

* `COUNT(b.booking_id)` calculates the number of bookings per user.
* `GROUP BY` ensures the count is aggregated by each user.
* `ORDER BY` sorts users from most to least bookings.

---

### **2. Rank properties based on the total number of bookings**

**(Using the `RANK()` window function)**

```sql
SELECT 
    p.property_id, 
    p.title, 
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM properties p
LEFT JOIN bookings b ON p.property_id = b.property_id
GROUP BY p.property_id, p.title
ORDER BY booking_rank;
```

**Explanation**:

* `COUNT(b.booking_id)` gives the total bookings per property.
* `RANK() OVER (ORDER BY COUNT(...) DESC)` assigns a rank based on the booking count.
* `LEFT JOIN` ensures properties with zero bookings are still included.

Let me know if you want to filter by date ranges, user segments, or property types!
