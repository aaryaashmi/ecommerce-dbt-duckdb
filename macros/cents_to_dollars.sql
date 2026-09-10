{% macro cents_to_dollars(column_name, decimal_places=2) -%}
    round(cast({{ column_name }} as numeric) / 100, {{ decimal_places }})
{%- endmacro %}