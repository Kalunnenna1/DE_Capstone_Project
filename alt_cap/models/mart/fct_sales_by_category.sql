{{ config(materialized='table') }}
SELECT
    p.product_category_name,
    order_count,
    total_sales
FROM {{ ref('int_sales_by_category') }} o
JOIN {{ ref('final_stg_products') }} p
ON o.product_category_name_english = p.product_category_name