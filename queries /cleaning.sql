-- ============================================
-- SQL Cleaning Script for Olist E-Commerce Dataset
-- ============================================

-- 1. Standardize product categories
UPDATE products
SET product_category_name = INITCAP(COALESCE(product_category_name, 'Uncategorized'));

-- 2. Remove duplicate orders using ROW_NUMBER()
DELETE FROM orders
WHERE order_id IN (
    SELECT order_id
    FROM (
        SELECT order_id,
               ROW_NUMBER() OVER (
                 PARTITION BY customer_id, order_purchase_timestamp
                 ORDER BY order_id
               ) AS row_num
        FROM orders
    ) t
    WHERE t.row_num > 1
);

-- 3. Handle NULL payments
UPDATE payments
SET payment_value = COALESCE(payment_value, 0);

-- 4. Standardize order statuses
UPDATE orders
SET order_status = INITCAP(TRIM(order_status));

-- 5. Fix negative or zero quantities in order_items
UPDATE order_items
SET price = ABS(price),
    freight_value = ABS(freight_value)
WHERE price < 0 OR freight_value < 0;

-- 6. Validate foreign keys: remove orders with invalid customers
DELETE FROM orders
WHERE customer_id NOT IN (SELECT customer_id FROM customers);

-- 7. Validate foreign keys: remove order_items with invalid products
DELETE FROM order_items
WHERE product_id NOT IN (SELECT product_id FROM products);

-- 8. Check for mismatched totals (payments vs order_items)
-- (Use this as a diagnostic query, not a delete)
SELECT o.order_id, SUM(oi.price) AS order_total, SUM(p.payment_value) AS payment_total
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY o.order_id
HAVING SUM(oi.price) <> SUM(p.payment_value);

-- 9. Check shipment dates (diagnostic)
SELECT o.order_id, o.order_purchase_timestamp, s.ship_date
FROM orders o
JOIN shipments s ON o.order_id = s.order_id
WHERE s.ship_date < o.order_purchase_timestamp;
