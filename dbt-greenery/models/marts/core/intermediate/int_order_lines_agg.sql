{{
  config(
    materialized='table',
    unique_key = 'order_guid'
  )
}}
SELECT user_guid
     , Count(od.order_guid) as TotalOrders
     , sum(order_total_cost) as TotalCost
     , ROUND(SUM(TotalItems),2) as TotalItems
  FROM {{ ref('stg_orders') }} od
  LEFT JOIN ( SELECT order_guid
                    ,SUM(Quantity) as TotalItems
                FROM {{ ref('stg_order_items') }} 
               GROUP BY order_guid) sub
    on od.order_guid = sub.order_guid
 Group by user_guid



