with orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select * from {{ ref('stg_payments') }}
),

order_payments as (
    select
        o.customer_id,
        o.order_id,
        o.order_date,
        coalesce(sum(p.amount_usd), 0) as order_total_usd
    from orders o
    left join payments p on o.order_id = p.order_id
    where o.order_status = 'completed'
    group by o.customer_id, o.order_id, o.order_date
)

select
    customer_id,
    min(order_date) as first_order_date,
    max(order_date) as most_recent_order_date,
    count(distinct order_id) as number_of_orders,
    sum(order_total_usd) as lifetime_value_usd
from order_payments
group by customer_id