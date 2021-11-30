{{ 
    config(
        materialized='table',
        unique_key = 'event_guid'
    )
}}
Select ev.user_guid, 
       event_guid, 
       CASE When ev.product_guid like '%browse%' then 'Search Page' 
            When ev.product_guid = 'https://greenary.com' then 'Home Page' 
            When ev.product_guid = 'https://greenary.com/help' then 'Help Page' Else product_name end Page_Product, 
       ev.created_at_utc as event_date_utc,
       event_type ,
       session_guid,
       Case when usr.created_at_utc is not null then 'Registered' Else 'Not Registered'  end  User_Status,
       user_email_domain,
       state,
       country,
       ev.product_guid
  from  dbt_lt_2.stg_events ev
  LEFT JOIN dbt_lt_2.stg_products pd
    ON ev.product_guid = pd.product_guid
  LEFT JOIN dbt_lt_2.dim_users usr
    ON ev.user_guid = usr.user_guid
 WHERE ev.created_at_utc is not null
  ORDER BY ev.user_guid,
           event_guid,
           session_guid,
           ev.created_at_utc

