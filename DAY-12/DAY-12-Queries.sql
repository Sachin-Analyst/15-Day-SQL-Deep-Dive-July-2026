-- Problem Query
-- How do you put a total next to every row without collapsing the rows into groups?


SELECT * FROM gdb09072026.orders;


-- Requirement 
-- Customer | Sales | % of total


SELECT
    customer_id,SUM(sales) AS sales,
    SUM(sales) / SUM(sales) * 100 AS pct_of_total
FROM gdb09072026.orders
GROUP BY customer_id;

 SELECT customer_id, 
 SUM(sales) sales FROM gdb09072026.orders 
 GROUP BY customer_id ;

-- Fix Query

SELECT
    customer_id,
    SUM(sales) AS customer_sales,
    ROUND(SUM(sales) * 100.0 / SUM(SUM(sales)) OVER (), 2) AS pct_of_total
FROM gdb09072026.orders
GROUP BY customer_id;

SELECT SUM(SUM(sales))
OVER () AS total_sales
FROM orders;

 
-- Bonus: PARTITION BY vs GROUP BY. 
-- One keeps all your rows, one destroys them. Which is which?
