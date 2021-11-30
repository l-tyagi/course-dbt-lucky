## Questions WEEK 1

### How many users do we have? 
130

```sql
SELECT count(user_guid) as TotalUsers
  FROM dbt_lt_2.stg_users;
```


### On average, how many orders do we receive per hour? 
16 orders/hr

```sql
SELECT ROUND(AVG(orders)) as Average_Orders_per_hr
  FROM (SELECT Extract(Hour from created_at_utc) as createdhours, 
               count(order_guid) as orders 
          FROM dbt_lt_2.stg_orders 
         GROUP BY Extract(Hour from created_at_utc)
        ) sub;
```

### On average, how long does an order take from being placed to being delivered? 
94 hrs approx

```sql
SELECT ROUND(AVG(
       ((DATE_PART('day' , delivered_at_utc - created_at_utc) * 24)  + 
        (DATE_PART('hour' , delivered_at_utc - created_at_utc)) +
        (DATE_PART('minute' , delivered_at_utc - created_at_utc)/60)))) as Avg_OrderLength_Hrs
  FROM dbt_lt_2.stg_orders
 WHERE order_status = 'delivered';
```

### How many users have only made one purchase? Two purchases? Three+ purchases?
1 Purchase = 25
2 Purchases = 22
3+ Purchases = 81

```sql
SELECT Case when sub.nooforders = 1 then '1 Purchase' 
            when sub.nooforders = 2 then '2 Purchases'
            when sub.nooforders > 2 then '3+ Purchases' end as Purchaser_Category,
       Count(distinct sub.user_guid) as TotalUsers
  FROM (
        SELECT user_guid,
               count(order_guid) as nooforders
          FROM dbt_lt_2.stg_orders
         GROUP BY user_guid
       ) sub
 GROUP BY Case when sub.nooforders = 1 then '1 Purchase' 
               when sub.nooforders = 2 then '2 Purchases'
               when sub.nooforders > 2 then '3+ Purchases' end;
```
    

### On average, how many unique sessions do we have per hour? 
121

```sql
SELECT ROUND(AVG(uniqueusr.Unique_Sessions)) as AVG_UniqueSessions
  FROM (SELECT Extract(Hour from created_at_utc) as CreatedHH,
               COUNT(DISTINCT session_guid) as Unique_Sessions
          FROM dbt_lt_2.stg_events 
         GROUP BY Extract(Hour from created_at_utc)
        ) uniqueusr;
```


