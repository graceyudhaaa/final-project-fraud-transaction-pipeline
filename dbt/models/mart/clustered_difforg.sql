{{ config(
  materialized = 'view',
  partition_by={
    "field": "date",
    "data_type": "timestamp",
    "granularity": "day"},
  cluster_by = 'DiffOrgStatus' 
  )
}}


SELECT
    *
FROM 
    {{ ref('fact_table') }}
WHERE 
    DiffOrgStatus = 1