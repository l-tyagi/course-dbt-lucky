{{ 
    config(
        materialized='table',
        unique_key = 'session_guid'
    )
}}

SELECT date(event_date_utc) as event_date,
       extract(Hour from event_date_utc) as EventHour,
       session_guid,
       user_guid,
       COUNT(CASE WHEN event_type = 'page_view' then event_guid end) as Page_views,
       COUNT(CASE WHEN event_type = 'add_to_cart' then event_guid end) as Add_to_cart_events,
       COUNT(CASE WHEN event_type = 'delete_from_cart' then event_guid end) as Delete_from_cart_events
  FROM dbt_lt_2.int_user_events
 WHERE event_type in ('page_view','add_to_cart','delete_from_cart')
 GROUP BY date(event_date_utc),
       extract(Hour from event_date_utc),
       session_guid,
       user_guid
