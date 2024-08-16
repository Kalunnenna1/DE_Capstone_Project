
{{ config(materialized='table') }}

SELECT
    customer_state,
    COUNT(DISTINCT order_id) AS order_count,
    SUM(price + freight_value) AS total_sales
FROM {{ ref('final_stg_orders') }}
GROUP BY customer_state
ORDER BY order_count DESC
