
{{ config(materialized='table') }}

SELECT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state,
    INITCAP(customer_city) AS customer_city_formatted
FROM `alt-school-capstone-project-1.ecommerce_data.olist_customers`
