{{ config(materialized='table') }}

SELECT
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value,
     CASE WHEN payment_installments > 1 THEN true ELSE false END AS is_installment
FROM `alt-school-capstone-project-1.ecommerce_data.olist_order_payments`