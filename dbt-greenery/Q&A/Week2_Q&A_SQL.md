## Questions WEEK 1

### What is our user repeat rate? 
80%

```sql

SELECT ROUND(COUNT(DISTINCT Case when TotalOrders >= 2 then user_guid end) * 1.0 / COUNT(DISTINCT user_guid),2) as RepeatRate
  FROM (
        SELECT user_guid,
               count(order_guid) as TotalOrders 
          FROM dbt_lt_2.stg_orders us
        GROUP BY user_guid
       ) sub

```

### What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

1. Indicators:
   1.1. Customer retention and repeat rate
   1.2. Product views and reviews
   1.3. Delivery status 
   1.4. User engagement by Page/Products (Less delete from card items/ more conversion rate/ views - purchase by country/region)

2. Additional features/ Data
   2.1. Product review data (Rating/ NPS Survey/ CSAT survey)
   2.2. Improved events data, session start/end and event end date to calculate time spent


### More stakeholders are coming to us for data, which is great! But we need to get some more models created before we can help. Create a marts folder, so we can organize our models, with the following subfolders for business units:
### - Core
### - Marketing
### - Product

#### Within each marts folder, create at least 1-2 intermediate models and 1-2 dimension/fact models. Explain the marts models you added. Why did you organize the models in the way you did?
1. I have created main dimension and order related int table in core directory of data mart which i am using into another buisiness units folders.
2. Every business units contains at least 1 fact and 1 int table
3. Each model in mart based on business unit requirement. e.g. Product working on page and product performance etc

#### Use the dbt docs to visualize your model DAGs to ensure the model layers make sense
dbt-greenery/Q&A/dbt-dag.png
https://github.com/l-tyagi/course-dbt-lucky/blob/main/dbt-greenery/Q%26A/dbt-dag.png

### We added some more models and transformed some data! Now we need to make sure they’re accurately reflecting the data. Add dbt tests into your dbt project on your existing models from Week 1, and new models from the section above

#### What assumptions are you making about each model? (i.e. why are you adding each test?)
1. For each model, i am adding the test to ensure that unique key is not null - Avoid any DAG failure due to missing data
2. Also if exists, ensuring the foreign key is not null either - Avoid any data quality issue in order to create data relationship

#### Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
1. I found about 6 test failure for unique event guid "Test 'test.dbt_greenery.not_null_int_users_events_event_guid.73b5c56b88'"

### Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.
1. Daily test result report, trigger email to Analytics engg team on test status
2. On call support for major failures
