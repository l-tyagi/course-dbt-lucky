
Q1 - How many users do we have?
A1 - 130

Q1 - SQL 
---------------------------------------------------------------------------------------------------
SELECT count(user_guid) as TotalUsers
  FROM dbt_lt_2.stg_users;

--==================================================================================================

Q2 - On average, how many orders do we receive per hour? 
A2 - 16 orders/hr

Q2 - SQL 
---------------------------------------------------------------------------------------------------
SELECT ROUND(AVG(orders)) as Average_Orders_per_hr
  FROM (SELECT Extract(Hour from created_at_utc) as createdhours, 
               count(order_guid) as orders 
          FROM dbt_lt_2.stg_orders 
         GROUP BY Extract(Hour from created_at_utc)
        ) sub;

--==================================================================================================

Q3 - On average, how long does an order take from being placed to being delivered? 
A3 - 94 hrs

Q3 - SQL 
---------------------------------------------------------------------------------------------------
SELECT ROUND(AVG(
       ((DATE_PART('day' , delivered_at_utc - created_at_utc) * 24)  + 
        (DATE_PART('hour' , delivered_at_utc - created_at_utc)) +
        (DATE_PART('minute' , delivered_at_utc - created_at_utc)/60)))) as Avg_OrderLength_Hrs
  FROM dbt_lt_2.stg_orders
 WHERE order_status = 'delivered';

--==================================================================================================

Q4 - How many users have only made one purchase? Two purchases? Three+ purchases? 
A4 - 1 Purchase = 25
     2 Purchases = 22
     3+ Purchases = 81

Q4 - SQL 
---------------------------------------------------------------------------------------------------
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

--==================================================================================================

Q5 - On average, how many unique sessions do we have per hour?
A5 - 121

Q5 - SQL 
---------------------------------------------------------------------------------------------------
SELECT ROUND(AVG(uniqueusr.Unique_Sessions)) as AVG_UniqueSessions
  FROM (SELECT Extract(Hour from created_at_utc) as CreatedHH,
               COUNT(DISTINCT session_guid) as Unique_Sessions
          FROM dbt_lt_2.stg_events 
         GROUP BY Extract(Hour from created_at_utc)
        ) uniqueusr;

--==================================================================================================

