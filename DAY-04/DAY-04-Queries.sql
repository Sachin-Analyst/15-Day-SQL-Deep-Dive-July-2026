SELECT * FROM orders;

SELECT COUNT(*) AS TOTAL_ROW_count FROM orders;

-- In MySQL it runs. It shows one product per city. Looks fine.

SELECT city, product , SUM(sales) Total_sales
FROM orders
GROUP BY city;



SELECT * FROM orders
WHERE city = "Chennai";





# Requirement is that 

-- 1. I need city  
-- Chennai 

-- 2. I need each product breakdown 
--- Chennai > Laptop, Chennai > Mouse, etc.

-- 3. I need product total sales       
--- Chennai > Laptop > subtotal, Chennai > Mouse > subtotal

-- 4. I need one final total           
--- sum of all products combined






SELECT city, product , SUM(sales) Total_sales
FROM orders
WHERE city = "Chennai"
GROUP BY city, product WITH ROLLUP
;



SELECT city, product , SUM(sales) Total_sales
FROM orders
GROUP BY city, product WITH ROLLUP
;

--- In Chennai we have three category 
--- Electronics
--- Groceries
--- Clothing


--- Each Category has different rows  
--- Electronics
--- laptop 1 + 2 98000
--- Mouse 1+2 1050 

--- Groceries
--- Rice bag 1+2  1650
--- Biscuits 1+2  330

--- Clothing 
--- T Shirt 1+2 2500
--- Jeans 1+2  4300

--- Total sales 107830 



SELECT city, product , SUM(sales) Total_sales
FROM orders
GROUP BY city, product WITH ROLLUP
;


-- Bonus: you need totals per city AND per city+category.Can one GROUP BY give you both?


SELECT city, category , SUM(sales) Total_sales
FROM orders
GROUP BY city, category WITH ROLLUP
;

