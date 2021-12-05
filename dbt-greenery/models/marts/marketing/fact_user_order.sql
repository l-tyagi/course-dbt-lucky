{{
  config(
    materialized='table',
    unique_key = 'user_guid'
  )
}}

{% 
  set order_statuss = ['pending','shipped','preparing','delivered']
%}

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
       AVG(Estimate_Time_to_delivery_HH) as AVG_Estimate_Time_to_delivery_HH,
       AVG(Time_to_delivery_HH) as Time_to_delivery_HH,
       order_guid {% for order_status in order_statuss %},
       count(distinct case when order_status = '{{order_status}}' then order_guid end) as {{order_status}}
       {% endfor %}
  FROM {{ ref('dim_users')}} us
  LEFT JOIN {{ ref('int_orders')}} od
    ON us.user_guid = od.user_guid
 GROUP BY us.user_guid,
          first_name,
          last_name,
          state,
          country,
          shipping_service,
          od.order_guid

