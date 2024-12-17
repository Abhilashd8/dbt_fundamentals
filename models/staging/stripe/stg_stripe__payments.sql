select 
ID as payment_id, 
ORDERID as order_id, 
PAYMENTMETHOD, 
STATUS as status, 
AMOUNT as amount, 
CREATED as created, 
_BATCHED_AT as batched_at from raw.stripe.payment