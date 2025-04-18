with

-- Import CTEs

customers as (

  select * from {{ ref('stg_jaffle_shop__customers') }}

),


paid_orders as (
    select * from {{ ref('int_orders') }}
),

-- Final CTE

final as (

  select
    order_id,
    customers.customer_id,
    order_placed_at,
    order_status,
    total_amount_paid,
    payment_finalized_date,
    customers.customer_first_name,
    customers.customer_last_name,

    -- sales transaction sequence
    row_number() over (order by order_id) as transaction_seq,

    -- customer sales sequence
    row_number() over (partition by paid_orders.customer_id order by order_id) as customer_sales_seq,

    -- new vs returning customer
    case  
      when (
      rank() over (
      partition by paid_orders.customer_id
      order by order_placed_at, order_id
      ) = 1
    ) then 'new'
    else 'return' end as nvsr,

    -- customer lifetime value
    sum(total_amount_paid) over (
      partition by paid_orders.customer_id
      order by order_placed_at
      ) as customer_lifetime_value,

    -- first day of sale
    first_value(order_placed_at) over (
      partition by paid_orders.customer_id
      order by order_placed_at
      ) as fdos,
      {{ avg_value }} as dynamic_avg_value

    from paid_orders
	left join customers on paid_orders.customer_id = customers.customer_id
)

-- Simple Select Statement

select * from final {{m_ord_status()}}