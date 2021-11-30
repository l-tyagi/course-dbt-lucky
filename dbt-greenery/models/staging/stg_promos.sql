{{
  config(
    materialized='table',
    unique_key = 'promo_id'
  )
}}

SELECT id 
     , promo_id 
     , discout as discount
     , status as promos_status
FROM {{ source('source_public', 'promos') }}