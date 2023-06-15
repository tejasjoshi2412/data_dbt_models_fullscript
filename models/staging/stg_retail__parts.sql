WITH sources AS (
    SELECT
        *
    FROM
        {{ source('marts','part') }}
),

renamed AS (
    SELECT
        p_partkey AS part_id,
        p_name AS part_name,
        p_mfgr AS manufacturer_name,
        p_brand AS brand_name,
        p_type AS part_type,
        p_size AS part_size,
        p_container AS container,
        p_retailprice AS retail_price,
        p_comment AS comments   
    FROM
        sources
)

SELECT
    *
FROM
    renamed
