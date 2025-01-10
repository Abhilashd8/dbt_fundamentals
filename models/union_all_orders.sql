--Rerenceing the macro union_tables_by_prefix to combine the multiple tables in schema

{{ union_tables_by_prefix(
    database = 'raw',
    schema = 'dbt_jinja',
    prefix = 'orders_'
) 
}}