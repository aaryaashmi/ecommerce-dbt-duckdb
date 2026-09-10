{{
  config(
    materialized='incremental',
    unique_key='order_id'
  )
}}

with orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select * from {{ ref('stg_payments') }}
)

select
    o.order_id,
    o.customer_id,
    o.order_date,
    o.order_status,
    coalesce(sum(p.amount_usd), 0) as total_amount_usd
from orders o
left join payments p on o.order_id = p.order_id

{% if is_incremental() %}
  -- Only process orders newer than the most recent order in the existing table
  where o.order_date >= (select coalesce(max(order_date), '1900-01-01') from {{ this }})
{% endif %}

group by o.order_id, o.customer_id, o.order_date, o.order_status