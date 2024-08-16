{{ config(materialized='table') }}

SELECT
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value,
    price + freight_value AS total_value,
    CASE WHEN freight_value = 0 THEN true ELSE false END AS is_free_shipping
FROM `alt-school-capstone-project-1.ecommerce_data.olist_order_items`