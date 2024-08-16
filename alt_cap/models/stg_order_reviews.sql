
{{ config(materialized='table') }}

SELECT
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp,
    CASE WHEN review_score >= 4 THEN true ELSE false END AS is_positive_review,
    review_answer_timestamp - review_creation_date AS review_response_time
FROM `alt-school-capstone-project-1.ecommerce_data.olist_order_reviews`