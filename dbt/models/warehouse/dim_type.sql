{{config(materialized="table")}}

SELECT 
    DISTINCT(id_type),
    transaction_type

FROM {{ref ('stg_onlinepayment')}}