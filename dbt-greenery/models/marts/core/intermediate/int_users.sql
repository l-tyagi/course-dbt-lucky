{{
  config(
    materialized='table',
    unique_key = 'user_guid'
  )
}}
SELECT user_guid
     , first_name
     , last_name
     , email
     , split_part(email, '@', 2) as user_email_domain
     , created_at_utc
     , extract(day from now() - created_at_utc) as account_age_dd
     , address 
     , state
     , country
  FROM dbt_lt_2.stg_users usr 
  LEFT JOIN {{ ref('stg_addresses') }} adr
    ON usr.address_guid = adr.address_guid