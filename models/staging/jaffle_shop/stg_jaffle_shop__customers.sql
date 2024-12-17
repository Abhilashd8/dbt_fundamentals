select
    id as customer_id,
    first_name,
    REPLACE (last_name,'.','') as last_name

from raw.jaffle_shop.customers