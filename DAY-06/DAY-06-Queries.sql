SELECT * FROM orders;

SELECT * FROM customers;

-- Left join silently becomes Inner Join 

SELECT c.customer, o.order_id
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
WHERE o.status = 'delivered';


--- EXPLANATION 


-- customer status WHERE asks answer

-- Divya Rao > delivered > delivered' = 'delivered' ? YES > keep,

-- Karthik Reddy > pending'pending' = 'delivered' ? NO >  drop,

-- Meera Shah > cancelled'cancelled' = 'delivered' ? NO > drop,

-- Rohan Deshmukh > delivered'delivered' = 'delivered' ? YES > keep

-- Sneha Iyer > NULL 'NULL' = 'delivered' ? Unknown Value  >  drop,

--- That one line > WHERE o.status = 'delivered' > is what turns your LEFT JOIN into an INNER JOIN.



-- FIX

SELECT c.customer, o.order_id, o.status
FROM customers c
LEFT JOIN orders o 
ON c.customer_id = o.customer_id 
AND o.status = 'delivered';

--- AND Displays BOTH TRUE 

--- Divya Rao > TRUE > TRUE Result >TRUE
--- Karthik Reddy TRUE > pending > False > Result > False

--- Sneha Iyer NULL > NULL > We cannot say > DROP 


-- Bonus: 100 customers, 30 never ordered. 
-- You LEFT JOIN then add WHERE o.order_date > '2024-01-01'. Roughly how many customers survive?

SELECT c.customer, o.order_id, o.status
FROM customers c
LEFT JOIN orders o 
ON c.customer_id = o.customer_id 
WHERE o.order_date > '2024-01-01';
 
--- 152 rows WITH NULL 
--- Remaining 144 rows 

13:24:53	SELECT c.customer, o.order_id, o.status FROM customers c LEFT JOIN orders o  ON c.customer_id = o.customer_id  WHERE o.order_date > '2024-01-01' LIMIT 0, 50000	121 row(s) returned	0.000 sec / 0.000 sec


