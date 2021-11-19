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
     , created_at as created_at_utc
     , event_type
FROM {{ source('source_public', 'events') }}
