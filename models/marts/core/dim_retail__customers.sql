{{ config(
    alias = 'dim_customers'
) }}

WITH customers AS (
    SELECT  
        *
    FROM
        {{ ref('stg_retail__customers') }}
),

customer_aggregated AS (
    SELECT
        *
    FROM
        {{ ref('int_retail__customer_order_aggregated') }}
),

joined AS (
    SELECT
        customer_id,
        nation_id,
        customer_name,
        customer_address,
        phone_number,
        account_balance,
        marketing_segment,
        number_of_orders,
        lifetime_value,
        average_order_value,
        first_order_date,
        most_recent_order_date
    FROM
        customers
    LEFT JOIN
        customer_aggregated
    USING (customer_ID)
)

SELECT
    *
FROM
    joined
