{{config(materialized="table")}}

SELECT 
    DISTINCT(id_orig),
    nameOrig,
    oldbalanceOrg,
    newbalanceOrig

FROM {{ref ('stg_onlinepayment')}}