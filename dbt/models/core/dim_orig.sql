{{config(materialized="table")}}

SELECT 
    DISTINCT(id_transaction),
    nameOrig,
    oldbalanceOrg,
    newbalanceOrig

FROM {{ref ('stg_onlinepayment')}}