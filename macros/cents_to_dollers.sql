{% macro cent_to_doller(column_name,decimal_places ) -%}
round(1.0 * {{column_name}}/100, {{ decimal_places }})
{%- endmacro %}