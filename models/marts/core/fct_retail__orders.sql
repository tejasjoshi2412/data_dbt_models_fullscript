{{ config(
    alias = 'fct_orders'
) }}

WITH orders AS (
    SELECT  
        *
    FROM
        {{ ref('int_retail__orders') }}
)

SELECT
    *
FROM
    orders
