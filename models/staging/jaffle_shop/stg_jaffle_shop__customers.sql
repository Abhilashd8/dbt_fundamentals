with 

customers as (
    select * from {{ source('jaffle_shop', 'customers') }}
),

transformation as (

select
    id as customer_id,
    first_name as givenname,
    last_name as surname,
    first_name || ' '|| last_name as full_name
from customers
)

select * from transformation
