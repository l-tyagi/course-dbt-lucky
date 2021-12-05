{{ 
    config(
        materialized='table',
        unique_key = 'session_guid'
    )
}}

SELECT date(event_date_utc) as event_date,
       extract(Hour from event_date_utc) as EventHour,
       session_guid,
       product_name,
       user_guid,
       event_guid
  FROM  {{ ref('int_user_events')}} 
 WHERE event_type = 'page_view'
   AND page_name = ('Product Page')

