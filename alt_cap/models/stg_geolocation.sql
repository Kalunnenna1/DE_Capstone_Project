{{ config(materialized='table') }}

SELECT
    geolocation_lat,
    geolocation_lng,
    geolocation_zip_code_prefix as customer_zip_code_prefix,
    geolocation_city as customer_city,
    geolocation_state as customer_state,
FROM `alt-school-capstone-project-1.ecommerce_data.olist_geolocation`