WITH sources AS (
    SELECT
        *
    FROM
        {{ source('marts', 'orders') }}
),

renamed AS (
    SELECT
        o_orderkey AS order_id,
        o_custkey AS customer_id,
        o_clerk AS clerk_id,
        o_orderstatus AS order_status,
        o_totalprice AS total_price,
        o_orderdate::DATE AS created_at,
        o_orderpriority AS order_priority,
        o_shippriority AS shipping_priority,
        o_comment AS comments
    FROM
        sources
)

SELECT
    *
FROM
    renamed
