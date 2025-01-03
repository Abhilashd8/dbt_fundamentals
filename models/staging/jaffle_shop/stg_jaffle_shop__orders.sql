{{
    config(
        materialized='view'
    )
}}

with 

orders as (
    select * from {{ source('jaffle_shop', 'orders') }}
),

final as (select
    id as order_id,
    user_id as customer_id,
    order_date as order_placed_at,
    status as order_status,
    current_timestamp() as _etl_loaded_at,
    row_number() over (
    partition by user_id order by order_date, id
    ) as user_order_seq

from orders 
)

select * from final