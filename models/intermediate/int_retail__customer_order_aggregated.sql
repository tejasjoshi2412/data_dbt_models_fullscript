WITH orders AS (
    SELECT
        *
    FROM
        {{ ref('stg_retail__orders') }}
)

SELECT 
    customer_id,
    MIN(created_at) AS first_order_date,
    MAX(created_at) AS most_recent_order_date,
    COUNT(order_id) AS number_of_orders,
    SUM(total_price) AS lifetime_value,
    ROUND(AVG(total_price),2) AS average_order_value
FROM
    orders
GROUP BY 
    1
