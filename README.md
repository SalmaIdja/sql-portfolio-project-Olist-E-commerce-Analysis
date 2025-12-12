# sql-portfolio-project-Olist-E-commerce-Analysis

## 📌 Project Overview
This project uses the **Brazilian E‑Commerce Public Dataset by Olist** (available on Kaggle) to demonstrate SQL data cleaning, analysis, and business insights.  
The dataset contains multiple tables: customers, orders, order_items, products, payments, and sellers.


### Goals
- Clean messy data (missing values, duplicates, inconsistent categories).
- Validate business rules (payments vs orders, shipments vs order dates).
- Generate insights (top categories, customer distribution, sales trends).

---

## 🗂️ Dataset Tables
- **customers** → customer_id, customer_city, customer_state  
- **orders** → order_id, customer_id, order_status, order_purchase_timestamp  
- **order_items** → order_id, product_id, seller_id, price, freight_value  
- **products** → product_id, product_category_name, product_name_length  
- **payments** → order_id, payment_type, payment_value  
- **sellers** → seller_id, seller_city, seller_state

-  📂 Dataset

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



