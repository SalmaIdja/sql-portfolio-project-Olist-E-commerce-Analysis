# 📈 Insights Report: Olist E‑Commerce SQL Project

## 1. Data Cleaning Outcomes
- Standardized **product categories** (no more NULLs or inconsistent casing).
- Removed **duplicate orders** using `ROW_NUMBER()`.
- Fixed **NULL payments** by replacing with 0.
- Corrected **negative prices and freight values**.
- Ensured **foreign key integrity** (all orders have valid customers, products, and sellers).

---

## 2. Analysis Highlights
- **Revenue Drivers**  
  Electronics and related categories generate the highest revenue across the dataset.

- **Customer Distribution**  
  São Paulo and Rio de Janeiro are the top states for customer orders, showing strong regional demand.

- **Monthly Sales Trends**  
  Sales peak during holiday months (November–December), with noticeable dips in off‑season months.

- **Top Sellers**  
  A small group of sellers accounts for a large share of revenue, indicating concentration of supply.

- **Payment Methods**  
  Credit cards dominate transactions, followed by boleto (Brazilian bank slip), with debit and vouchers trailing.

- **Customer Retention**  
  Repeat buyers represent ~20% of customers, highlighting opportunities for loyalty programs.

- **Freight Costs**  
  Average freight costs vary significantly by state, with northern regions showing higher shipping expenses.

---

## 3. Validation Checks
- **Payment vs Order Totals**  
  ~5% of orders had mismatched totals, requiring reconciliation.

- **Shipment Dates**  
  A small number of shipments were logged before purchase dates — likely data entry errors.

- **Delivered Orders**  
  Some delivered orders lacked delivery timestamps, suggesting incomplete tracking.

- **Cancelled Orders**  
  A few cancelled orders still had payments recorded, indicating refund issues.

---

## 4. Business Insights
- Focus marketing on **high‑revenue categories** (electronics, computers, phones).  
- Expand logistics support in **high‑freight regions** to reduce costs.  
- Strengthen **customer loyalty programs** to increase repeat purchases.  
- Improve **data quality controls** around payments and shipments to ensure accuracy.  

---

## 5. Portfolio Value
This project demonstrates:
- SQL **data cleaning** (COALESCE, CASE, ROW_NUMBER, INITCAP).  
- SQL **analysis** (joins, aggregations, trends).  
- SQL **validation** (cross‑table checks).  
- Ability to turn raw data into **business insights**.  

---
