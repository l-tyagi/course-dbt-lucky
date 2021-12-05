## Questions WEEK 1

### What is our overall conversion rate? 
35%

```sql

-- Code can be found in: dbt-greenery/models/marts/core/fact_overall_cnvr.sql

```


### What is our conversion rate by product?

```sql

-- Code can be found in: dbt-greenery/models/marts/core/fact_cnvr_by_products.sql

    product_name     | conversionrate 
---------------------+----------------
 Alocasia Polly      |           0.61
 Aloe Vera           |           0.48
 Angel Wings Begonia |           0.63
 Arrow Head          |           0.49
 Bamboo              |           0.48
 Bird of Paradise    |           0.68
 Birds Nest Fern     |           0.60
 Boston Fern         |           0.57
 Cactus              |           0.52
 Calathea Makoyana   |           0.62
 Devil's Ivy         |           0.38
 Dragon Tree         |           0.56
 Ficus               |           0.52
 Fiddle Leaf Fig     |           0.59
 Jade Plant          |           0.48
 Majesty Palm        |           0.59
 Money Tree          |           0.47
 Monstera            |           0.58
 Orchid              |           0.57
 Peace Lily          |           0.55
 Philodendron        |           0.58
 Pilea Peperomioides |           0.45
 Pink Anthurium      |           0.58
 Ponytail Palm       |           0.48
 Pothos              |           0.50
 Rubber Plant        |           0.52
 Snake Plant         |           0.56
 Spider Plant        |           0.54
 String of pearls    |           0.57
 ZZ Plant            |           0.58


```


### Create a macro to simplify part of a model(s)

```sql

version: 2

macros:
  - name: grant_select_usage
    description: Apply grants select and usage to a specific role
    docs:
      show: true
    arguments:
      - name: schemas
        type: str
        description: Name of the schema
      - name: role
        type: str
        description: Name of the role

'''

### After learning about dbt packages, we want to try one out and apply some macros or tests.

Added to the packages.yml