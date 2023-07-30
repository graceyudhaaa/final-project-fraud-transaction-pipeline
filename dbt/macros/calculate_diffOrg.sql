{% macro calculate_diffOrg(type, newbalanceOrig, oldbalanceOrg) -%}

    case {{ type }}
        when 'CASH_IN' then {{ newbalanceOrig }} - {{ oldbalanceOrg }}
        else {{ oldbalanceOrg }} - {{ newbalanceOrig }}
    end

{%- endmacro %}