{{
  config(
    materialized='table'
  )
}}

SELECT product_guid
     , product_name
     , price 
     , quantity   
FROM {{ ref('stg_products')}}
 WHERE quantity > 0