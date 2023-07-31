{{ config(
  materialized = 'table',
  cluster_by = 'id_type' 
  )
}}

SELECT
    *
FROM 
    {{ ref('fact_table') }}