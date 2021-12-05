{{
  config(
    materialized='table',
    unique_key = 'event_id'
  )
}}

SELECT id
     , event_id as event_guid
     , session_id as session_guid
     , user_id as user_guid
     , page_url 
     , replace(page_url,'https://greenary.com/product/','') as product_guid
     ,CASE When page_url like '%browse%' then 'Search Page' 
           When page_url = 'https://greenary.com' then 'Home Page' 
           When page_url = 'https://greenary.com/help' then 'Help Page' 
           When page_url = 'https://greenary.com/shipping' then 'Shipping Page'
           When page_url = 'https://greenary.com/signup' then 'Registration Page'
           When page_url = 'https://greenary.com/checkout' then 'Checkout Page'
           When page_url like 'https://greenary.com/product%' then 'Product Page' Else page_url end Page_name
     , created_at as created_at_utc
     , event_type
FROM {{ source('source_public', 'events') }}


