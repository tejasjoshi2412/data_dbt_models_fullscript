WITH sources AS (
    SELECT
        *
    FROM
        {{ source('marts', 'lineitem') }}
),

renamed AS (
    SELECT
        MD5(l_orderkey || l_linenumber) AS line_item_id,
        l_orderkey AS order_id,
        l_partkey AS part_id,
        l_suppkey AS supplier_id,
        l_linenumber AS order_line_number,
        l_quantity AS quantity,
        l_extendedprice AS extended_price,
        l_discount AS percent_discount,
        l_tax AS percent_tax,
        l_returnflag AS return_flag,
        l_linestatus AS line_status,
        l_shipdate AS shipped_at,
        l_commitdate AS commited_at,
        l_receiptdate AS delivered_at,
        l_shipinstruct AS shipping_instructions,
        l_shipmode AS shipping_mode,
        l_comment AS comments
    FROM
        sources
)

SELECT
    *
FROM
    renamed
