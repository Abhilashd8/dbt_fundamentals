with paymt_cte as (select * from {{ ref("stg_stripe__payments") }})
select order_id, sum(amount) as total_amt
from paymt_cte
group by order_id
having total_amt < 0
