{% macro step_to_timestamp(step) -%}

    TIMESTAMP_ADD(TIMESTAMP "2023-05-01 00:00:00+00", INTERVAL {{ 'step' }} HOUR)

{%- endmacro %}