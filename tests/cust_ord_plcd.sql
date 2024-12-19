with fct_orders_cte as (select * from {{ ref("fct_orders") }})

select customer_id, count(order_id) as totl_ords
from fct_orders_cte
group by 1
having totl_ords > 5
