SELECT * FROM fact_gross_price;
 
SELECT Product_code , gross_price * 12 AS annual_revenue
FROM fact_gross_price
WHERE annual_revenue >9000;
 
15:21:37	SELECT Product_code , gross_price * 12 AS annual_revenue FROM fact_gross_price WHERE annual_revenue >9000	Error Code: 1054. Unknown column 'annual_revenue' in 'where clause'	0.000 sec
 
SELECT product_code, gross_price * 12 AS annual_revenue
FROM fact_gross_price
ORDER BY annual_revenue DESC;
 
--- LOGICAL EXECUTION ORDER
--- FROM > WHERE > GROUP BY > HAVING > SELECT > ORDER BY
 
--- fact_gross_price
--- PRODUCT CODE , FISCAL YEAR , GROSS PRICE
 
--- 2 OUTPUTS
--- product_code, (gross_price * 12) ANNUAL REVENUE