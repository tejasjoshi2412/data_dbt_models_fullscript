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
        most_recent_order_date,
        CASE
            WHEN number_of_orders = 0 THEN 'Customer Signed-up'
            WHEN number_of_orders = 1 THEN 'First-time Customer'
            ELSE 'Repeat Customer'
        END AS customer_type
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
