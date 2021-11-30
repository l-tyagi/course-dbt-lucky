{{
  config(
    materialized='table',
    unique_key = 'order_guid'
  )
}}
SELECT order_guid
     , ord.user_guid
     , user_email_domain
     , state as user_state
     , country as user_country
     , promo_flag
     , discount
     , ord.created_at_utc as Order_Created_at_utc
     , order_cost
     , shipping_cost
     , order_total_cost
     , shipping_service 
     , estimated_delivery_at_utc 
     , delivered_at_utc
     , order_status
     , estimate_time_to_delivery_hh 
     , time_to_delivery_hh
     , account_age_dd
     , totalitems
  FROM {{ ref('int_order_promo_add')}} ord
  LEFT JOIN {{ ref('dim_users')}} usr
    ON ord.user_guid = usr.user_guid
  