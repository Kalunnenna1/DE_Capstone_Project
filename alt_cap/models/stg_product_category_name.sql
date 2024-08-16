
{{ config(materialized='table') }}

SELECT
    product_category_name,
    product_category_name_english
FROM `alt-school-capstone-project-1.ecommerce_data.product_category_name_translation`