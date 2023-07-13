{{ config(materialized="view") }}

select
    -- identifier
    {{ dbt_utils.surrogate_key(["vendorid", "lpep_pickup_datetime"]) }} as tripid,
    *,
    {{ get_payment_type_description("payment_type") }} as payment_type_description
from {{ source("staging", "green_tripdata_2021_01") }}

{% if var("is_test_run", default=true) %} limit 100 {% endif %}
