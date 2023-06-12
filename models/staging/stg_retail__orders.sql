with sources AS (
    SELECT
        *
    FROM
        {{ source('marts', 'orders') }}
)


renamed AS (
    SELECT
        o_orderkey AS order_id,
        o_custkey AS customer_id,
        o_clerk as clerk_id,
        0_orderstatus AS order_status,
        o_totalprice AS total_price,
        o_orderdate::DATEAS created_at,
        o_orderpriority AS priority,
        o_shippriority as shipping_priority,
        o_comment as comments
    FROM
        sources
)

SELECT
    *
FROM
    renamed
