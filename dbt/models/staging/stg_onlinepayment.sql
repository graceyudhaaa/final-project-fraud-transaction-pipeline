{{ config(materialized="view") }}

select 
    md5( dateTransaction || nameOrig || nameDest || type || amount) as id_transaction,
    md5( nameOrig || oldbalanceOrg || newbalanceOrig ) as id_orig,
    md5( nameDest || oldbalanceDest || newbalanceDest ) as id_dest,
    CAST(dateTransaction AS datetime) AS dateTransaction,
    CAST(amount AS numeric) AS amount,
    type AS transaction_type,
    {{payment_type_desc ('type') }} AS id_type,
    nameOrig,
    CAST(oldbalanceOrg AS numeric) AS oldbalanceOrg,
    CAST(newbalanceOrig AS numeric) AS newbalanceOrig,
    nameDest,
    CAST(oldbalanceDest AS numeric) AS oldbalanceDest,
    CAST(newbalanceDest AS numeric) AS newbalanceDest,
    CAST(isFraud AS integer) AS isFraud,
    CAST(isFlaggedFraud AS integer) AS isFlaggedFraud,
    CAST(DiffOrg AS integer) AS DiffOrg,    
    CAST(DiffOrgStatus AS integer) AS DiffOrgStatus,

from {{ source("staging", "external_table") }}