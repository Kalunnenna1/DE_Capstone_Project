{{ config(materialized='table') }}

SELECT
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    c.customer_state,
    oi.product_id,
    oi.price,
    oi.freight_value
FROM {{ ref('stg_orders') }} o
LEFT JOIN {{ ref('stg_customers') }} c
ON o.customer_id = c.customer_id
LEFT JOIN {{ ref('stg_order_items') }} oi
ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'