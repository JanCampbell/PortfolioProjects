-- Total Revenue Comparison - compares the total revenue from both Etsy and Shopify orders.
SELECT 'Etsy' AS source, SUM(SalesTotal) AS total_revenue
FROM etsyorders
UNION
SELECT 'Shopify' AS source, SUM(SalesTotal) AS total_revenue
FROM shopifyorders;


-- Average Order Value Comparison - compares the average order value between Etsy and Shopify orders.
SELECT 'Etsy' AS source, AVG(SalesTotal) AS average_order_value
FROM etsyorders
UNION
SELECT 'Shopify' AS source, AVG(SalesTotal) AS average_order_value
FROM shopifyorders;


-- Top Selling Products - combines the top-selling products from both Etsy and Shopify orders.
SELECT platform, ItemName, total_quantity_sold
FROM (
    SELECT 'Etsy' AS platform, ItemName, SUM(Quantity) AS total_quantity_sold
    FROM etsyorders
    GROUP BY ItemName
    ORDER BY total_quantity_sold DESC
    LIMIT 5
) AS etsy
UNION ALL
SELECT platform, ItemName, total_quantity_sold
FROM (
    SELECT 'Shopify' AS platform, ItemName, SUM(Quantity) AS total_quantity_sold
    FROM shopifyorders
    GROUP BY ItemName
    ORDER BY total_quantity_sold DESC
    LIMIT 5
) AS shopify;

-- Customer Demographics Analysis by country - Etsy and Shopify comparison 
SELECT 'Etsy' AS platform, DeliveryCountry, COUNT(*) AS customer_count
FROM etsyorders
GROUP BY platform, DeliveryCountry
UNION ALL
SELECT 'Shopify' AS platform, DeliveryCountry, COUNT(*) AS customer_count
FROM shopifyorders
GROUP BY platform, DeliveryCountry
ORDER BY platform, customer_count DESC;

-- Top 10 UK cities with the highest sales on ETSY in decending order.
SELECT 'Etsy' AS platform, DeliveryCity, SUM(SalesTotal) AS total_sales
FROM etsyorders
WHERE DeliveryCountry = 'United Kingdom'
GROUP BY platform, DeliveryCity
ORDER BY total_sales DESC
LIMIT 10;

-- Top 10 UK cities with the highest sales on Shopify in decending order.
SELECT 'Shopify' AS platform, DeliveryCity, SUM(SalesTotal) AS total_sales
FROM shopifyorders
WHERE DeliveryCountry = 'United Kingdom'
GROUP BY platform, DeliveryCity
ORDER BY total_sales DESC
LIMIT 10;

-- Customer Lifetime Value (CLV)

SELECT platform, OrderID, total_sales
FROM (
    SELECT 'Etsy' AS platform, OrderID, SUM(SalesTotal) AS total_sales
    FROM etsyorders
    GROUP BY platform, OrderID
    UNION ALL
    SELECT 'Shopify' AS platform, OrderID, SUM(SalesTotal) AS total_sales
    FROM shopifyorders
    GROUP BY platform, OrderID
) AS combined_orders
ORDER BY total_sales DESC
LIMIT 5;



