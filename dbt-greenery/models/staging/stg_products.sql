{{
  config(
    materialized='table',
    unique_key = 'product_id'
  )
}}

SELECT id 
     , product_id as product_guid
     , name as product_name
     , price 
     , quantity
FROM {{ source('source_public', 'products') }}

