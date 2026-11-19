-->KPIS:
USE Olist_Ecommerce;
GO
SELECT 
COUNT(*) AS TOTAL_ORDERS
FROM olist_orders_dataset
GO
SELECT 
SUM(PAYMENT_VALUE) AS TOTAL_REVENUE
FROM olist_order_payments_dataset
GO
SELECT
    COUNT(DISTINCT customer_unique_id) AS Total_Customers
FROM olist_customers_dataset
GO
SELECT
    COUNT(*) AS Total_Products_Sold
FROM olist_order_items_dataset
GO
SELECT
    CAST(SUM(payment_value) AS DECIMAL(18,2))
    /
    NULLIF(COUNT(DISTINCT order_id), 0) AS Average_Order_Value
FROM olist_order_payments_dataset
GO
SELECT
    CAST(COUNT(*) AS DECIMAL(18,2))
    /
    NULLIF(
        (SELECT COUNT(DISTINCT order_id)
         FROM olist_orders_dataset), 0
    ) AS Average_Items_Per_Order
FROM olist_order_items_dataset
GO
SELECT
    SUM(
        CASE
            WHEN order_status = 'delivered' THEN 1
            ELSE 0
        END
    ) AS Delivered_Orders
FROM olist_orders_dataset
GO
SELECT
    SUM(
        CASE
            WHEN order_status = 'canceled' THEN 1
            ELSE 0
        END
    ) AS Canceled_Orders
FROM olist_orders_dataset
GO
SELECT
    YEAR(order_purchase_timestamp) AS Order_Year,
    MONTH(order_purchase_timestamp) AS Order_Month,
    DATENAME(MONTH, order_purchase_timestamp) AS Month_Name,
    COUNT(*) AS Total_Orders
FROM olist_orders_dataset
GROUP BY
    YEAR(order_purchase_timestamp),
    MONTH(order_purchase_timestamp),
    DATENAME(MONTH, order_purchase_timestamp)
ORDER BY
    Order_Year,
    Order_Month
    GO
SELECT
    YEAR(olist_orders_dataset.order_purchase_timestamp) AS Order_Year,
    MONTH(olist_orders_dataset.order_purchase_timestamp) AS Order_Month,
    DATENAME(MONTH, olist_orders_dataset.order_purchase_timestamp) AS Month_Name,
    SUM(olist_order_payments_dataset.payment_value) AS Total_Revenue
FROM olist_orders_dataset
INNER JOIN olist_order_payments_dataset
    ON olist_orders_dataset.order_id =
       olist_order_payments_dataset.order_id
GROUP BY
    YEAR(olist_orders_dataset.order_purchase_timestamp),
    MONTH(olist_orders_dataset.order_purchase_timestamp),
    DATENAME(MONTH, olist_orders_dataset.order_purchase_timestamp)
ORDER BY
    Order_Year,
    Order_Month;
    GO
    SELECT
    order_status,
    COUNT(*) AS Total_Orders
FROM olist_orders_dataset
GROUP BY
    order_status
ORDER BY
    Total_Orders DESC
SELECT TOP 10
    olist_products_dataset.product_category_name,
    COUNT(*) AS Total_Products_Sold,
    SUM(olist_order_items_dataset.price) AS Total_Revenue
FROM olist_order_items_dataset
INNER JOIN olist_products_dataset
    ON olist_order_items_dataset.product_id =
       olist_products_dataset.product_id
GROUP BY
    olist_products_dataset.product_category_name
ORDER BY
    Total_Revenue DESC
    GO
    SELECT TOP 10
    olist_sellers_dataset.seller_id,
    olist_sellers_dataset.seller_city,
    olist_sellers_dataset.seller_state,
    COUNT(*) AS Total_Items_Sold,
    SUM(olist_order_items_dataset.price) AS Total_Revenue
FROM olist_order_items_dataset
INNER JOIN olist_sellers_dataset
    ON olist_order_items_dataset.seller_id =
       olist_sellers_dataset.seller_id
GROUP BY
    olist_sellers_dataset.seller_id,
    olist_sellers_dataset.seller_city,
    olist_sellers_dataset.seller_state
ORDER BY
    Total_Revenue DESC
    GO
SELECT
    olist_customers_dataset.customer_state,
    COUNT(DISTINCT olist_orders_dataset.order_id) AS Total_Orders
FROM olist_orders_dataset
INNER JOIN olist_customers_dataset
    ON olist_orders_dataset.customer_id =
       olist_customers_dataset.customer_id
GROUP BY
    olist_customers_dataset.customer_state
ORDER BY
    Total_Orders DESC
    GO
SELECT
    price,
    freight_value,
    product_id,
    seller_id
FROM olist_order_items_dataset
GO
SELECT
    AVG(DATEDIFF(
        DAY,
        order_purchase_timestamp,
        order_delivered_customer_date
    )) AS Average_Delivery_Days
FROM olist_orders_dataset
WHERE order_delivered_customer_date IS NOT NULL
GO
SELECT
    payment_type,
    COUNT(*) AS Total_Payments,
    SUM(payment_value) AS Total_Revenue
FROM olist_order_payments_dataset
GROUP BY payment_type
ORDER BY Total_Revenue DESC
GO
