create database sales_db;
use sales_db;

CREATE TABLE sales (
transaction_id VARCHAR(50) PRIMARY KEY,
customer_id VARCHAR(50),
customer_name VARCHAR(50),
customer_age INT,
gender VARCHAR(50),
product_id VARCHAR(50),
product_name TEXT,
product_category TEXT,
quantity INT,
price INT,
payment_mode VARCHAR(50),
purchase_date DATE,
time_of_purchase TIME,
status VARCHAR(50)
)
