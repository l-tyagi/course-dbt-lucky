{{ 
    config(
        materialized='table',
        unique_key = 'event_guid'
    )
}}
Select ev.user_guid, 
       event_guid, 
       Page_name, 
       CASE WHEN ev.product_guid is not null then pd.product_name end Product_name,
       ev.created_at_utc as event_date_utc,
       event_type ,
       session_guid,
       Case when usr.created_at_utc is not null then 'Registered' Else 'Not Registered'  end  User_Status,
       user_email_domain,
       state,
       country,
       ev.product_guid
  from {{ ref('stg_events')}} ev
  LEFT JOIN {{ ref('stg_products')}} pd
    ON ev.product_guid = pd.product_guid
  LEFT JOIN {{ ref('dim_users')}} usr
    ON ev.user_guid = usr.user_guid
 WHERE ev.created_at_utc is not null
  ORDER BY ev.user_guid,
           event_guid,
           session_guid,
           ev.created_at_utc