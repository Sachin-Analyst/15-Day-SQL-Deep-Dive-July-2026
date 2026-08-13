SELECT * FROM orders ;

SELECT * FROM customers ;

SELECT * FROM order_items;

-- Your revenue is inflated into x

SELECT SUM(o.sales) AS total_revenue
FROM orders o
JOIN order_items i 
ON i.order_id = o.order_id;

-- true total 

SELECT SUM(sales) AS true_total
FROM orders;


--- WHAT SQL Understood on JOIN 

--- ORDERS TABLE
-- order_id | city   | region | category    | product | sales | cust_id | status    | order_date  
-- 1        |Chennai |	South |	Electronics | Laptop  |	50000 |	1	    | delivered | 2023-06-10

--- ORDER_ITEM TABLE
-- order_id | sales       | item_name          | item_price
-- 1        | 50000       | Laptop             | 42500
-- 1        | 50000       | Extended Warranty  | 7500

-- order_id |(o.sales) |
-- 1        | (100000)  | total_revenue 


-- Fix 

SELECT SUM(order_total) AS total_revenue
FROM (
    SELECT DISTINCT o.order_id, o.sales AS order_total
    FROM orders o
    JOIN order_items i 
    ON i.order_id = o.order_id
) t;

--- ORDERS TABLE

-- order_id | city   | region | category    | product | sales | cust_id | status    | order_date  
-- 1        |Chennai |	South |	Electronics | Laptop  |	50000 |	1	    | delivered | 2023-06-10

--- ORDER_ITEM TABLE
-- order_id | sales       | item_name          | item_price
-- 1        | 50000       | Laptop             | 42500
-- 1        | 50000       | Extended Warranty  | 7500

-- order_id |(o.sales) | order_total
-- 1        | (50000)  |  

-- Bonus: after the join, 
-- which one counts real orders correctly, 
-- COUNT(*) or COUNT(DISTINCT o.order_id)?

SELECT
    COUNT(*) AS row_count_wrong,
    COUNT(DISTINCT o.order_id) AS real_order_count
FROM orders o
JOIN order_items i ON i.order_id = o.order_id;
