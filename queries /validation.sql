-- ============================================
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
