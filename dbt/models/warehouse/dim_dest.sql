{{config(materialized="table")}}

SELECT 
    DISTINCT(id_dest),
    nameDest,
    oldbalanceDest,
    newbalanceDest

FROM {{ref ('stg_onlinepayment')}}