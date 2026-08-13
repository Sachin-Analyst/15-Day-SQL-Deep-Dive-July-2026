-- A running total

-- 3-month moving


--- Database for this challenge

SELECT * FROM gdb023.fact_sales_monthly;


# Flat Total
WITH monthly_sales_summary AS (
    SELECT
        s.date,
        SUM(s.sold_quantity * g.gross_price) AS monthly_sales
    FROM fact_sales_monthly s
    JOIN fact_gross_price g
        ON s.product_code = g.product_code
        AND s.fiscal_year = g.fiscal_year
    GROUP BY s.date
)
SELECT
    date,
    ROUND(monthly_sales / 1000000, 2) AS monthly_sales_M,
    ROUND(SUM(monthly_sales) OVER () / 1000000, 2) AS flat_total_M
FROM monthly_sales_summary
ORDER BY date;


#Fix Query

WITH monthly_sales_summary AS (
    SELECT
        s.date,
        SUM(s.sold_quantity * g.gross_price) AS monthly_sales
    FROM fact_sales_monthly s
    JOIN fact_gross_price g
        ON s.product_code = g.product_code
        AND s.fiscal_year = g.fiscal_year
    GROUP BY s.date
)
SELECT
    date,
    ROUND(monthly_sales / 1000000, 2) AS monthly_sales_M,
    ROUND(SUM(monthly_sales) OVER (ORDER BY date) / 1000000, 2) AS running_total_M,
    ROUND(AVG(monthly_sales) OVER (
        ORDER BY date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) / 1000000, 2) AS moving_avg_3m_M
FROM monthly_sales_summary
ORDER BY date;