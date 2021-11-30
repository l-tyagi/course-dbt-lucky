{{
  config(
    materialized='table',
    unique_key = 'order_guid'
  )
}}

SELECT od.order_guid
     , user_guid
     , Case when od.promo_id is null then 'N' else 'Y' end as promoflag
     , pr.discount
     , created_at_utc
     , order_cost 
     , shipping_cost
     , order_total_cost
     , shipping_service
     , estimated_delivery_at_utc
     , delivered_at_utc
     , order_status
     ,((DATE_PART('day' , estimated_delivery_at_utc - created_at_utc) * 24)  + 
        (DATE_PART('hour' , estimated_delivery_at_utc - created_at_utc)) +
        (DATE_PART('minute' , estimated_delivery_at_utc - created_at_utc)/60)) as Estimate_Time_to_delivery_HH
     ,((DATE_PART('day' , delivered_at_utc - created_at_utc) * 24)  + 
        (DATE_PART('hour' , delivered_at_utc - created_at_utc)) +
        (DATE_PART('minute' , delivered_at_utc - created_at_utc)/60)) as Time_to_delivery_HH
     ,TotalItems
  FROM dbt_lt_2.stg_orders od 
  LEFT JOIN dbt_lt_2.stg_promos pr
    ON od.promo_id = pr.promo_id
  LEFT JOIN ( SELECT order_guid
                    ,SUM(Quantity) as TotalItems
                FROM dbt_lt_2.stg_order_items
 GROUP BY order_guid) sub
   ON od.order_guid = sub.order_guid
