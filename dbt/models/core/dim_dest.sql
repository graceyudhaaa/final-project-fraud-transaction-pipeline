{{config(materialized="view")}}

SELECT 
    DISTINCT(id_dest),
    nameDest,
    oldbalanceDest,
    newbalanceDest

FROM {{ref ('stg_onlinepayment')}}