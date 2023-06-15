WITH sources AS (
    SELECT
        *
    FROM
        {{ source('marts', 'customer') }}
),

renamed AS (
    SELECT
        c_custkey AS customer_id,
        c_nationkey AS nation_id,
        MD5(c_name) AS customer_name,
        c_address AS customer_address,
        MD5(c_phone) AS phone_number,
        c_acctbal AS account_balance,
        c_mktsegment AS marketing_segment,
        c_comment AS comments
    FROM
        sources
)

SELECT
    *
FROM
    renamed
