SELECT * FROM orders;

SELECT COUNT(*) FROM orders;


-- Error: "Invalid use of group function."

SELECT city, SUM(sales) AS Total_sales
FROM orders
GROUP BY city
WHERE Total_sales > 50000;

13:40:56	SELECT city, SUM(sales) AS Total_sales FROM orders GROUP BY city WHERE Total_sales > 50000	Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'WHERE Total_sales > 50000' at line 4	0.000 sec



--- SQL WRITTEN ORDER 
--- SELECT > FROM > WHERE >  GROUP BY > HAVING.


SELECT city, SUM(sales) AS Total_sales
FROM orders
WHERE Total_sales > 50000
GROUP BY city;

13:41:16	SELECT city, SUM(sales) AS Total_sales FROM orders WHERE Total_sales > 50000 GROUP BY city LIMIT 0, 50000	Error Code: 1054. Unknown column 'Total_sales' in 'where clause'	0.000 sec




--- LOGICAL STEP 

---- FROM > WHERE > GROUP BY > AGGREGATION > HAVING > SELECT > ORDER BY / LIMIT 

SELECT city, SUM(sales) AS Total_sales
FROM orders
GROUP BY city
HAVING Total_sales > 50000;


SELECT city ,SUM(sales) as Sales
FROM orders
WHERE city = "Chennai";

SELECT city ,SUM(sales) as Sales
FROM orders
WHERE city = "Bangalore";

SELECT city ,SUM(sales) as Sales
FROM orders
WHERE city = "Hyderabad";


-- Bonus: WHERE region = 'South' vs HAVING region = 'South'. Same answer? And which one is faster?

SELECT region, SUM(sales) AS Total_sales
FROM orders
WHERE region = 'South'
GROUP BY region;


SELECT region, SUM(sales) AS Total_sales
FROM orders
GROUP BY region
HAVING region = 'South';


--- FROM > WHERE > GROUP BY > Aggregation > HAVING > SELECT > ORDER BY/LIMIT BY


SELECT region, SUM(sales) AS Total_sales
FROM orders
WHERE region = 'South'
GROUP BY region;

--- IN orders
--- we have order_id , city  , region , category , product , sales,                  |Aggreation on Sales|
--- Chennai > Bangalore > Hyderabad total  
 

--- region = south
--- 3 cities will be grouped into south
-- Chennai 
-- Bangalore 
-- Hyderabad 

--- Then Aggreation on Sales as Total_sales

--- Output Region , Total sales
-- South Values 




--- FROM > WHERE > GROUP BY > Aggregation > HAVING > SELECT > ORDER BY/LIMIT BY


SELECT region, SUM(sales) AS Total_sales
FROM orders
GROUP BY region
HAVING region = 'South';

--- IN orders
--- we have order_id , city  , region , category , product , sales,           |Aggreation on Sales|

--- It GROUPS BY region 
--- all 144 rows grouped into regions we had

--- Chennai > Bangalore > Hyderabad total > 36 rows in SOUTH 
--- Mumbai , Pune , Ahmedabad total       > 36 rows in WEST
--- Kolkata, Ranchi , Patna , total       > 36 rows in EAST
--- Delhi , Jaipur , Lucknow  total       > 36 rows in NORTH   

--- Then aggregation on sum(sales) as Total sales , pulls the data from sales column and 
--- created new aggregated column

--- Regions
-- South Values


---Then it moves it having South
--- it picks only south and removes other regions

--- and in select output
--- Region ,Total sales
-- South, values


SELECT region, SUM(sales) AS Total_sales FROM orders GROUP BY region HAVING region = 'South' LIMIT 0, 50000
