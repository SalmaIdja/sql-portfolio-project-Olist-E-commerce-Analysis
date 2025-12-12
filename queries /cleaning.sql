--Remove Duplicate Orders with ROE-NUMBER()

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


--Handle NULL Payments

UPDATE payments
SET payment_value = COALESCE(payment_value, 0);

