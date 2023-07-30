{% macro calculate_diffOrgStatus(diffOrg, amount) -%}

    case
        when {{ diffOrg }} = {{ amount }} then 0
        else 1
    end

{%- endmacro %}