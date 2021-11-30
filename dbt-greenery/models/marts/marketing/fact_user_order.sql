{{
  config(
    materialized='table',
    unique_key = 'user_guid'
  )
}}
SELECT us.user_guid,
       first_name,
       last_name,
       state,
       country,
       shipping_service,
       COUNT(DISTINCT order_guid) as TotalOrders,
       SUM(od.TotalItems) as TotalItems,
       SUM(order_total_cost) as Total_OrderCost,
       SUM(order_cost) as Order_Cost,
       SUM(shipping_cost) as shipping_cost,
       COUNT(DISTINCT Case when order_status = 'pending' then order_guid end) as pending_orders,
       COUNT(DISTINCT Case when order_status = 'shipped' then order_guid end) as shipped_orders,
       COUNT(DISTINCT Case when order_status = 'preparing' then order_guid end) as preparing_orders,
       COUNT(DISTINCT Case when order_status = 'delivered' then order_guid end) as delivered_orders,
       AVG(Estimate_Time_to_delivery_HH) as AVG_Estimate_Time_to_delivery_HH,
       AVG(Time_to_delivery_HH) as Time_to_delivery_HH
  FROM dbt_lt_2.dim_users us
  LEFT JOIN dbt_lt_2.int_orders od
    ON us.user_guid = od.user_guid
 GROUP BY us.user_guid,
          first_name,
          last_name,
          state,
          country,
          shipping_service

