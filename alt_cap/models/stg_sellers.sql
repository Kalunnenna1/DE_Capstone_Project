
{{ config(materialized='table') }}

SELECT
    seller_id,
    seller_zip_code_prefix,
    INITCAP(seller_city) AS seller_city,
    seller_state
FROM `alt-school-capstone-project-1.ecommerce_data.olist_sellers`