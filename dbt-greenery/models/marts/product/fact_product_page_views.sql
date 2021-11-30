{{ 
    config(
        materialized='table',
        unique_key = 'session_guid'
    )
}}

SELECT date(event_date_utc) as event_date,
       extract(Hour from event_date_utc) as EventHour,
       session_guid,
       page_product,
       user_guid,
       event_guid
  FROM dbt_lt_2.int_user_events
 WHERE event_type = 'page_view'
   AND page_product not in ('Home Page','Search Page','Help Page')
