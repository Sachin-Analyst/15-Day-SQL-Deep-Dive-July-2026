
SELECT * FROM customers;


SELECT * FROM orders;
-- INSERT INTO orders (customer_id) VALUES (NULL);
SELECT * FROM orders ORDER BY order_id DESC LIMIT 3;

-- Concepts 
--- NULL means Unknown Value
--- AND operator runs Every condition is TRUE 
--- OR operator run either one condition is TRUE
--- WHERE CLAUSE keeps only TRUE condition 
--- IN (OR)
--- NOT IN (AND)

-- Day 6 fix query to show customers who ordered and who doesn't 

SELECT c.customer,c.customer_id, o.order_id, o.status
FROM customers c
LEFT JOIN orders o 
ON c.customer_id = o.customer_id 
AND o.status = 'delivered';


-- Problem Query shows Zero rows. 

SELECT customer
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id FROM orders
);

13:40:05	SELECT customer FROM customers WHERE customer_id NOT IN (     SELECT customer_id FROM orders ) LIMIT 0, 50000	0 row(s) returned	0.000 sec / 0.000 sec


--- Example

--- Orders Table 
-- customer id |
-- 11 
-- 12 
-- NULL 


-- 12 <> 11   > TRUE
-- 12 <> 12   > FALSE   < hits here, chain fails immediately

-- 13 <> 11   > TRUE
-- 13 <> 12   >  TRUE  
-- 13 <> NULL >  UNKNOWN 

-- Fix Query 

SELECT customer, customer_id
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id FROM orders WHERE customer_id IS NOT NULL
);



--- 5 <> NULL     > UNKNOWN
--- 5 > NULL      > UNKNOWN
--- NULL = NULL   > UNKNOWN   (yes, even this one)

-- IS NOT NULL 

-- 11   IS NOT NULL  > TRUE  > keep   
-- 12   IS NOT NULL  > TRUE  > keep  

-- 1 <> 1 > False 

-- 13 <> 11 > TRUE
-- 13 <> 12 > TRUE  


--- Bonus: name the three shapes a subquery can take, 
--- one in SELECT, one in WHERE, one in FROM.

-- SHAPE 1 -- SELECT 
SELECT c.customer,
  (SELECT COUNT(*) FROM orders o WHERE o.customer_id = c.customer_id) AS total_orders
FROM customers c;

-- SHAPE 2 -- WHERE 
SELECT customer, customer_id
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id FROM orders WHERE customer_id IS NOT NULL
);


-- SHAPE 3 -- FROM 

SELECT region, AVG(order_total) AS avg_order_value
FROM (
    SELECT order_id, region, SUM(sales) AS order_total
    FROM orders GROUP BY order_id, region
) t
GROUP BY region; 