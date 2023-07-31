{% macro payment_type_desc(type) -%}

    case {{ type }}
        when 'PAYMENT' then 1
        when 'CASH_OUT' then 2
        when 'CASH_IN' then 3
        when 'TRANSFER' then 4
        when 'DEBIT' then 5
    end

{%- endmacro %}