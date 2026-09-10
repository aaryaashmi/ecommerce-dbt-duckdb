with source as (
    select * from {{ ref('raw_customers') }}
)

select
    cast(id as integer) as customer_id,
    trim(first_name) as first_name,
    trim(last_name) as last_name,
    lower(trim(email)) as email
from source