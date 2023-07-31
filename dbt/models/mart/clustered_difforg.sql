{{ config(
  materialized = 'table',
  cluster_by = 'DiffOrgStatus' 
  )
}}


SELECT
    *
FROM 
    {{ ref('fact_table') }}