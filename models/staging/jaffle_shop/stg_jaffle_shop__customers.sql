select
    id as customer_id,
    first_name,
    REPLACE (last_name,'.','') as last_name

from {{ source('jaffle_shop', 'customers') }}