
{{ config(materialized='table') }}

SELECT
    order_id,
    order_status,
    order_purchase_timestamp,
    order_delivered_customer_date,
    order_estimated_delivery_date,
    TIMESTAMP_DIFF(order_delivered_customer_date, order_purchase_timestamp, DAY) AS delivery_time_days,
    TIMESTAMP_DIFF(order_delivered_customer_date, order_estimated_delivery_date, DAY) AS delay_days
FROM {{ ref('final_stg_orders') }}
WHERE order_status = 'delivered'
AND order_delivered_customer_date IS NOT NULL
