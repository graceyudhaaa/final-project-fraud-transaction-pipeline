{{ config(
  materialized = 'view',
  partition_by={
    "field": "date",
    "data_type": "timestamp",
    "granularity": "day"},
  cluster_by = 'isFraud' 
  )
}}

SELECT
    *
FROM
    {{ ref('fact_table') }}