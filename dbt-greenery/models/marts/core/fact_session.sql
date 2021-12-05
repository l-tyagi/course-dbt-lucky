{{
  config(
    materialized='table'
  )
}}

{% 
  set event_types = ['account_created','page_view','add_to_cart','delete_from_cart','checkout']
%}

select user_guid,
       created_at_utc,
       session_guid {% for event_type in event_types %},
       count(distinct case when event_type = '{{event_type}}' then event_guid end) as {{event_type}}
       {% endfor %}
from {{ ref("stg_events") }}
group by 1, 2, 3