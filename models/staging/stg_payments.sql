with source as (
    select * from {{ ref('raw_payments') }}
)

select
    cast(id as integer) as payment_id,
    cast(order_id as integer) as order_id,
    lower(payment_method) as payment_method,
    {{ cents_to_dollars('amount_cents') }} as amount_usd,
    cast(created_at as timestamp) as payment_created_at
from source