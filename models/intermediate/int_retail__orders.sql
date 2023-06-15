WITH line_items AS (
    SELECT
        order_id,
        part_id,
        order_line_number,
        quantity,
        extended_price,
        percent_discount,
        percent_tax,
        return_flag,
        line_status,
        shipped_at,
        delivered_at,
        shipping_instructions,
        shipping_mode
    FROM
        {{ ref('stg_retail__lineitems') }}
),

orders AS (
    SELECT
        order_id,
        customer_id,
        order_status,
        total_price,
        created_at,
        order_priority,
        shipping_priority
    FROM
        {{ ref('stg_retail__orders') }}
),

joined AS (
    SELECT
        *
    FROM
        line_items
    LEFT JOIN
        orders
    USING
        (order_id)
),

enriched AS (
    SELECT
        *,
        extended_price * percent_discount AS discount_price,
        extended_price - discount_price AS subtotal_price,
        subtotal_price * percent_tax AS tax_price,
        subtotal_price + tax_price AS final_price,
        subtotal_price + tax_price + discount_price AS gross_price
    FROM
        joined
),

final AS (
    SELECT
        order_id,
        customer_id,
        total_price,
        order_status,
        order_priority,
        shipping_priority,
        created_at,
        SUM(quantity) AS quantity,
        SUM(discount_price) AS discount_price,
        SUM(subtotal_price) AS subtotal_price,
        SUM(tax_price) AS tax_price,
        SUM(gross_price) AS gross_price
    FROM 
        enriched
    GROUP BY 
        1,2,3,4,5,6,7
)

SELECT
    order_id,
    customer_id,
    quantity,
    subtotal_price,
    discount_price,
    tax_price,
    total_price,
    gross_price,
    order_status,
    order_priority,
    shipping_priority,
    created_at,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_id) AS customer_purchase_rank
FROM
    final
