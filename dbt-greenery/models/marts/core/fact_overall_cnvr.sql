{{
  config(
    materialized='view'
  )
}}

SELECT ROUND((COUNT(DISTINCT Case when event_type = 'checkout' then session_guid end)* 1.0)/ COUNT(DISTINCT session_guid),2) as ConversionRate
  FROM {{ ref('int_user_events') }}