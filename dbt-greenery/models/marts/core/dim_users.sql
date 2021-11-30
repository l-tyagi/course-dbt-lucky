{{ 
    config(
        materialized='table'
    )
}}

SELECT usr.user_guid
     , first_name
     , last_name
     , email
     , split_part(email, '@', 2) as user_email_domain
     , created_at_utc
     , extract(day from now() - created_at_utc) as account_age_dd
     , address 
     , state
     , country
     , TotalOrders
     , TotalCost
     , TotalItems
  FROM {{ ref('int_users') }} usr
  LEFT JOIN {{ ref('int_order_lines_agg') }} ol
    ON usr.user_guid = ol.user_guid
