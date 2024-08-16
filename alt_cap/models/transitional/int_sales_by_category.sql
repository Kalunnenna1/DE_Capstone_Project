
{{ config(materialized='table') }}

SELECT
    t.product_category_name_english,
    COUNT(DISTINCT o.order_id) AS order_count,
    SUM(o.price + o.freight_value) AS total_sales
FROM {{ ref('final_stg_orders') }} o
JOIN {{ ref('final_stg_products') }} p
    ON o.product_id = p.product_id
JOIN `alt-school-capstone-project-1.ecommerce_data.product_category_name_translation` t
    ON p.product_category_name = t.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY t.product_category_name_english
ORDER BY total_sales DESC

