-- ROW_NUMBER() > 1, 2, 3, 4
-- RANK()       > 1, 2, 2, 4
-- DENSE_RANK() > 1, 2, 2, 3

SELECT s.student_id, s.name, s.marks ,
       ROW_NUMBER() OVER (ORDER BY s.marks   DESC) AS rn,
       RANK()       OVER (ORDER BY s.marks  DESC) AS rnk,
       DENSE_RANK() OVER ( ORDER BY s.marks  DESC) AS drnk
FROM random_tables.student_marks s;




-- Database gdb09072026


-- Which function produces which sequence, 
-- and which one do you use to pick exactly ONE top performer per region?

SELECT * FROM gdb09072026.orders;

SELECT * FROM gdb09072026.customers;

-- FIX QUERY 
SELECT c.region, c.customer, SUM(o.sales) AS total_sales,
       ROW_NUMBER() OVER (PARTITION BY c.region ORDER BY SUM(o.sales) DESC) AS rn,
       RANK()       OVER (PARTITION BY c.region ORDER BY SUM(o.sales) DESC) AS rnk,
       DENSE_RANK() OVER (PARTITION BY c.region ORDER BY SUM(o.sales) DESC) AS drnk
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.region, c.customer
ORDER BY c.region, total_sales DESC;



SELECT * FROM (
    SELECT c.region, c.customer, SUM(o.sales) AS total_sales,
           ROW_NUMBER() OVER (PARTITION BY c.region ORDER BY SUM(o.sales) DESC) AS rn
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    GROUP BY c.region, c.customer
) ranked
WHERE rn = 1;

-- Bonus 

-- Problem Query
SELECT category, product, SUM(sales) AS total_sales
FROM orders
GROUP BY category, product
ORDER BY total_sales DESC
LIMIT 2;


-- Fix 
SELECT * FROM (
    SELECT category, product, SUM(sales) AS total_sales,
           DENSE_RANK() OVER (PARTITION BY category ORDER BY SUM(sales) DESC) AS drnk
    FROM orders
    GROUP BY category, product
) ranked
WHERE drnk <= 2;



