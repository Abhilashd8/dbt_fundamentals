with customers as (

     select * from {{ ref('stg_jaffle_shop__customers') }}

),

orders as ( 

    select * from {{ ref('fct_orders') }}

),

payments as (
    select * from {{ ref("stg_stripe__payments") }}
),

customer_orders as (

    select
        orders.customer_id,

        min(order_placed_at) as first_order_date,
        max(order_placed_at) as most_recent_order_date,
        count(orders.order_id) as number_of_orders,
        sum(amount) as lifetime_value
    from orders  
    inner join payments as payment using (order_id)

    group by orders.customer_id

),

final as (

    select
        customers.customer_id,
        customers.customer_first_name as first_name,
        customers.customer_last_name as last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce (customer_orders.number_of_orders, 0) 
        as number_of_orders,
        lifetime_value

    from customers

    left join customer_orders using (customer_id)

)

select * from final