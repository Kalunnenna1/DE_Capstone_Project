
{{ config(materialized='table') }}

SELECT
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date,
    order_delivered_customer_date - order_purchase_timestamp AS delivery_time,
    CASE 
        WHEN order_delivered_customer_date > order_estimated_delivery_date THEN true 
        ELSE false 
    END AS is_delayed,
    order_approved_at - order_purchase_timestamp AS processing_time
FROM `alt-school-capstone-project-1.ecommerce_data.olist_orders`