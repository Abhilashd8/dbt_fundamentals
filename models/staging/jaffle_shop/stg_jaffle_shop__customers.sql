/*==============DBT_STAGE_MODEL================*/

{{
    config (
        materialized = 'table'
    )
}}

with 

customers as (
    select * from {{ source('jaffle_shop', 'customers') }}
),

transformation as (

select
    id as customer_id,
    first_name as customer_first_name,
    last_name as customer_last_name,
    first_name || ' '|| last_name as full_name
from customers
)

select * from transformation
