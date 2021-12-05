{{
  config(
    materialized='view'
  )
}}
SELECT Product_name,
       ROUND((SUM(CASE WHEN event_type='add_to_cart' THEN 1 ElSE 0 END)* 1.0 ) / count(DISTINCT session_guid),2) as ConversionRate
  FROM {{ ref('int_user_events') }}
 WHERE session_guid in (SELECT DISTINCT session_guid 
                          FROM {{ ref('int_user_events') }}
                         WHERE event_type='checkout')
   AND Page_name = 'Product Page'
   GROUP BY Product_name


