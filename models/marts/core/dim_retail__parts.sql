{{ config(
    alias = 'dim_parts'
) }}

WITH parts AS (
    SELECT  
        *
    FROM
        {{ ref('stg_retail__parts') }}
)

SELECT
    *
FROM
    parts
