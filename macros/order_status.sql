{% macro m_ord_status( column_name='order_status', ord_status = "'completed'") -%}

where {{column_name}} = {{ ord_status }}

{%- endmacro %}