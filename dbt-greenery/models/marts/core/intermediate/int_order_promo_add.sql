{{
  config(
    materialized='table',
    unique_key = 'order_guid'
  )
}}
SELECT order_guid
     , user_guid
     , Case when od.promo_id is null then 'N' else 'Y' end promo_flag
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
  FROM {{ ref('stg_orders') }} od 
  LEFT JOIN {{ ref('stg_promos') }}  pr
    ON od.promo_id = pr.promo_id