with customers as (
    select * from {{ ref('stg_customers') }}
),

summary as (
    select * from {{ ref('int_customer_orders_summary') }}
)

select
    c.customer_id,
    c.first_name,
    c.last_name,
    c.first_name || ' ' || c.last_name as full_name,
    c.email,
    s.first_order_date,
    s.most_recent_order_date,
    coalesce(s.number_of_orders, 0) as lifetime_orders,
    coalesce(s.lifetime_value_usd, 0) as lifetime_value_usd
from customers c
left join summary s on c.customer_id = s.customer_id