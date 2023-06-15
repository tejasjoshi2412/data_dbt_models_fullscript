WITH orders AS (
    SELECT
        *
    FROM
        {{ ref('stg_retail__orders') }}
),

customers AS(   
    SELECT 
        customer_id,
        MIN(created_at) AS first_order_date,
        MAX(created_at) AS most_recent_order_date,
        COALESCE(COUNT(order_id),0) AS number_of_orders,
        COALESCE(SUM(total_price),0) AS lifetime_value,
        COALESCE(ROUND(AVG(total_price),2),0) AS average_order_value
    FROM
        orders
    GROUP BY 
        1
)

SELECT 
    *
FROM
    customers
