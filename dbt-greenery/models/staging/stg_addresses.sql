{{
  config(
    materialized='table',
    unique_key = 'address_id'
  )
}}

SELECT id
     , address_id as address_guid
     , address 
     , zipcode
     , state
     , country
FROM {{ source('source_public', 'addresses') }}


