-- Create schema
CREATE SCHEMA IF NOT EXISTS CAPSTONE_PROJECT;

-- Create the schema if it doesn't already exist
CREATE SCHEMA IF NOT EXISTS CAPSTONE_PROJECT;

-- Create the table within the schema
CREATE TABLE IF NOT EXISTS CAPSTONE_PROJECT.OLIST_CUSTOMERS (
    customer_id UUID PRIMARY KEY,
    customer_unique_id UUID NOT NULL,
    customer_zip_code_prefix VARCHAR NOT NULL,
    customer_city VARCHAR NOT NULL,
    customer_state VARCHAR(2) NOT NULL
);

-- Populate the table with data from a CSV file
COPY CAPSTONE_PROJECT.OLIST_CUSTOMERS (customer_id, customer_unique_id, customer_zip_code_prefix, customer_city, customer_state)
FROM '/data/olist_customers_dataset.csv' DELIMITER ',' CSV HEADER;

-- DDL statment to create this table CAPSTONE_PROJECT.GEOLOCATION

-- Create the table within the schema
CREATE TABLE IF NOT EXISTS CAPSTONE_PROJECT.OLIST_GEOLOCATION 
(
    geolocation_zip_code_prefix VARCHAR NOT NULL,
    geolocation_lat DECIMAL(18, 15) NOT NULL,
    geolocation_lng DECIMAL(18, 15) NOT NULL,
    geolocation_city VARCHAR NOT NULL,
    geolocation_state VARCHAR(2) NOT NULL,
    PRIMARY KEY (geolocation_zip_code_prefix, geolocation_lat, geolocation_lng)
);

-- Create a temporary staging table
CREATE TEMP TABLE staging_olist_geolocation (
    geolocation_zip_code_prefix VARCHAR,
    geolocation_lat DECIMAL(18, 15),
    geolocation_lng DECIMAL(18, 15),
    geolocation_city VARCHAR,
    geolocation_state VARCHAR(2)
);

-- Copy data from the CSV file into the staging table
COPY staging_olist_geolocation (geolocation_zip_code_prefix, geolocation_lat, geolocation_lng, geolocation_city, geolocation_state)
FROM '/data/olist_geolocation_dataset.csv' DELIMITER ',' CSV HEADER;

-- Insert data from the staging table into the final table with conflict handling
INSERT INTO CAPSTONE_PROJECT.OLIST_GEOLOCATION (geolocation_zip_code_prefix, geolocation_lat, geolocation_lng,
geolocation_city, geolocation_state)
SELECT
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state
FROM
    staging_olist_geolocation
ON CONFLICT (geolocation_zip_code_prefix, geolocation_lat, geolocation_lng)
DO NOTHING;

-- Drop the staging table
DROP TABLE staging_olist_geolocation;

CREATE TABLE IF NOT EXISTS CAPSTONE_PROJECT.OLIST_ORDER_ITEMS 
(
    order_id UUID NOT NULL,
    order_item_id INT NOT NULL,
    product_id UUID NOT NULL,
    seller_id UUID NOT NULL,
    shipping_limit_date TIMESTAMP,
    price DECIMAL(10,2) NOT NULL,
    freight_value DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, order_item_id)
);

COPY CAPSTONE_PROJECT.OLIST_ORDER_ITEMS (order_id, order_item_id, product_id, seller_id, shipping_limit_date, price, freight_value)
FROM '/data/olist_order_items_dataset.csv' DELIMITER ',' CSV HEADER;

--  /data folder into ALT_SCHOOL.CUSTOMERS

CREATE TABLE IF NOT EXISTS CAPSTONE_PROJECT.OLIST_ORDER_PAYMENTS 
(
    order_id UUID NOT NULL,
    payment_sequential INT NOT NULL,
    payment_type VARCHAR NOT NULL,
    payment_installments INT NOT NULL,
    payment_value DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, payment_sequential)
);

COPY CAPSTONE_PROJECT.OLIST_ORDER_PAYMENTS (order_id, payment_sequential, payment_type, payment_installments, payment_value)
FROM '/data/olist_order_payments_dataset.csv' DELIMITER ',' CSV HEADER;

-- order_reviews
-- Create the schema if it doesn't exist
CREATE SCHEMA IF NOT EXISTS CAPSTONE_PROJECT;

-- Create the table if it doesn't exist
CREATE TABLE IF NOT EXISTS CAPSTONE_PROJECT.OLIST_ORDER_REVIEWS (
    review_id UUID NOT NULL,
    order_id UUID NOT NULL,
    review_score SMALLINT NOT NULL,
    review_comment_title VARCHAR(255),
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);

-- Copy data from the CSV file into the table
COPY CAPSTONE_PROJECT.OLIST_ORDER_REVIEWS (
    review_id, 
    order_id, 
    review_score, 
    review_comment_title,
    review_comment_message, 
    review_creation_date, 
    review_answer_timestamp
) 
FROM '/data/olist_order_reviews_dataset.csv' 
DELIMITER ',' 
CSV HEADER;


CREATE TABLE IF NOT EXISTS CAPSTONE_PROJECT.OLIST_ORDERS
(
    order_id UUID PRIMARY KEY,
    customer_id UUID NOT NULL,
    order_status VARCHAR(15),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

COPY CAPSTONE_PROJECT.OLIST_ORDERS (order_id, customer_id, order_status, order_purchase_timestamp, order_approved_at, order_delivered_carrier_date, order_delivered_customer_date, order_estimated_delivery_date)
FROM '/data/olist_orders_dataset.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE IF NOT EXISTS CAPSTONE_PROJECT.OLIST_PRODUCTS
(
    product_id UUID PRIMARY KEY,
    product_category_name VARCHAR(50),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g DECIMAL(10, 2),
    product_length_cm DECIMAL(10, 2),
    product_height_cm DECIMAL(10, 2),
    product_width_cm DECIMAL(10, 2)
);

COPY CAPSTONE_PROJECT.OLIST_PRODUCTS (product_id, product_category_name, product_name_lenght, product_description_lenght, product_photos_qty, product_weight_g, product_length_cm, product_height_cm, product_width_cm)
FROM '/data/olist_products_dataset.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE IF NOT EXISTS CAPSTONE_PROJECT.OLIST_SELLERS 
(
    seller_id UUID PRIMARY KEY,
    seller_zip_code_prefix VARCHAR(5) NOT NULL,
    seller_city VARCHAR(255),
    seller_state VARCHAR(2)
);

COPY CAPSTONE_PROJECT.OLIST_SELLERS (seller_id, seller_zip_code_prefix, seller_city, seller_state)
FROM '/data/olist_sellers_dataset.csv' DELIMITER ',' CSV HEADER;


CREATE TABLE IF NOT EXISTS CAPSTONE_PROJECT.PRODUCT_CATEGORY_NAME_TRANSLATION
(
    product_category_name VARCHAR(255),
    product_category_name_english VARCHAR(255)
);

COPY CAPSTONE_PROJECT.PRODUCT_CATEGORY_NAME_TRANSLATION (product_category_name, product_category_name_english)
FROM '/data/product_category_name_translation.csv' DELIMITER ',' CSV HEADER;
