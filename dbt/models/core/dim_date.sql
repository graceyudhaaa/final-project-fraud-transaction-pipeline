{{config(materialized="table")}}

SELECT 
    DISTINCT(id_date),
    dateTransaction

FROM {{ref ('stg_onlinepayment')}}