with 
 payments as (
    select * from {{ source('stripe', 'payment') }}
 ),


final as (
select 
ID as payment_id, 
ORDERID as order_id, 
PAYMENTMETHOD as payment_method, 
STATUS as status, 
AMOUNT/100 as amount, 
CREATED as created_at
--_batched_at as _batched_at
from payments
)
select * from final
