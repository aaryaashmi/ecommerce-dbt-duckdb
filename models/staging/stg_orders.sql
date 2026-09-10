with source as (
    select * from {{ ref('raw_orders') }}
)

select
    cast(id as integer) as order_id,
    cast(user_id as integer) as customer_id,
    cast(order_date as date) as order_date,
    lower(status) as order_status
from source