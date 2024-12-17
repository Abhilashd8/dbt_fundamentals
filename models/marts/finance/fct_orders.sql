select cust.customer_id,
ord.order_id,
pay.amount
from 
{{ ref("stg_jaffle_shop__customers") }} as cust
inner join {{ ref("stg_jaffle_shop__orders") }} as ord using (customer_id)
inner join {{ ref("stg_stripe__payments") }}  as pay using (order_id)