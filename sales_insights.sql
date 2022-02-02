
USE SALES;
SELECT 
    *
FROM
    CUSTOMERS;
SELECT 
    *
FROM
    DATE;
SELECT 
    *
FROM
    MARKETS;
SELECT 
    *
FROM
    PRODUCTS;
SELECT 
    *
FROM
    TRANSACTIONS;
-- DATA EXPLORATION --
-- Top 5 products with hightest sales amount--
SELECT 
    PRODUCT_CODE, SUM(SALES_AMOUNT) AS product_sales_amount
FROM
    transactions
GROUP BY product_code
ORDER BY sales_amount DESC
LIMIT 5;

-- Customer who gave highest sales-- top 10 --
SELECT 
    c.custmer_name, SUM(t.sales_amount) AS total_sales_amount
FROM
    transactions t
        LEFT JOIN
    customers c ON t.customer_code = c.customer_code
GROUP BY c.custmer_name
ORDER BY t.sales_amount DESC
LIMIT 10;

-- Top 5 products with hightest sales amount and zone (To evaluate zone-wise performance) --

SELECT 
    t.PRODUCT_CODE,
    SUM(t.SALES_AMOUNT) AS product_sales_amount,
    m.zone
FROM
    transactions t
        JOIN
    markets m ON m.markets_code = t.market_code
GROUP BY product_code
ORDER BY sales_amount DESC
LIMIT 5;


-- Count the product code based on the product type
SELECT 
    COUNT(product_code) AS total_products, product_type
FROM
    products
GROUP BY product_type;
    
    -- [product type]--  highest sales in which markets?
    
SELECT 
    p.product_type,
    m.markets_name,
    SUM(t.sales_amount) AS total_sales
FROM
    transactions t
        JOIN
    products p ON t.product_code = p.product_code
        JOIN
    markets m ON t.market_code = m.markets_code
GROUP BY p.product_type
ORDER BY t.sales_amount DESC;
    
    -- Zone wise sales --
SELECT 
    m.zone, SUM(t.sales_amount)
FROM
    transactions t
        JOIN
    markets m ON m.markets_code = t.market_code
GROUP BY m.zone
ORDER BY t.sales_amount;
    
    -- city-wise sales--
SELECT 
    m.markets_name, SUM(t.sales_amount)
FROM
    transactions t
        JOIN
    markets m ON m.markets_code = t.market_code
GROUP BY m.markets_name
ORDER BY t.sales_amount DESC;
    
    -- most sold product -- top 10
SELECT 
    product_code, COUNT(product_code) AS total_sales
FROM
    transactions
GROUP BY product_code
ORDER BY COUNT(product_code) DESC
LIMIT 10;
    
-- total sales for year 2020 --

SELECT 
    SUM(t.sales_amount) total_sales_for_2020
FROM
    transactions t
        JOIN
    date d ON d.date = t.order_date
WHERE
    d.year = '2020';
    
    -- sales month-wise --
SELECT 
    MONTHNAME(t.order_date) AS month,
    SUM(t.sales_amount) AS total_sales
FROM
    transactions t
GROUP BY MONTH(t.order_date)
ORDER BY SUM(t.sales_amount) DESC;
    
    -- sales done year wise --
SELECT 
    YEAR(order_date) AS year, SUM(sales_amount) AS total_sales
FROM
    transactions
GROUP BY YEAR(order_date)
ORDER BY SUM(sales_amount);
    
    