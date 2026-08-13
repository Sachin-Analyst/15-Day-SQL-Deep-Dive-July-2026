
-- Initial Database 
SELECT * FROM gdb09072026.orders;

-- Database for this challenge
SELECT * FROM gdb023.fact_sales_monthly;
SELECT * FROM gdb023.dim_product;


-- Your manager wants a report with one row per product and three separate columns, 
-- Jan sales, Feb sales, Mar sales, side by side. A pivot.
-- How do you turn rows into columns in pure SQL, using CASE?

SELECT dp.product_code, dp.product,
    SUM(CASE WHEN MONTH(date)=1 THEN sold_quantity END) AS Jan_sales,
    SUM(CASE WHEN MONTH(date)=2 THEN sold_quantity END) AS Feb_sales,
    SUM(CASE WHEN MONTH(date)=3 THEN sold_quantity END) AS Mar_sales
FROM fact_sales_monthly fs
JOIN dim_product dp ON fs.product_code = dp.product_code
WHERE YEAR(date) = 2021
GROUP BY dp.product_code, dp.variant;

-- CASE
-- WHEN condition THEN result
-- WHEN another_condition THEN another_result
-- ELSE fallback_result
-- END

-- SUM + GROUP BY 


-- EXCLUDE SUM BUT INCLUDE GROUP BY 

SELECT dp.product_code, dp.product,
    (CASE WHEN MONTH(date)=1 THEN sold_quantity END) AS Jan_sales,
    (CASE WHEN MONTH(date)=2 THEN sold_quantity END) AS Feb_sales,
    (CASE WHEN MONTH(date)=3 THEN sold_quantity END) AS Mar_sales
FROM fact_sales_monthly fs
JOIN dim_product dp ON fs.product_code = dp.product_code
WHERE YEAR(date) = 2021
GROUP BY dp.product_code, dp.variant;


-- EXCLUDE GROUP BY INCLUDE SUM 
SELECT dp.product_code, dp.product,
    SUM(CASE WHEN MONTH(date) = 1 THEN sold_quantity END) AS Jan_sales,
    SUM(CASE WHEN MONTH(date) = 2 THEN sold_quantity END) AS Feb_sales,
    SUM(CASE WHEN MONTH(date) = 3 THEN sold_quantity END) AS Mar_sales
FROM fact_sales_monthly fs
JOIN dim_product dp ON fs.product_code = dp.product_code
WHERE YEAR(date) = 2021;


-- GROUP BY
SELECT * FROM gdb023.dim_product;

-- Bonus: a CASE with no matching WHEN and no ELSE, what does it return?


