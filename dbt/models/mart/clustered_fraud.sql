{{ config(
  materialized = 'table',
  cluster_by = 'isFraud' 
  )
}}

SELECT
    *
FROM
    {{ ref('fact_table') }}