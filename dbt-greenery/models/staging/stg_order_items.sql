
{{
  config(
    materialized='table',
    unique_key = 'order_id'
  )
}}

SELECT id 
     , order_id as order_guid
     , product_id as product_guid
     , quantity
FROM {{ source('source_public', 'order_items') }}




