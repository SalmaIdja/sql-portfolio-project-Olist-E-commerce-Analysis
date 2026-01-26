# sql-portfolio-project-Olist-E-commerce-Analysis

##  Project Overview
This project uses the **Brazilian E‑Commerce Public Dataset by Olist** (available on Kaggle) to demonstrate SQL data cleaning, analysis, and business insights.  
The dataset contains multiple tables: customers, orders, order_items, products, payments, and sellers.


### Goals
- Clean messy data (missing values, duplicates, inconsistent categories).
- Validate business rules (payments vs orders, shipments vs order dates).
- Generate insights (top categories, customer distribution, sales trends).

---

##  Dataset Tables
- **customers** → customer_id, customer_city, customer_state  
- **orders** → order_id, customer_id, order_status, order_purchase_timestamp  
- **order_items** → order_id, product_id, seller_id, price, freight_value  
- **products** → product_id, product_category_name, product_name_length  
- **payments** → order_id, payment_type, payment_value  
- **sellers** → seller_id, seller_city, seller_state

-   Dataset

This project uses the **Brazilian E‑Commerce Public Dataset by Olist**, available on Kaggle:

[Brazilian E‑Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

To reproduce this project:
1. Download the dataset from Kaggle using the link above.
2. Load the CSV files into your SQL database (Postgres, MySQL, or SQLite).
3. Run the cleaning and analysis queries provided in this repository.

---
 Data Cleaning

### Standardize Product Categories
```sql
UPDATE products
SET product_category_name = INITCAP(COALESCE(product_category_name, 'Uncategorized'));



Insights
Electronics and related categories generate the highest revenue.
São Paulo and Rio de Janeiro are the top states for customer orders.
Sales peak during holiday months (November–December).
Credit cards are the most common and reliable payment method.


 Portfolio Value
This project demonstrates:
SQL data cleaning (COALESCE, CASE, ROW_NUMBER, INITCAP).
SQL analysis (joins, aggregations, trends).
SQL validation (cross‑table checks).
Business storytelling with SQL insights.

## SQL Validation

-- SQL Validation Script for Olist E-Commerce Dataset
-- ============================================

-- 1. Payment totals must equal order totals
SELECT o.order_id, 
       SUM(oi.price) AS order_total, 
       SUM(p.payment_value) AS payment_total
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY o.order_id
HAVING SUM(oi.price) <> SUM(p.payment_value);

-- 2. Shipment dates must be after purchase dates
SELECT o.order_id, 
       o.order_purchase_timestamp, 
       s.ship_date
FROM orders o
JOIN shipments s ON o.order_id = s.order_id
WHERE s.ship_date < o.order_purchase_timestamp;

-- 3. Delivered orders must have a delivery date
SELECT order_id, order_status, order_delivered_customer_date
FROM orders
WHERE order_status = 'delivered' 
  AND order_delivered_customer_date IS NULL;

-- 4. Cancelled orders should not have payments
SELECT o.order_id, o.order_status, SUM(p.payment_value) AS payment_total
FROM orders o
JOIN payments p ON o.order_id = p.order_id
WHERE o.order_status = 'canceled'
GROUP BY o.order_id, o.order_status
HAVING SUM(p.payment_value) > 0;

-- 5. Freight values must be non-negative
SELECT order_id, freight_value
FROM order_items
WHERE freight_value < 0;

-- 6. Customers must exist for every order
SELECT o.order_id
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- 7. Products must exist for every order item
SELECT oi.order_id, oi.product_id
FROM order_items oi
LEFT JOIN products p ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- 8. Sellers must exist for every order item
SELECT oi.order_id, oi.seller_id
FROM order_items oi
LEFT JOIN sellers s ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL;



