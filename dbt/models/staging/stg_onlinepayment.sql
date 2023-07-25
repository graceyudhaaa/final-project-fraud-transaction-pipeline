{{ config(materialized="view") }}

select 
    id_transaction,
    id_date,
    CAST(dateTransaction AS datetime) AS dateTransaction,
    CAST(amount AS numeric) AS amount,
    type AS transaction_type,
    {{payment_type_desc ('type') }} AS id_type,
    nameOrig AS nameOrig,
    CAST(oldbalanceOrg AS numeric) AS oldbalanceOrg,
    CAST(newbalanceOrig AS numeric) AS newbalanceOrig,
    CAST(isFraud AS integer) AS isFraud,
    CAST(isFlaggedFraud AS integer) AS isFlaggedFraud,
    CAST(DiffOrg AS integer) AS DiffOrg,
    CAST(DiffOrgStatus AS integer) AS DiffOrgStatus,

from {{ source("staging", "online_payment_view") }}